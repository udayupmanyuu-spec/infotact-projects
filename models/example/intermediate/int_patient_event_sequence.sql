WITH patient_events AS (

    SELECT case_id, activity_name, event_timestamp, department, waiting_time_min, duration_min event_sequence,
        LEAD(activity_name) OVER (
            PARTITION BY case_id
            ORDER BY event_timestamp, event_sequence
        ) AS next_activity,

        LEAD(event_timestamp) OVER (
            PARTITION BY case_id
            ORDER BY event_timestamp, event_sequence
        ) AS next_event_timestamp

    FROM {{ ref('stg_careflow_events') }}

)

SELECT *, TIMESTAMP_DIFF(next_event_timestamp, event_timestamp, MINUTE) 
    AS transition_time_min,

    CONCAT(activity_name, ' → ', COALESCE(next_activity, 'End')) AS process_transition
FROM patient_events
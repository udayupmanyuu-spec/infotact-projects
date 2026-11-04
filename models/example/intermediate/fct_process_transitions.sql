WITH transition_data AS (

    SELECT *
    FROM {{ ref('int_patient_event_sequence') }}
    WHERE next_activity IS NOT NULL

)

SELECT activity_name, next_activity, process_transition, COUNT(*) AS transition_count, 
    COUNT(DISTINCT case_id) AS unique_patients,

    ROUND(AVG(transition_time_min), 2)
        AS avg_transition_time_min,

    ROUND(MIN(transition_time_min), 2)
        AS min_transition_time_min,

    ROUND(MAX(transition_time_min), 2)
        AS max_transition_time_min

FROM transition_data

GROUP BY
    activity_name,
    next_activity,
    process_transition

ORDER BY transition_count DESC
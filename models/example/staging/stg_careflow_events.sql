WITH source_data AS (

    SELECT *
    FROM {{ source('careflow_raw', 'careflow_events_as_is') }}

),

cleaned_data AS (

    SELECT
        TRIM(CAST(Case_ID AS STRING)) AS case_id,
        TRIM(CAST(Activity_Name AS STRING)) AS activity_name,
        SAFE_CAST(Timestamp AS TIMESTAMP) AS event_timestamp,
        TRIM(CAST(Department AS STRING)) AS department,
        TRIM(CAST(Resource AS STRING)) AS resource,
        SAFE_CAST(Waiting_Time_Min AS FLOAT64) AS waiting_time_min,
        SAFE_CAST(Duration_Min AS FLOAT64) AS duration_min,
        TRIM(CAST(Patient_Type AS STRING)) AS patient_type,
        TRIM(CAST(Triage_Level AS STRING)) AS triage_level,
        SAFE_CAST(Event_Sequence AS INT64) AS event_sequence,
        SAFE_CAST(Is_Revisit AS BOOL) AS is_revisit,
        SAFE_CAST(Loop_Back_Flag AS BOOL) AS loop_back_flag,
        TRIM(CAST(Outcome AS STRING)) AS outcome,
        TRIM(CAST(Scenario AS STRING)) AS scenario,
        TRIM(CAST(Data_Origin AS STRING)) AS data_origin

    FROM source_data

)

SELECT *
FROM cleaned_data
WHERE case_id IS NOT NULL
  AND activity_name IS NOT NULL
  AND event_timestamp IS NOT NULL










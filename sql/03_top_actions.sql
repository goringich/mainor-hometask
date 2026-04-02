-- Отчет 3.
-- TOP-3 действий, вызывающих наибольшие средние значения пульса и давления
-- у пациента с patient_id = 1 за период 2026-03-10 -- 2026-03-19.

SELECT
    a.action_name,
    ROUND(AVG(e.pulse), 2) AS avg_pulse,
    ROUND(AVG(e.systolic_pressure), 2) AS avg_systolic_pressure,
    ROUND(AVG(e.diastolic_pressure), 2) AS avg_diastolic_pressure
FROM self_control_entries e
JOIN actions a ON a.action_id = e.action_id
WHERE e.patient_id = 1
  AND date(e.entry_datetime) BETWEEN '2026-03-10' AND '2026-03-19'
GROUP BY a.action_id, a.action_name
ORDER BY avg_pulse DESC, avg_systolic_pressure DESC
LIMIT 3;

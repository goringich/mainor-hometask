-- Отчет 2.
-- Три даты наиболее плохого самочувствия по показателю "Самочувствие"
-- для пациента с patient_id = 1 за период 2026-03-10 -- 2026-03-19.

SELECT
    date(entry_datetime) AS observation_date,
    wellbeing_score
FROM self_control_entries
WHERE patient_id = 1
  AND date(entry_datetime) BETWEEN '2026-03-10' AND '2026-03-19'
ORDER BY wellbeing_score ASC, observation_date ASC
LIMIT 3;

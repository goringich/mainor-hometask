-- Отчет 1.
-- Набор данных для построения графика изменения объективного показателя.
-- Пример: динамика пульса пациента с patient_id = 1 за период 2026-03-10 -- 2026-03-19.

SELECT
    entry_datetime AS observation_time,
    pulse
FROM self_control_entries
WHERE patient_id = 1
  AND date(entry_datetime) BETWEEN '2026-03-10' AND '2026-03-19'
ORDER BY entry_datetime;

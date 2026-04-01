SELECT s.full_name AS student_name,
       ROUND(AVG(e.progress_percent), 2) AS avg_progress,
       COUNT(e.enrollment_id) AS courses_count
FROM students s
JOIN enrollments e ON e.student_id = s.student_id
GROUP BY s.student_id, s.full_name
ORDER BY avg_progress DESC, courses_count DESC, s.full_name;
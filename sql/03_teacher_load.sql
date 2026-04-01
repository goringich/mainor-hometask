SELECT t.full_name AS teacher_name,
       c.title AS course_title,
       COUNT(l.lesson_id) AS lessons_count,
       SUM(l.duration_minutes) AS total_duration_minutes
FROM teachers t
JOIN courses c ON c.teacher_id = t.teacher_id
LEFT JOIN lessons l ON l.course_id = c.course_id
GROUP BY t.teacher_id, t.full_name, c.course_id, c.title
ORDER BY t.full_name, c.title;
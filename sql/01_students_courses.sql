SELECT s.full_name AS student_name,
       c.title AS course_title,
       e.enrollment_date,
       e.progress_percent,
       e.completion_status
FROM enrollments e
JOIN students s ON s.student_id = e.student_id
JOIN courses c ON c.course_id = e.course_id
ORDER BY s.full_name, c.title;
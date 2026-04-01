-- 01_students_courses.sql
SELECT s.full_name AS student_name,
       c.title AS course_title,
       e.enrollment_date,
       e.progress_percent,
       e.completion_status
FROM enrollments e
JOIN students s ON s.student_id = e.student_id
JOIN courses c ON c.course_id = e.course_id
ORDER BY s.full_name, c.title;

-- 02_course_revenue.sql
SELECT c.title AS course_title,
       COUNT(e.enrollment_id) AS enrollments_count,
       COALESCE(SUM(CASE WHEN p.payment_status = 'paid' THEN p.amount ELSE 0 END), 0) AS paid_revenue
FROM courses c
LEFT JOIN enrollments e ON e.course_id = c.course_id
LEFT JOIN payments p ON p.enrollment_id = e.enrollment_id
GROUP BY c.course_id, c.title
ORDER BY paid_revenue DESC, c.title;

-- 03_teacher_load.sql
SELECT t.full_name AS teacher_name,
       c.title AS course_title,
       COUNT(l.lesson_id) AS lessons_count,
       SUM(l.duration_minutes) AS total_duration_minutes
FROM teachers t
JOIN courses c ON c.teacher_id = t.teacher_id
LEFT JOIN lessons l ON l.course_id = c.course_id
GROUP BY t.teacher_id, t.full_name, c.course_id, c.title
ORDER BY t.full_name, c.title;

-- 04_payment_status.sql
SELECT s.full_name AS student_name,
       c.title AS course_title,
       p.amount,
       p.payment_method,
       p.payment_status
FROM payments p
JOIN enrollments e ON e.enrollment_id = p.enrollment_id
JOIN students s ON s.student_id = e.student_id
JOIN courses c ON c.course_id = e.course_id
ORDER BY p.payment_status, s.full_name;

-- 05_top_students.sql
SELECT s.full_name AS student_name,
       ROUND(AVG(e.progress_percent), 2) AS avg_progress,
       COUNT(e.enrollment_id) AS courses_count
FROM students s
JOIN enrollments e ON e.student_id = s.student_id
GROUP BY s.student_id, s.full_name
ORDER BY avg_progress DESC, courses_count DESC, s.full_name;
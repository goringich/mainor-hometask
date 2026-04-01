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
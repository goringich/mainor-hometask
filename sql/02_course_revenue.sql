SELECT c.title AS course_title,
       COUNT(e.enrollment_id) AS enrollments_count,
       COALESCE(SUM(CASE WHEN p.payment_status = 'paid' THEN p.amount ELSE 0 END), 0) AS paid_revenue
FROM courses c
LEFT JOIN enrollments e ON e.course_id = c.course_id
LEFT JOIN payments p ON p.enrollment_id = e.enrollment_id
GROUP BY c.course_id, c.title
ORDER BY paid_revenue DESC, c.title;
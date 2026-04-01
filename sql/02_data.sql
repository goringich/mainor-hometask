INSERT INTO students VALUES
  (1, 'Ivan Petrov', 'ivan.petrov@example.com', '+79990000001', '2025-09-01', 'active'),
  (2, 'Anna Smirnova', 'anna.smirnova@example.com', '+79990000002', '2025-09-03', 'active'),
  (3, 'Pavel Orlov', 'pavel.orlov@example.com', '+79990000003', '2025-09-05', 'inactive'),
  (4, 'Maria Volkova', 'maria.volkova@example.com', '+79990000004', '2025-09-08', 'active'),
  (5, 'Egor Sokolov', 'egor.sokolov@example.com', '+79990000005', '2025-09-10', 'active');

INSERT INTO teachers VALUES
  (1, 'Olga Romanova', 'olga.romanova@example.com', 'Databases', '2024-02-10'),
  (2, 'Dmitry Fedorov', 'dmitry.fedorov@example.com', 'Python', '2024-03-15'),
  (3, 'Elena Morozova', 'elena.morozova@example.com', 'Web Development', '2024-04-20');

INSERT INTO courses VALUES
  (1, 'SQL Basics', 'Databases', 'beginner', 12000, 1, '2025-10-01', '2025-11-15'),
  (2, 'Python for Analytics', 'Programming', 'intermediate', 18000, 2, '2025-10-05', '2025-12-01'),
  (3, 'Frontend Start', 'Web Development', 'beginner', 15000, 3, '2025-10-07', '2025-11-25'),
  (4, 'Advanced SQL Reports', 'Databases', 'advanced', 22000, 1, '2025-11-01', '2025-12-20');

INSERT INTO lessons VALUES
  (1, 1, 'Introduction to SQL', '2025-10-01', 90, 'online'),
  (2, 1, 'SELECT and WHERE', '2025-10-03', 90, 'online'),
  (3, 2, 'NumPy Basics', '2025-10-05', 120, 'online'),
  (4, 2, 'Pandas Tables', '2025-10-08', 120, 'online'),
  (5, 3, 'HTML Structure', '2025-10-07', 100, 'offline'),
  (6, 3, 'CSS Basics', '2025-10-10', 100, 'offline'),
  (7, 4, 'Window Functions', '2025-11-01', 110, 'online'),
  (8, 4, 'CTE and Reports', '2025-11-05', 110, 'online');

INSERT INTO enrollments VALUES
  (1, 1, 1, '2025-09-20', 100, 'completed'),
  (2, 1, 2, '2025-09-21', 65, 'in_progress'),
  (3, 2, 1, '2025-09-22', 80, 'in_progress'),
  (4, 2, 3, '2025-09-23', 100, 'completed'),
  (5, 3, 3, '2025-09-24', 20, 'dropped'),
  (6, 4, 2, '2025-09-25', 90, 'in_progress'),
  (7, 4, 4, '2025-09-26', 40, 'in_progress'),
  (8, 5, 1, '2025-09-27', 100, 'completed'),
  (9, 5, 4, '2025-09-28', 50, 'in_progress');

INSERT INTO payments VALUES
  (1, 1, '2025-09-20', 12000, 'card', 'paid'),
  (2, 2, '2025-09-21', 18000, 'card', 'paid'),
  (3, 3, '2025-09-22', 12000, 'transfer', 'pending'),
  (4, 4, '2025-09-23', 15000, 'cash', 'paid'),
  (5, 5, '2025-09-24', 15000, 'card', 'refunded'),
  (6, 6, '2025-09-25', 18000, 'transfer', 'paid'),
  (7, 7, '2025-09-26', 22000, 'card', 'paid'),
  (8, 8, '2025-09-27', 12000, 'cash', 'paid'),
  (9, 9, '2025-09-28', 22000, 'transfer', 'pending');
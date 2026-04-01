BEGIN TRANSACTION;
CREATE TABLE courses (
  course_id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  category TEXT NOT NULL,
  level TEXT NOT NULL CHECK (level IN ('beginner','intermediate','advanced')),
  price NUMERIC NOT NULL CHECK (price >= 0),
  teacher_id INTEGER NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  FOREIGN KEY (teacher_id) REFERENCES teachers(teacher_id)
);
INSERT INTO "courses" VALUES(1,'SQL Basics','Databases','beginner',12000,1,'2025-10-01','2025-11-15');
INSERT INTO "courses" VALUES(2,'Python for Analytics','Programming','intermediate',18000,2,'2025-10-05','2025-12-01');
INSERT INTO "courses" VALUES(3,'Frontend Start','Web Development','beginner',15000,3,'2025-10-07','2025-11-25');
INSERT INTO "courses" VALUES(4,'Advanced SQL Reports','Databases','advanced',22000,1,'2025-11-01','2025-12-20');
CREATE TABLE enrollments (
  enrollment_id INTEGER PRIMARY KEY,
  student_id INTEGER NOT NULL,
  course_id INTEGER NOT NULL,
  enrollment_date DATE NOT NULL,
  progress_percent INTEGER NOT NULL CHECK (progress_percent BETWEEN 0 AND 100),
  completion_status TEXT NOT NULL CHECK (completion_status IN ('in_progress','completed','dropped')),
  UNIQUE (student_id, course_id),
  FOREIGN KEY (student_id) REFERENCES students(student_id),
  FOREIGN KEY (course_id) REFERENCES courses(course_id)
);
INSERT INTO "enrollments" VALUES(1,1,1,'2025-09-20',100,'completed');
INSERT INTO "enrollments" VALUES(2,1,2,'2025-09-21',65,'in_progress');
INSERT INTO "enrollments" VALUES(3,2,1,'2025-09-22',80,'in_progress');
INSERT INTO "enrollments" VALUES(4,2,3,'2025-09-23',100,'completed');
INSERT INTO "enrollments" VALUES(5,3,3,'2025-09-24',20,'dropped');
INSERT INTO "enrollments" VALUES(6,4,2,'2025-09-25',90,'in_progress');
INSERT INTO "enrollments" VALUES(7,4,4,'2025-09-26',40,'in_progress');
INSERT INTO "enrollments" VALUES(8,5,1,'2025-09-27',100,'completed');
INSERT INTO "enrollments" VALUES(9,5,4,'2025-09-28',50,'in_progress');
CREATE TABLE lessons (
  lesson_id INTEGER PRIMARY KEY,
  course_id INTEGER NOT NULL,
  lesson_title TEXT NOT NULL,
  lesson_date DATE NOT NULL,
  duration_minutes INTEGER NOT NULL CHECK (duration_minutes > 0),
  format TEXT NOT NULL CHECK (format IN ('online','offline')),
  FOREIGN KEY (course_id) REFERENCES courses(course_id)
);
INSERT INTO "lessons" VALUES(1,1,'Introduction to SQL','2025-10-01',90,'online');
INSERT INTO "lessons" VALUES(2,1,'SELECT and WHERE','2025-10-03',90,'online');
INSERT INTO "lessons" VALUES(3,2,'NumPy Basics','2025-10-05',120,'online');
INSERT INTO "lessons" VALUES(4,2,'Pandas Tables','2025-10-08',120,'online');
INSERT INTO "lessons" VALUES(5,3,'HTML Structure','2025-10-07',100,'offline');
INSERT INTO "lessons" VALUES(6,3,'CSS Basics','2025-10-10',100,'offline');
INSERT INTO "lessons" VALUES(7,4,'Window Functions','2025-11-01',110,'online');
INSERT INTO "lessons" VALUES(8,4,'CTE and Reports','2025-11-05',110,'online');
CREATE TABLE payments (
  payment_id INTEGER PRIMARY KEY,
  enrollment_id INTEGER NOT NULL,
  payment_date DATE NOT NULL,
  amount NUMERIC NOT NULL CHECK (amount >= 0),
  payment_method TEXT NOT NULL CHECK (payment_method IN ('card','cash','transfer')),
  payment_status TEXT NOT NULL CHECK (payment_status IN ('paid','pending','refunded')),
  FOREIGN KEY (enrollment_id) REFERENCES enrollments(enrollment_id)
);
INSERT INTO "payments" VALUES(1,1,'2025-09-20',12000,'card','paid');
INSERT INTO "payments" VALUES(2,2,'2025-09-21',18000,'card','paid');
INSERT INTO "payments" VALUES(3,3,'2025-09-22',12000,'transfer','pending');
INSERT INTO "payments" VALUES(4,4,'2025-09-23',15000,'cash','paid');
INSERT INTO "payments" VALUES(5,5,'2025-09-24',15000,'card','refunded');
INSERT INTO "payments" VALUES(6,6,'2025-09-25',18000,'transfer','paid');
INSERT INTO "payments" VALUES(7,7,'2025-09-26',22000,'card','paid');
INSERT INTO "payments" VALUES(8,8,'2025-09-27',12000,'cash','paid');
INSERT INTO "payments" VALUES(9,9,'2025-09-28',22000,'transfer','pending');
CREATE TABLE students (
  student_id INTEGER PRIMARY KEY,
  full_name TEXT NOT NULL,
  email TEXT NOT NULL UNIQUE,
  phone TEXT,
  registration_date DATE NOT NULL,
  status TEXT NOT NULL CHECK (status IN ('active','inactive'))
);
INSERT INTO "students" VALUES(1,'Ivan Petrov','ivan.petrov@example.com','+79990000001','2025-09-01','active');
INSERT INTO "students" VALUES(2,'Anna Smirnova','anna.smirnova@example.com','+79990000002','2025-09-03','active');
INSERT INTO "students" VALUES(3,'Pavel Orlov','pavel.orlov@example.com','+79990000003','2025-09-05','inactive');
INSERT INTO "students" VALUES(4,'Maria Volkova','maria.volkova@example.com','+79990000004','2025-09-08','active');
INSERT INTO "students" VALUES(5,'Egor Sokolov','egor.sokolov@example.com','+79990000005','2025-09-10','active');
CREATE TABLE teachers (
  teacher_id INTEGER PRIMARY KEY,
  full_name TEXT NOT NULL,
  email TEXT NOT NULL UNIQUE,
  specialization TEXT NOT NULL,
  hire_date DATE NOT NULL
);
INSERT INTO "teachers" VALUES(1,'Olga Romanova','olga.romanova@example.com','Databases','2024-02-10');
INSERT INTO "teachers" VALUES(2,'Dmitry Fedorov','dmitry.fedorov@example.com','Python','2024-03-15');
INSERT INTO "teachers" VALUES(3,'Elena Morozova','elena.morozova@example.com','Web Development','2024-04-20');
COMMIT;
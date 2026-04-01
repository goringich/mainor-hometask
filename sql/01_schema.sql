PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS enrollments;
DROP TABLE IF EXISTS lessons;
DROP TABLE IF EXISTS courses;
DROP TABLE IF EXISTS teachers;
DROP TABLE IF EXISTS students;

CREATE TABLE students (
  student_id INTEGER PRIMARY KEY,
  full_name TEXT NOT NULL,
  email TEXT NOT NULL UNIQUE,
  phone TEXT,
  registration_date DATE NOT NULL,
  status TEXT NOT NULL CHECK (status IN ('active','inactive'))
);

CREATE TABLE teachers (
  teacher_id INTEGER PRIMARY KEY,
  full_name TEXT NOT NULL,
  email TEXT NOT NULL UNIQUE,
  specialization TEXT NOT NULL,
  hire_date DATE NOT NULL
);

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

CREATE TABLE lessons (
  lesson_id INTEGER PRIMARY KEY,
  course_id INTEGER NOT NULL,
  lesson_title TEXT NOT NULL,
  lesson_date DATE NOT NULL,
  duration_minutes INTEGER NOT NULL CHECK (duration_minutes > 0),
  format TEXT NOT NULL CHECK (format IN ('online','offline')),
  FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

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

CREATE TABLE payments (
  payment_id INTEGER PRIMARY KEY,
  enrollment_id INTEGER NOT NULL,
  payment_date DATE NOT NULL,
  amount NUMERIC NOT NULL CHECK (amount >= 0),
  payment_method TEXT NOT NULL CHECK (payment_method IN ('card','cash','transfer')),
  payment_status TEXT NOT NULL CHECK (payment_status IN ('paid','pending','refunded')),
  FOREIGN KEY (enrollment_id) REFERENCES enrollments(enrollment_id)
);
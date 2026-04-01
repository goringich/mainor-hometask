# Описание схемы БД

Предметная область: онлайн-школа.

## students

| Имя атрибута | Тип атрибута | Ограничение | Описание атрибута |
|---|---|---|---|
| student_id | INTEGER | PRIMARY KEY | Уникальный идентификатор студента |
| full_name | TEXT | NOT NULL | ФИО студента |
| email | TEXT | NOT NULL, UNIQUE | Электронная почта |
| phone | TEXT | - | Номер телефона |
| registration_date | DATE | NOT NULL | Дата регистрации |
| status | TEXT | NOT NULL, CHECK | Статус студента |

## teachers

| Имя атрибута | Тип атрибута | Ограничение | Описание атрибута |
|---|---|---|---|
| teacher_id | INTEGER | PRIMARY KEY | Уникальный идентификатор преподавателя |
| full_name | TEXT | NOT NULL | ФИО преподавателя |
| email | TEXT | NOT NULL, UNIQUE | Электронная почта |
| specialization | TEXT | NOT NULL | Специализация |
| hire_date | DATE | NOT NULL | Дата найма |

## courses

| Имя атрибута | Тип атрибута | Ограничение | Описание атрибута |
|---|---|---|---|
| course_id | INTEGER | PRIMARY KEY | Уникальный идентификатор курса |
| title | TEXT | NOT NULL | Название курса |
| category | TEXT | NOT NULL | Категория курса |
| level | TEXT | NOT NULL, CHECK | Уровень сложности |
| price | NUMERIC | NOT NULL, CHECK | Стоимость курса |
| teacher_id | INTEGER | NOT NULL, FOREIGN KEY | Преподаватель курса |
| start_date | DATE | NOT NULL | Дата начала курса |
| end_date | DATE | NOT NULL | Дата окончания курса |

## lessons

| Имя атрибута | Тип атрибута | Ограничение | Описание атрибута |
|---|---|---|---|
| lesson_id | INTEGER | PRIMARY KEY | Уникальный идентификатор занятия |
| course_id | INTEGER | NOT NULL, FOREIGN KEY | Курс, к которому относится занятие |
| lesson_title | TEXT | NOT NULL | Тема занятия |
| lesson_date | DATE | NOT NULL | Дата занятия |
| duration_minutes | INTEGER | NOT NULL, CHECK | Длительность в минутах |
| format | TEXT | NOT NULL, CHECK | Формат занятия |

## enrollments

| Имя атрибута | Тип атрибута | Ограничение | Описание атрибута |
|---|---|---|---|
| enrollment_id | INTEGER | PRIMARY KEY | Уникальный идентификатор записи о зачислении |
| student_id | INTEGER | NOT NULL, FOREIGN KEY | Студент |
| course_id | INTEGER | NOT NULL, FOREIGN KEY | Курс |
| enrollment_date | DATE | NOT NULL | Дата записи на курс |
| progress_percent | INTEGER | NOT NULL, CHECK | Прогресс прохождения курса |
| completion_status | TEXT | NOT NULL, CHECK | Статус прохождения |

## payments

| Имя атрибута | Тип атрибута | Ограничение | Описание атрибута |
|---|---|---|---|
| payment_id | INTEGER | PRIMARY KEY | Уникальный идентификатор платежа |
| enrollment_id | INTEGER | NOT NULL, FOREIGN KEY | Связь с записью о зачислении |
| payment_date | DATE | NOT NULL | Дата платежа |
| amount | NUMERIC | NOT NULL, CHECK | Сумма платежа |
| payment_method | TEXT | NOT NULL, CHECK | Способ оплаты |
| payment_status | TEXT | NOT NULL, CHECK | Статус платежа |

## Связи

- Один преподаватель ведет много курсов.
- Один курс содержит много занятий.
- Один студент может быть записан на много курсов.
- Связь студентов и курсов реализована таблицей `enrollments`.
- Для каждой записи о зачислении может существовать платеж.
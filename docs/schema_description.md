# Описание схемы БД

Предметная область: система «Электронный дневник медицинского самоконтроля» (ЭДМС).

## doctors

| Имя атрибута | Тип атрибута | Ограничение | Описание атрибута |
|---|---|---|---|
| doctor_id | INTEGER | PRIMARY KEY | Уникальный идентификатор врача |
| full_name | TEXT | NOT NULL | ФИО врача |
| specialization | TEXT | NOT NULL | Специализация врача |
| email | TEXT | NOT NULL, UNIQUE | Электронная почта врача |
| phone | TEXT | NOT NULL | Контактный телефон врача |
| hire_date | DATE | NOT NULL | Дата приема на работу |

## patients

| Имя атрибута | Тип атрибута | Ограничение | Описание атрибута |
|---|---|---|---|
| patient_id | INTEGER | PRIMARY KEY | Уникальный идентификатор пациента |
| full_name | TEXT | NOT NULL | ФИО пациента |
| birth_date | DATE | NOT NULL | Дата рождения пациента |
| gender | TEXT | NOT NULL, CHECK | Пол пациента |
| phone | TEXT | NOT NULL | Контактный телефон пациента |
| email | TEXT | NOT NULL, UNIQUE | Электронная почта пациента |
| registration_date | DATE | NOT NULL | Дата регистрации в ЭДМС |
| assigned_doctor_id | INTEGER | NOT NULL, FOREIGN KEY | Лечащий врач пациента |

## actions

| Имя атрибута | Тип атрибута | Ограничение | Описание атрибута |
|---|---|---|---|
| action_id | INTEGER | PRIMARY KEY | Уникальный идентификатор действия |
| action_name | TEXT | NOT NULL, UNIQUE | Наименование действия самоконтроля |
| action_type | TEXT | NOT NULL, CHECK | Тип действия: physical или intellectual |
| intensity_level | TEXT | NOT NULL, CHECK | Уровень интенсивности действия |
| description | TEXT | - | Краткое описание действия |

## symptoms

| Имя атрибута | Тип атрибута | Ограничение | Описание атрибута |
|---|---|---|---|
| symptom_id | INTEGER | PRIMARY KEY | Уникальный идентификатор симптома |
| symptom_name | TEXT | NOT NULL, UNIQUE | Наименование симптома |
| symptom_type | TEXT | NOT NULL, CHECK | Тип симптома |
| severity_scale | TEXT | NOT NULL | Шкала оценки выраженности |
| description | TEXT | - | Текстовое описание симптома |

## self_control_entries

| Имя атрибута | Тип атрибута | Ограничение | Описание атрибута |
|---|---|---|---|
| entry_id | INTEGER | PRIMARY KEY | Уникальный идентификатор записи самоконтроля |
| patient_id | INTEGER | NOT NULL, FOREIGN KEY | Пациент, к которому относится запись |
| action_id | INTEGER | NOT NULL, FOREIGN KEY | Выполняемое действие |
| symptom_id | INTEGER | NOT NULL, FOREIGN KEY | Основной симптом, зафиксированный в записи |
| entry_datetime | TEXT | NOT NULL | Дата и время наблюдения |
| wellbeing_score | INTEGER | NOT NULL, CHECK | Субъективная оценка самочувствия по шкале 1-5 |
| pulse | INTEGER | NOT NULL, CHECK | Значение пульса |
| systolic_pressure | INTEGER | NOT NULL, CHECK | Систолическое давление |
| diastolic_pressure | INTEGER | NOT NULL, CHECK | Диастолическое давление |
| temperature | NUMERIC | NOT NULL, CHECK | Температура тела |
| data_source | TEXT | NOT NULL, CHECK | Источник данных: manual или sensor |
| notes | TEXT | - | Примечание пациента или системы |

## report_history

| Имя атрибута | Тип атрибута | Ограничение | Описание атрибута |
|---|---|---|---|
| report_id | INTEGER | PRIMARY KEY | Уникальный идентификатор факта формирования отчета |
| patient_id | INTEGER | NOT NULL, FOREIGN KEY | Пациент, по которому формируется отчет |
| doctor_id | INTEGER | NOT NULL, FOREIGN KEY | Врач-получатель отчета |
| report_type | TEXT | NOT NULL, CHECK | Тип сформированного отчета |
| period_start | DATE | NOT NULL | Начало анализируемого периода |
| period_end | DATE | NOT NULL | Конец анализируемого периода |
| generated_at | TEXT | NOT NULL | Дата и время формирования отчета |
| delivery_status | TEXT | NOT NULL, CHECK | Статус отправки/доставки отчета |

## Связи

- Один врач может быть закреплен за несколькими пациентами.
- Один пациент может иметь много записей самоконтроля.
- Одно действие может встречаться во многих записях самоконтроля.
- Один симптом может повторяться в нескольких записях самоконтроля.
- По одному пациенту может быть сформировано много отчетов, адресованных врачу.

# Задание 3. Макеты пользовательских интерфейсов

Система: электронный дневник самоконтроля.

## Состав макетов

1. Справочник действий.
2. Новая запись самоконтроля.
3. Формирование отчетов.

## Экран 1. Справочник действий

Назначение: ведение классификатора действий, которые используются при заполнении дневника.

Связь с БД:

| Элемент интерфейса | Таблица | Поля |
|---|---|---|
| Список действий | `actions` | `action_id`, `action_name`, `action_type`, `intensity_level`, `description` |
| Форма действия | `actions` | `action_name`, `action_type`, `intensity_level`, `description` |
| Фильтры | `actions` | `action_type`, `intensity_level` |

## Экран 2. Новая запись самоконтроля

Назначение: ввод данных ежедневного наблюдения.

Связь с БД:

| Элемент интерфейса | Таблица | Поля |
|---|---|---|
| Выбор пользователя | `patients` | `patient_id`, `full_name` |
| Выбор действия | `actions` | `action_id`, `action_name` |
| Выбор симптома | `symptoms` | `symptom_id`, `symptom_name` |
| Показатели состояния | `self_control_entries` | `wellbeing_score`, `pulse`, `systolic_pressure`, `diastolic_pressure`, `temperature` |
| Дата, источник, примечание | `self_control_entries` | `entry_datetime`, `data_source`, `notes` |

## Экран 3. Формирование отчетов

Назначение: выбор пользователя, периода и типа отчета.

Связь с БД:

| Элемент интерфейса | Таблица | Поля |
|---|---|---|
| Пользователь | `patients` | `patient_id`, `full_name` |
| Получатель отчета | `doctors` | `doctor_id`, `full_name`, `specialization`, `email` |
| История отчета | `report_history` | `report_type`, `period_start`, `period_end`, `generated_at`, `delivery_status` |
| Данные отчета | `self_control_entries`, `actions` | показатели самоконтроля и действия |

## Итог

Макеты закрывают три требования задания: справочник, операционный ввод и отчеты. Полный HTML-прототип находится в `docs/task3_ui_mockups.html`.

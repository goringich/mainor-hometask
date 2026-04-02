BEGIN TRANSACTION;
CREATE TABLE actions (
    action_id INTEGER PRIMARY KEY,
    action_name TEXT NOT NULL UNIQUE,
    action_type TEXT NOT NULL CHECK (action_type IN ('physical', 'intellectual')),
    intensity_level TEXT NOT NULL CHECK (intensity_level IN ('low', 'medium', 'high')),
    description TEXT
);
INSERT INTO "actions" VALUES(1,'Бег','physical','high','Кардионагрузка высокой интенсивности');
INSERT INTO "actions" VALUES(2,'Ходьба','physical','medium','Умеренная физическая активность');
INSERT INTO "actions" VALUES(3,'Гимнастика','physical','medium','Комплекс лечебной гимнастики');
INSERT INTO "actions" VALUES(4,'Чтение','intellectual','low','Интеллектуальная деятельность в покое');
INSERT INTO "actions" VALUES(5,'Работа за компьютером','intellectual','medium','Длительная зрительная и интеллектуальная нагрузка');
INSERT INTO "actions" VALUES(6,'Просмотр ТВ','intellectual','low','Пассивная деятельность в состоянии покоя');
CREATE TABLE doctors (
    doctor_id INTEGER PRIMARY KEY,
    full_name TEXT NOT NULL,
    specialization TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    phone TEXT NOT NULL,
    hire_date DATE NOT NULL
);
INSERT INTO "doctors" VALUES(1,'Иванова Мария Сергеевна','Терапевт','ivanova.ms@edms.local','+7-901-100-10-01','2022-02-14');
INSERT INTO "doctors" VALUES(2,'Смирнов Алексей Павлович','Кардиолог','smirnov.ap@edms.local','+7-901-100-10-02','2021-09-01');
INSERT INTO "doctors" VALUES(3,'Кузнецова Елена Игоревна','Эндокринолог','kuznetsova.ei@edms.local','+7-901-100-10-03','2020-11-20');
INSERT INTO "doctors" VALUES(4,'Волков Даниил Олегович','Врач общей практики','volkov.do@edms.local','+7-901-100-10-04','2023-03-10');
INSERT INTO "doctors" VALUES(5,'Морозова Анна Викторовна','Врач ЛФК','morozova.av@edms.local','+7-901-100-10-05','2024-01-15');
CREATE TABLE patients (
    patient_id INTEGER PRIMARY KEY,
    full_name TEXT NOT NULL,
    birth_date DATE NOT NULL,
    gender TEXT NOT NULL CHECK (gender IN ('M', 'F')),
    phone TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    registration_date DATE NOT NULL,
    assigned_doctor_id INTEGER NOT NULL,
    FOREIGN KEY (assigned_doctor_id) REFERENCES doctors(doctor_id)
);
INSERT INTO "patients" VALUES(1,'Пушкарёв Дмитрий Алексеевич','2005-07-31','M','+7-910-200-00-01','pushkarev.da@edms.local','2026-03-01',2);
INSERT INTO "patients" VALUES(2,'Ким Игорь Геннадьевич','2004-06-18','M','+7-910-200-00-02','kim.ig@edms.local','2026-03-02',4);
INSERT INTO "patients" VALUES(3,'Орлова Анна Михайловна','1999-12-05','F','+7-910-200-00-03','orlova.am@edms.local','2026-03-03',1);
INSERT INTO "patients" VALUES(4,'Лебедев Максим Сергеевич','2001-08-22','M','+7-910-200-00-04','lebedev.ms@edms.local','2026-03-04',3);
INSERT INTO "patients" VALUES(5,'Васильева Екатерина Павловна','2000-02-11','F','+7-910-200-00-05','vasileva.ep@edms.local','2026-03-05',5);
CREATE TABLE report_history (
    report_id INTEGER PRIMARY KEY,
    patient_id INTEGER NOT NULL,
    doctor_id INTEGER NOT NULL,
    report_type TEXT NOT NULL CHECK (
        report_type IN ('indicator_dynamics', 'worst_wellbeing_days', 'top_actions')
    ),
    period_start DATE NOT NULL,
    period_end DATE NOT NULL,
    generated_at TEXT NOT NULL,
    delivery_status TEXT NOT NULL CHECK (
        delivery_status IN ('generated', 'sent', 'delivered')
    ),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);
INSERT INTO "report_history" VALUES(1,1,2,'indicator_dynamics','2026-03-10','2026-03-19','2026-03-19 09:00:00','generated');
INSERT INTO "report_history" VALUES(2,1,2,'worst_wellbeing_days','2026-03-10','2026-03-19','2026-03-19 09:05:00','sent');
INSERT INTO "report_history" VALUES(3,1,2,'top_actions','2026-03-10','2026-03-19','2026-03-19 09:10:00','delivered');
INSERT INTO "report_history" VALUES(4,2,4,'indicator_dynamics','2026-03-11','2026-03-18','2026-03-18 20:00:00','generated');
INSERT INTO "report_history" VALUES(5,3,1,'worst_wellbeing_days','2026-03-12','2026-03-19','2026-03-19 10:00:00','generated');
CREATE TABLE self_control_entries (
    entry_id INTEGER PRIMARY KEY,
    patient_id INTEGER NOT NULL,
    action_id INTEGER NOT NULL,
    symptom_id INTEGER NOT NULL,
    entry_datetime TEXT NOT NULL,
    wellbeing_score INTEGER NOT NULL CHECK (wellbeing_score BETWEEN 1 AND 5),
    pulse INTEGER NOT NULL CHECK (pulse BETWEEN 30 AND 220),
    systolic_pressure INTEGER NOT NULL CHECK (systolic_pressure BETWEEN 70 AND 250),
    diastolic_pressure INTEGER NOT NULL CHECK (diastolic_pressure BETWEEN 40 AND 150),
    temperature NUMERIC NOT NULL CHECK (temperature BETWEEN 34.0 AND 42.0),
    data_source TEXT NOT NULL CHECK (data_source IN ('manual', 'sensor')),
    notes TEXT,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (action_id) REFERENCES actions(action_id),
    FOREIGN KEY (symptom_id) REFERENCES symptoms(symptom_id)
);
INSERT INTO "self_control_entries" VALUES(1,1,1,2,'2026-03-10 08:00:00',2,112,148,96,36.9,'manual','После утреннего бега отмечена выраженная слабость');
INSERT INTO "self_control_entries" VALUES(2,1,2,6,'2026-03-11 19:00:00',4,88,128,82,36.7,'sensor','Состояние стабильное после прогулки');
INSERT INTO "self_control_entries" VALUES(3,1,4,1,'2026-03-12 21:00:00',3,76,122,80,36.6,'manual','Небольшая головная боль вечером');
INSERT INTO "self_control_entries" VALUES(4,1,5,5,'2026-03-13 23:00:00',2,98,138,90,36.8,'manual','Усталость и тревожность после работы');
INSERT INTO "self_control_entries" VALUES(5,1,3,2,'2026-03-14 09:00:00',3,102,142,92,36.9,'sensor','Гимнастика выполнена, состояние удовлетворительное');
INSERT INTO "self_control_entries" VALUES(6,1,1,4,'2026-03-15 07:30:00',1,118,152,98,37,'sensor','После пробежки появилась боль в груди');
INSERT INTO "self_control_entries" VALUES(7,1,6,6,'2026-03-16 20:30:00',5,72,118,78,36.5,'manual','Спокойный вечер без жалоб');
INSERT INTO "self_control_entries" VALUES(8,1,2,2,'2026-03-17 18:10:00',4,86,126,80,36.7,'sensor','Прогулка перенесена хорошо');
INSERT INTO "self_control_entries" VALUES(9,1,5,1,'2026-03-18 22:15:00',2,96,136,88,36.8,'manual','Головная боль после длительной работы');
INSERT INTO "self_control_entries" VALUES(10,1,1,3,'2026-03-19 08:20:00',1,120,154,100,37.1,'sensor','Одышка после интенсивной нагрузки');
CREATE TABLE symptoms (
    symptom_id INTEGER PRIMARY KEY,
    symptom_name TEXT NOT NULL UNIQUE,
    symptom_type TEXT NOT NULL CHECK (symptom_type IN ('subjective', 'objective')),
    severity_scale TEXT NOT NULL,
    description TEXT
);
INSERT INTO "symptoms" VALUES(1,'Головная боль','subjective','1-5','Жалоба на головную боль');
INSERT INTO "symptoms" VALUES(2,'Слабость','subjective','1-5','Общее ощущение слабости');
INSERT INTO "symptoms" VALUES(3,'Одышка','subjective','1-5','Ощущение нехватки воздуха');
INSERT INTO "symptoms" VALUES(4,'Боль в груди','subjective','1-5','Дискомфорт или боль в грудной клетке');
INSERT INTO "symptoms" VALUES(5,'Тревожность','subjective','1-5','Повышенная тревожность или напряжение');
INSERT INTO "symptoms" VALUES(6,'Без жалоб','subjective','1-5','Отсутствие выраженных жалоб');
COMMIT;

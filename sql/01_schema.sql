PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS report_history;
DROP TABLE IF EXISTS self_control_entries;
DROP TABLE IF EXISTS symptoms;
DROP TABLE IF EXISTS actions;
DROP TABLE IF EXISTS patients;
DROP TABLE IF EXISTS doctors;

CREATE TABLE doctors (
    doctor_id INTEGER PRIMARY KEY,
    full_name TEXT NOT NULL,
    specialization TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    phone TEXT NOT NULL,
    hire_date DATE NOT NULL
);

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

CREATE TABLE actions (
    action_id INTEGER PRIMARY KEY,
    action_name TEXT NOT NULL UNIQUE,
    action_type TEXT NOT NULL CHECK (action_type IN ('physical', 'intellectual')),
    intensity_level TEXT NOT NULL CHECK (intensity_level IN ('low', 'medium', 'high')),
    description TEXT
);

CREATE TABLE symptoms (
    symptom_id INTEGER PRIMARY KEY,
    symptom_name TEXT NOT NULL UNIQUE,
    symptom_type TEXT NOT NULL CHECK (symptom_type IN ('subjective', 'objective')),
    severity_scale TEXT NOT NULL,
    description TEXT
);

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

CREATE DATABASE HealthcareDB;
USE HealthcareDB; 
 
-- Table 1: Hospitals
CREATE TABLE hospitals (
    hospital_id INT PRIMARY KEY,
    hospital_name VARCHAR(200) NOT NULL,
    location VARCHAR(150) NOT NULL
);

-- Table 2: Doctors
CREATE TABLE doctors (
    doctor_id INT PRIMARY KEY,
    doctor_name VARCHAR(150) NOT NULL,
    FEES decimal(10,2),
    specialization VARCHAR(100) NOT NULL,
    hospital_id INT,
    FOREIGN KEY (hospital_id) REFERENCES hospitals(hospital_id)
);

alter table doctors modify column fees decimal(10,2);
-- Table 3: Patients
CREATE TABLE patients (
    patient_id INT PRIMARY KEY,
    patient_name VARCHAR(150) NOT NULL,
    age INT,
    gender VARCHAR(20),
    hospital_id INT,
    FOREIGN KEY (hospital_id) REFERENCES hospitals(hospital_id)
);

-- Table 4: Treatments 
CREATE TABLE treatments (
    treatment_id INT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    diagnosis VARCHAR(255) NOT NULL,
    treatment_date DATE,
    cost DECIMAL(10, 2),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);

INSERT INTO hospitals (hospital_id, hospital_name, location) VALUES
(1, 'City General Hospital', 'New York'),
(2, 'Metro Health Center', 'Chicago'),
(3, 'St. Jude Medical Institute', 'Boston'),
(4, 'Apex Care Clinic', 'San Francisco');

INSERT INTO doctors (doctor_id, doctor_name, FEES, specialization, hospital_id) VALUES
(101, 'Dr. Alice Smith',1200,'Cardiology', 1),
(102, 'Dr. Robert Jones',1000,'Neurology', 1),
(103, 'Dr. Emily Davis',800,'Pediatrics', 2),
(104, 'Dr. Michael Brown',1000,'Orthopedics', 2),
(105, 'Dr. Sarah Wilson',1000,'Dermatology', 3),
(106, 'Dr. David Taylor',1200,'General Medicine', 3),
(107, 'Dr. Jessica Moore',1500,'Cardiology', 4),
(108, 'Dr. Daniel Anderson',1000,'Oncology', 4),
(109, 'Dr. Laura Thomas',900,'Pediatrics', 1),
(110, 'Dr. Kevin Jackson',1000,'Orthopedics', 3);

INSERT INTO patients (patient_id, patient_name, age, gender, hospital_id) VALUES
(1001, 'John Doe', 45, 'Male', 1),
(1002, 'Jane Smith', 32, 'Female', 1),
(1003, 'Bob Johnson', 58, 'Male', 2),
(1004, 'Alice Williams', 29, 'Female', 2),
(1005, 'Charlie Brown', 65, 'Male', 3),
(1006, 'Diana Miller', 41, 'Female', 3),
(1007, 'Evan Davis', 52, 'Male', 4),
(1008, 'Fiona Garcia', 37, 'Female', 4),
(1009, 'George Martinez', 19, 'Male', 1),
(1010, 'Hannah Rodriguez', 24, 'Female', 2),
(1011, 'Ian Hernandez', 48, 'Male', 3),
(1012, 'Julia Lopez', 55, 'Female', 4),
(1013, 'Kevin Gonzalez', 61, 'Male', 1),
(1014, 'Lily Perez', 30, 'Female', 2),
(1015, 'Mason Wilson', 27, 'Male', 3),
(1016, 'Nora Anderson', 43, 'Female', 4),
(1017, 'Owen Thomas', 36, 'Male', 1),
(1018,  'Penny Jackson', 50, 'Female', 2),
(1019, 'Quinn White', 44, 'Male', 3),
(1020, 'Rachel Harris', 39, 'Female', 4);

INSERT INTO treatments (treatment_id, patient_id, doctor_id, diagnosis, treatment_date, cost) VALUES
(5001, 1001, 101, 'Hypertension', '2026-01-10', 25000.00),
(5002, 1002, 109, 'Bronchitis', '2026-01-12', 1200.50),
(5003, 1003, 104, 'Fractured Arm', '2026-01-15', 12000.00),
(5004, 1004, 103, 'Viral Fever', '2026-01-18', 9500.00),
(5005, 1005, 106, 'Type 2 Diabetes', '2026-02-01', 4500.00),
(5006, 1006, 105, 'Eczema', '2026-02-03', 18000.00),
(5007, 1007, 107, 'Arrhythmia', '2026-02-10', 85000.00),
(5008, 1008, 108, 'Routine Screening', '2026-02-14', 30000.00),
(5009, 1009, 102, 'Migraine', '2026-03-02', 22000.00),
(5010, 1010, 104, 'Sprained Ankle', '2026-03-05', 15000.00),
(5011, 1011, 106, 'Hypertension', '2026-03-11', 26000.00),
(5012, 1012, 107, 'Chest Pain', '2026-03-20', 95000.00),
(5013, 1013, 101, 'Hypertension', '2026-04-02', 25000.00),
(5014, 1014, 103, 'Ear Infection', '2026-04-08', 11000.00),
(5015, 1015, 110, 'Knee Pain', '2026-04-12', 40000.00),
(5016, 1016, 108, 'Oncology Consultation', '2026-04-19', 15000.00);
 
## Q.1 find total Number of specialist doctors & doctors total fees
select specialization,count(doctor_id) as 'Number of Doctors',sum(fees) as 'total_fess'
from Doctors 
group by specialization
order by count(doctor_id) desc; 

## Q.2 find the total number of hospital available in the database.
SELECT COUNT(*) AS total_hospitals
FROM hospitals;

## Q.3  find the total number doctors available in the database.
SELECT COUNT(*) AS total_doctors
FROM doctors;
 
## Q.4 find details of the hospital named apex care clinic
select *
from hospitals
where hospital_name = 'Apex Care Clinic';

## Q.5 Doctors Whose specialist in Orthopedics
select *
from doctors
where specialization = 'Orthopedics';

select * from treatments;
## Q.6 find number of diagnosis the total cost number & total diagnosis treatments.
select diagnosis, sum(cost) as 'total cost',count(*) as 'total diagnosis'
from treatments
group by diagnosis
order by count(treatment_id) desc;

 ## Q.7 Find details from patients whose age is greater then 40 short age in .
SELECT *
FROM patients
WHERE age > 40
ORDER BY age asc;

## Q.8 find the specialist & the total number of doctors where the number of doctors is more then 1.
select specialization, count(*) as 'total specialist'
from Doctors
group by specialization
having count(*) >1;

## Q.9. find 10 diagnosis patients & cost for the first 10 diagnosis patients.. 
select diagnosis, sum(cost) AS total_cost
from treatments
GROUP BY diagnosis 
order by total_cost desc
limit 5;
 
 ## Q.10 find the 2,max Diagnosis patients & there total cost treatments wise . 
select diagnosis, COUNT(*) AS total_diagnosis_patients, sum(cost) AS total_cost
from treatments
GROUP BY diagnosis 
order by total_cost desc
limit 1 offset 1;

## Q.11 find the daignosis patient months name and patients admit treatment days.
select diagnosis,month(treatment_date) AS month_number,dayname(treatment_date) AS day_name
from treatments;

##windows functions
## Q.13 AASIGN DIAGNOSIS PATIENTS  A COST WISE  
SELECT
    diagnosis,
    cost,
    Rank () OVER (PARTITION BY diagnosis ORDER BY cost asc ) AS Rank_ FROM treatments;
   
## Q 14 find the patients_name, age & define age category.. 
select
    patient_name,
    age,
    case
        when age < 18 then 'Minor'
        when age between 18 and 40 then 'Young Adult'
        when age between 41 and 59 then 'Middle Aged'
        else 'Senior'
    end as age_category
from patients;

##join functions 
## Q.15 All details for hospital and doctors working each hospital
select h.*,d.doctor_id,d.doctor_name,d.FEES
from hospitals h
inner join doctors d
on h.hospital_id = d.hospital_id;

select * from doctors;
select * from treatments;

## Q 16 find doctor, name, and fees with the total number of treatments for diagnosis and its cost.
select d.doctor_id,d.doctor_name,d.fees,
count(t.treatment_id) as total_treatments,t.diagnosis,t.cost
from doctors d
inner join treatments t
on d.doctor_id = t.doctor_id
group by d.doctor_id,d.doctor_name,d.fees,t.diagnosis,t.cost; 

## Q.17 find total treatment cost and the total num of tratments each doctors are specailist
select d.specialization,SUM(t.cost) AS total_cost,COUNT(*) AS total_treatments
from treatments t
inner join doctors d
on t.doctor_id = d.doctor_id
group by  d.specialization;

## Q.18 find who are specialist & each cost greater then 50000 number of treatments.
select d.specialization,SUM(t.cost) AS total_cost,COUNT(*) AS total_treatments
from treatments t
inner join doctors d
on t.doctor_id = d.doctor_id
group by  d.specialization
having sum(t.cost)>50000;

#Subquery 
## Q.19 find all treatments records where cost higher then the average cost of all treatments.
select *
from treatments
where cost > (
    select avg(cost)
    from treatments
);

## Q.20 find all patients reacord who are older then the average age of all patients.
select patient_id,patient_name,age,gender
from patients
where age > (
select avg(age)
from patients
);
 
 
 





use Health;

create database Health;

select * from appointments;
select * from billing;
select * from doctors;
select * from patients;
select * from treatments;

-------Identify the patients by gender ----------- 
select 
	gender,
	count(*) as "num of patients"
from patients
Group By gender;

------- count of appointments by status---------

select 
	status,
	count(*) as "appointments"
from appointments
Group By status;

--------- Doctor Cancellation Analysis and NO-show Analysis(KPI 1) ------------

CREATE VIEW cancellation_analysis AS
WITH Doctor_appointment AS
(
    SELECT 
        doctor_id,
        COUNT(*) AS total_counts,
        SUM(CASE WHEN status = 'completed' THEN 1 ELSE 0 END) AS completed_count,
        SUM(CASE WHEN status = 'scheduled' THEN 1 ELSE 0 END) AS scheduled_count,
        SUM(CASE WHEN status = 'no-show' THEN 1 ELSE 0 END) AS no_show_count,
        SUM(CASE WHEN status = 'cancelled' THEN 1 ELSE 0 END) AS cancelled_count
    FROM appointments
    GROUP BY doctor_id
)
SELECT 
    da.doctor_id,
    CONCAT(d.first_name, ' ', d.last_name) AS full_name,
    da.total_counts,
    da.completed_count,
    da.scheduled_count,
    da.no_show_count,
    da.cancelled_count,
    ROUND(CAST(da.completed_count AS FLOAT) * 100 / da.total_counts, 2) AS completed_count_rate,
    ROUND(CAST(da.scheduled_count AS FLOAT) * 100 / da.total_counts, 2) AS scheduled_count_rate,
    ROUND(CAST(da.no_show_count AS FLOAT) * 100 / da.total_counts, 2) AS no_show_count_rate,
    ROUND(CAST(da.cancelled_count AS FLOAT) * 100 / da.total_counts, 2) AS cancelled_count_rate
FROM Doctor_appointment da
INNER JOIN doctors d
    ON da.doctor_id = d.doctor_id;

---------- status for all those treatements where the payments is not completed (KPI 2)---------
select
	t.treatment_date,
	t.treatment_id,
	t.treatment_type,
	p.payment_method,
	p.payment_status,
	Round(p.amount,2) as total_amount
from treatments t
left join billing p
on t.treatment_id = p.treatment_id
where p.payment_status in ('Pending','Failed')

---------Doctor experience vs cost (trend b/w the exp and the cost (KPI 3)) ------------------

select
	d.doctor_id,
	CONCAT(d.first_name, ' ', d.last_name) as Full_name,
	d.years_experience,
	d.specialization,
	Round(sum(cast(t.cost as decimal (10,2))),2) as Full_revenue,
	Round(avg(cast(t.cost as decimal (10,2))),2) as Avg_revenue

from doctors d
inner join appointments a
on a.doctor_id = d.doctor_id
inner join treatments t
on a.appointment_id = t.appointment_id
where d.years_experience > 20
group by	
	d.doctor_id,
	d.first_name,
	d.last_name,
	d.years_experience,
	d.specialization
order by d.years_experience

---------- calculate the revenue on monthly basis (KPI 4) --------------
select 
	MONTH(bill_date) as month_num,
	FORMAT(bill_date, 'MMM-yyyy') as Month_Year,
	ROUND(sum(cast(amount as decimal(10,2))),2) as Total_revenue
from billing
Group By 
	MONTH(bill_date),
	FORMAT(bill_date, 'MMM-yyyy')
Order By month_num 

----- calculate the appointments per doctor by hospital branch (KPI 5)---------------- 
select 
	d.hospital_branch,
	ROUND(cast(count(a.appointment_date) as float)
	/ COUNT(distinct d.doctor_id),2) as appointment_per_doctor
from doctors d
inner join appointments a
on d.doctor_id = a.doctor_id
Group by d.hospital_branch

---------- Revenue by specialization (KPI 6) -----------------
select 
	d.specialization,
	Round(sum(cast(b.amount as decimal(10,2))),2) as total_revenue
from doctors d
inner join appointments as a
on d.doctor_id = a.doctor_id
inner join billing as b
on b.patient_id = a.patient_id
Group By d.specialization
Order by total_revenue desc;

-------- calculate the customer lifetime value (KPI 7)-------------------

CREATE VIEW customer_lifetime_value AS
WITH patient_revenue AS
(
    SELECT 
        p.patient_id,
        CONCAT(p.first_name, ' ', p.last_name) AS full_name,
        ROUND(SUM(CAST(b.amount AS DECIMAL(10,2))), 2) AS patient_ltv,
        COUNT(DISTINCT a.appointment_id) AS total_visit
    FROM patients p
    INNER JOIN appointments a
        ON a.patient_id = p.patient_id
    INNER JOIN billing b
        ON b.patient_id = a.patient_id
    GROUP BY 
        p.patient_id,
        p.first_name,
        p.last_name
)
SELECT
    patient_id,
    full_name,
    patient_ltv,
    total_visit,
    RANK() OVER (ORDER BY patient_ltv DESC) AS revenue_rank
FROM patient_revenue;

------- total revenue generated (KPI 8) ------------

select
    Round(sum(amount),2) as total_revenue
    from billing;

------ top 5 most common types of treatments (KPI 9) ----------------

select
	top 5 treatment_type,
	COUNT(*) as 'count of treatment type'
from treatments 
Group By treatment_type
Order by 'count of treatment type'



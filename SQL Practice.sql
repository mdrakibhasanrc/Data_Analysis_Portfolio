
-- SQL Practice From sql-practice.com

Eassy Question:

1. Show first name, last name, and gender of patients whose gender is 'M'?
select
   first_name,
   last_name,
   gender
  from patients
  where gender="M";

2. Show first name and last name of patients who does not have allergies. (null)
select
   first_name,
   last_name
from patients
where allergies is NULL;

3. Show first name of patients that start with the letter 'C'
select
   first_name
from patients
where first_name like "C%";

4.Show first name and last name of patients that weight within the range of 100 to 120 (inclusive)
select
   first_name,
   last_name
from patients
where weight between 100 and 120;

5. Update the patients table for the allergies column. If the patient's allergies is null then replace it with 'NKA'

update patients
set allergies="NKA"
where allergies is null;

6. Show first name and last name concatinated into one column to show their full name.
select
  concat(first_name," ",last_name) as full_name
 from patients;


7. Show first name, last name, and the full province name of each patient.
select
   p.first_name,
   p.last_name,
   o.province_name
  from patients p
  inner join province_names o 
  on o.province_id=p.province_id;

8. Show how many patients have a birth_date with 2010 as the birth year.
select
    count(patient_id) as total_patients
 from patients
 where year(birth_date)=2010;

9. Show the first_name, last_name, and height of the patient with the greatest height.
select
   first_name,
   last_name,
   max(height) as height
  from patients;

10. Show all columns for patients who have one of the following patient_ids:
1,45,534,879,1000.

select
   *
 from patients
 where patient_id in (1,45,534,879,1000);


11. Show the total number of admissions?
select
   count(patient_id) as total_addmission
 from admissions;
   
12. Show all the columns from admissions where the patient was admitted and discharged on the same day.
select
   *
 from admissions
 where admission_date=discharge_date;

13. Show the patient id and the total number of admissions for patient_id 579.
select
  patient_id,
  count(patient_id) as total_admission
 from admissions
 where patient_id=579;

14. Based on the cities that our patients live in, show unique cities that are in province_id 'NS'?
select
   distinct city
 from patients
 where province_id="NS"

15. Write a query to find the first_name, last name and birth date of patients who has height greater than 160 and weight greater than 70.
select
  first_name,
  last_name,
  birth_date
 from patients
 where height >160 and weight>70;

16. Write a query to find list of patients first_name, last_name, and allergies from Hamilton where allergies are not null?
SELECT
  first_name,
  last_name,
  allergies
FROM patients
WHERE
  city = 'Hamilton'
  and allergies is not null;

17. Based on cities where our patient lives in, write a query to display the list of unique city starting with a vowel (a, e, i, o, u). Show the result order in ascending by city.

select
   distinct city 
 from patients
 where city like "a%" or
       city like "e%" or 
       city like "i%" or 
       city like "o%" or 
       city like "u%" 
 order by city asc;

Medium Question:
18. Show unique birth years from patients and order them by ascending.
select
   distinct year(birth_date) as birth_year
 from patients
 order by birth_year asc;

19.Show unique first names from the patients table which only occurs once in the list.
SELECT first_name
FROM patients
GROUP BY first_name
HAVING COUNT(first_name) = 1;

20. Show patient_id and first_name from patients where their first_name start and ends with 's' and is at least 6 characters long.
select
   patient_id,
   first_name
 from patients
 where first_name like "%s" and first_name like "s%" and len(first_name)>=6;

21. Show patient_id, first_name, last_name from patients whos diagnosis is 'Dementia'.

Primary diagnosis is stored in the admissions table.
select
   p.patient_id,
   p.first_name,
   p.last_name
 from patients p 
 inner join admissions a 
 on a.patient_id=p.patient_id
 where diagnosis="Dementia";

22. Display every patient's first_name.
Order the list by the length of each name and then by alphbetically

SELECT first_name
FROM patients
order by
  len(first_name),
  first_name;

23. Show the total amount of male patients and the total amount of female patients in the patients table.
Display the two results in the same row.
SELECT
   SUM(CASE WHEN gender = "M" THEN 1 ELSE 0 END) AS Male,
   SUM(CASE WHEN gender = "F" THEN 1 ELSE 0 END) AS Female
FROM patients;

24. Show first and last name, allergies from patients which have allergies to either 'Penicillin' or 'Morphine'. Show results ordered ascending by allergies then by first_name then by last_name.
select
   first_name,
   last_name,
   allergies
 from patients
 where allergies in ("Penicillin" ,"Morphine")
 order by allergies asc,first_name asc,last_name asc;



25. Show patient_id, diagnosis from admissions. Find patients admitted multiple times for the same diagnosis.
SELECT patient_id, diagnosis
FROM admissions
GROUP BY patient_id, diagnosis
HAVING COUNT(*) > 1;

26. Show the city and the total number of patients in the city.
Order from most to least patients and then by city name ascending.
select
   city,
   count(patient_id) as total_patient
from patients
group by city
order by total_patient desc,city asc;

27. Show first name, last name and role of every person that is either patient or doctor.
The roles are either "Patient" or "Doctor"

SELECT first_name, last_name, 'Patient' AS role
FROM patients
UNION all
SELECT first_name, last_name, 'Doctor' AS role
FROM doctors;

28. Show all allergies ordered by popularity. Remove NULL values from query.

select
   allergies,
   count(allergies) as total_diagonisies
 from patients
 where allergies is not null
 group by allergies
 order by total_diagonisies desc ;

29. Show all patient's first_name, last_name, and birth_date who were born in the 1970s decade. Sort the list starting from the earliest birth_date.
select
   first_name,
   last_name,
   birth_date
from patients
where year(birth_date) between 1970 and 1979
order by birth_date asc;

30. We want to display each patient's full name in a single column. Their last_name in all upper letters must appear first, then first_name in all lower case letters. Separate the last_name and first_name with a comma. Order the list by the first_name in decending order
EX: SMITH,jane

select
   concat(upper(last_name),",",lower(first_name)) as full_name
 from patients
 order by first_name desc;

31. Show the province_id(s), sum of height; where the total sum of its patient's height is greater than or equal to 7,000.
select
   province_id,
   sum(height) as sum_height
from patients
group by province_id
having sum_height >=7000;

32. Show the difference between the largest weight and smallest weight for patients with the last name 'Maroni'
select  
    (max(weight)-min(weight)) as weight_delta
from patients
where last_name="Maroni";

33.Show all columns for patient_id 542's most recent admission_date.

SELECT *
FROM admissions
WHERE patient_id = 542
AND admission_date = (
    SELECT MAX(admission_date)
    FROM admissions
    WHERE patient_id = 542
);

34.Show patient_id, attending_doctor_id, and diagnosis for admissions that match one of the two criteria:
1. patient_id is an odd number and attending_doctor_id is either 1, 5, or 19.
2. attending_doctor_id contains a 2 and the length of patient_id is 3 characters.


select
    patient_id,
    attending_doctor_id,
    diagnosis
 from admissions
 where (patient_id%2 !=0 and attending_doctor_id in(1,5,19))
        or (attending_doctor_id like '%2%' and len(patient_id)=3);


35. Show first_name, last_name, and the total number of admissions attended for each doctor.Every admission has been attended by a doctor.

select
    d.first_name,
    d.last_name,
    count(p.patient_id) as total_admission
from doctors d 
inner join admissions a 
on a.attending_doctor_id=d.doctor_id
inner join patients p  
on p.patient_id=a.patient_id
group by d.first_name,d.last_name;


36. For each doctor, display their id, full name, and the first and last admission date they attended.

select
  d.doctor_id,
  concat(d.first_name," ",d.last_name) as full_name,
  min(a.admission_date) as first_admission_date,
  max(a.admission_date) as last_admission_date
from doctors d 
inner join admissions a 
on a.attending_doctor_id=d.doctor_id
group by d.doctor_id;
  

37. Display the total amount of patients for each province. Order by descending.

select
  p.province_name,
  count(pa.patient_id) as total_amount
from province_names p 
inner join patients pa 
on pa.province_id=p.province_id
group by p.province_name
order by total_amount desc;

38. For every admission, display the patient's full name, their admission diagnosis, and their doctor's full name who diagnosed their problem.
select
   concat(p.first_name," ",p.last_name) as Full_name,
   a.diagnosis,
   concat(d.first_name," ",d.last_name) as doctor_Full_name
from patients p 
inner join admissions a 
on a.patient_id=p.patient_id
inner join doctors d 
on a.attending_doctor_id=d.doctor_id;
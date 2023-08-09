-- SQL Data Cleaning Practice

use ecom;

-- Create Backup table
create table laptops like laptop_price;

-- Data Tranasform laptob_price to laptops
insert into laptops
select * from laptop_price;

-- select all data
select
   *
from laptops;
-- On Safe mode
 Set SQL_Safe_Updates=0;

-- Count all data
select
   count(*) as count_data
from laptops;

-- check Basic info
describe laptops;

-- See first five rows
select
   *
from laptops
limit 5;

-- Check duplicated values
select
    laptop_ID,
	count(laptop_ID) as cnt
from laptops
group by laptop_ID
having count(laptop_ID)>1;

-- Replace weight columns KG
select
   Weight,
   replace(Weight,"kg","")
from laptops;

update laptops
set Weight=replace(Weight,"kg","");

-- Replace RAM columns GB
select
   Ram,
   replace(Ram,"GB","")
from laptops;

update laptops
set Ram=replace(Ram,"GB","");

-- Price Columns Data Type Float to integer
select
  Price_euros,
  round(Price_euros) as price
from laptops;

update laptops
set Price_euros=round(Price_euros);

-- Change Data Type Price_euros columns
alter table laptops
modify column Price_euros integer;

-- change columns name Price_Euros to Euro
alter table laptops
rename column Price_euros to Price;
-- Clean Opsys Columns
select
   distinct OpSys
from laptops;

select
   OpSys,
   case
      when OpSys like '%mac%' then "MacOs"
      when OpSys like "%Mac%" then "MacOs"
      when OpSys like "%Windows%" then "Windows"
      when OpSys like "%Linux%" then "Linux"
      when OpSys like "%No Os%" then "N/A"
      else "Other"
      End as Operating_System
from laptops;

-- Create Another Columns Opearting System
alter table laptops
add column Operating_System varchar(20);

-- Update Operating System Columns
update laptops
set Operating_System=case
      when OpSys like '%mac%' then "MacOs"
      when OpSys like "%Mac%" then "MacOs"
      when OpSys like "%Windows%" then "Windows"
      when OpSys like "%Linux%" then "Linux"
      when OpSys like "%No Os%" then "N/A"
      else "Other"
      End ;

-- Drop OpSys Columns
alter table laptops
drop column OpSys;


-- Touchscreen Colums
select
   ScreenResolution,
   case
      when ScreenResolution like "%Touchscreen%" Then "Yes"
      else "No"
      end as "TouchScreen"
from laptops;

-- Create Another Columns TouchScreen
alter table laptops
add column Touchscreen varchar(5);

-- Update TouchScreen Column
update laptops
set Touchscreen=case
      when ScreenResolution like "%Touchscreen%" Then "Yes"
      else "No"
      end;

-- GPU Columns
select
   GPU,
   substring_index(GPU,' ',1)
from laptops;

-- Create New COlumns GPU Brand
alter table laptops
add column Gpu_Brand text;

-- Update GPU_BRAND Column
update laptops
set Gpu_Brand=substring_index(GPU,' ',1);

-- Drop GPU COlumns
alter table laptops
drop column Gpu;

-- Memory Columns
select
   distinct Memory
from laptops;

select
    Memory,
    case 
       when Memory like "%SSD%" then "SSD"
        when Memory like "%Flash Storage%" then "Flash Storage"
         when Memory like "%HDD%" then "HDD"
          when Memory like "%SSD%" and Memory like "%HDD%" then "Hybrid"
           when Memory like "%Hybrid%" then "Hybrid"
           WHEN Memory LIKE '%Flash Storage%' AND Memory LIKE '%HDD%' THEN 'Hybrid'
           else "Null"
           end as memory_type
	from laptops;
    
  -- Create New COlumns Memory Type
alter table laptops
add column Memory_Type text;

-- Update Memory_Type Column
update laptops
set Memory_Type=case 
       when Memory like "%SSD%" then "SSD"
        when Memory like "%Flash Storage%" then "Flash Storage"
         when Memory like "%HDD%" then "HDD"
          when Memory like "%SSD%" and Memory like "%HDD%" then "Hybrid"
           when Memory like "%Hybrid%" then "Hybrid"
           WHEN Memory LIKE '%Flash Storage%' AND Memory LIKE '%HDD%' THEN 'Hybrid'
           else "Null"
           end;

-- Memory to Primary Stoarge
select
   Memory,
   substring_index(Memory,' ',1) as primary_storage
from laptops;

-- Create new columsns Primary Storage
alter table laptops
add column Primary_Storage text;

alter table laptops
modify column Primary_Storage text;

-- Update Memory_Type Column
update laptops
set Primary_Storage=substring_index(Memory,' ',1);

-- Drop Memory Columns
alter table laptops
drop column Memory;

-- add Cpu_Brand Columns
alter table laptops
add column Cpu_Brand text;

-- add Cpu_Speed Columns
alter table laptops
add column Cpu_Speed float;

select
   Cpu,
   substring_index(Cpu,' ',1) as cpu_brand,
   replace(substring_index(Cpu,' ',-1),"GHz","") as cpu_speed
from laptops;

-- Update Cpu_Brand Columns
update laptops
set Cpu_Brand=substring_index(Cpu,' ',1),
 Cpu_Speed=replace(substring_index(Cpu,' ',-1),"GHz","");


-- Drop Cpu Columns
alter table laptops
drop column Cpu;


-- ScreenResulation Columns
select
   ScreenResolution,
   SUBSTRING_INDEX(SUBSTRING_INDEX(ScreenResolution,' ',-1),"x",1) as resulation_width,
   SUBSTRING_INDEX(SUBSTRING_INDEX(ScreenResolution,' ',-1),"x",-1) as resulation_height
from laptops;

-- Add Two Columns Resolution_Width and Resolution_Height
alter table laptops
add column Resolution_Width int;

alter table laptops
add column Resolution_Height int;


-- Update Columns

update laptops
set  Resolution_Width=SUBSTRING_INDEX(SUBSTRING_INDEX(ScreenResolution,' ',-1),"x",1),
    Resolution_Height=SUBSTRING_INDEX(SUBSTRING_INDEX(ScreenResolution,' ',-1),"x",-1);

-- Drop Screenresolution columns

alter table laptops
drop column ScreenResolution;

-- Check all Columns
describe laptops;

-- Check Columns Length
select
count(*) as col_number from information_schema.columns where table_name='laptops';

-- add new columns Price Range
alter table laptops
add column Price_range text;

-- Update Price Range Column
update laptops
set Price_range=case
        when Price between 0 and 1000 then '0-1k'
         when Price between 1001 and 2000 then '1k-2k'
          when Price between 2001 and 3000 then '2k-3k'
          when Price between 3001 and 4000 then '3k-4k'
          when Price between 4001 and 5000 then '4k-5k'
          when Price between 5001 and 7000 then '5k-7k'
          else '>7k'
          End;

-- 
select
   TypeName,
   lower(TypeName) as low,
   upper(TypeName) as upp,
   trim(typeName) as tri,
   length(TypeName) as len,
   concat(Company," ",Product) as full_n
from laptops;




-----------  some SQL business questions and Key Performance Indicators (KPIs) 
-- KPI

-- Total Laptop
select
   count(*) as count_laptop
from laptops;

-- Average,Max,Min Price
select
    max(Price) as max_price,
    avg(Price) as avg_price,
    min(Price) as min_price
from laptops;

-- Unique Company
select
    count(distinct Company) as unique_company
from laptops;

-- Average Ram Size
select
    avg(Ram) as avg_Ram_Size
from laptops;

-- Average Inches
select
    avg(Inches) as avg_Inches
from laptops;

-- Average Weight
select
    round(avg(Weight),2) as avg_Weight
from laptops;

-- Unique memory Type
select
    count(distinct Memory_Type) as unique_memory
from laptops;

-- What is the average price of laptops based on different 'Company'?
select
    Company,
    avg(Price) as avg_price
from laptops
group by Company
order by avg_price desc;

-- What is the average RAM size for laptops of different 'Company'?
select
    Company,
    avg(Ram) as avg_Ram
from laptops
group by Company
order by avg_Ram desc;

-- Which 'Company' offers the most affordable laptops with a 'Touchscreen' feature?
select
    Company,
    Touchscreen,
    avg(Price) as avg_Price
from laptops
where Touchscreen="Yes"
group by Company
order by avg_Price desc;

-- Which 'Company' offers the most diverse range of laptop types?
select
    Company,
    count(distinct TypeName) as typename_count
from laptops
group by Company
order by typename_count desc;

-- Laptop Price Range  COunt
select
    Price_range,
    count(Price_range) as count_range
from laptops
group by Price_range
order by count_range desc;
          
-- Company Use CPU
select
    Company,
    sum(case when Cpu_Brand='Intel' then 1 else 0 end ) as Intel,
	sum(case when Cpu_Brand='AMD' then 1 else 0 end ) as AMD
from laptops
group by Company;

-- Company by Memory Type
select
    Company,
    Memory_Type,
    count(Memory_Type) as count_memory
from laptops
group by Company,Memory_Type
order by count_memory desc;

-- Company Use Memory Type
select
    Company,
    sum(case when Memory_Type='SSD' then 1 else 0 end ) as SSD,
	sum(case when Memory_Type='Flash Storage' then 1 else 0 end ) as Flash_Storage,
    sum(case when Memory_Type='HDD' then 1 else 0 end ) as HDD,
    sum(case when Memory_Type='Hybrid' then 1 else 0 end ) as Hybrid
from laptops
group by Company;

-- Operating System by Avg Price
select
    Operating_System,
    avg(Price) as avg_Price
from laptops
group by Operating_System
order by avg_Price desc;

-- TypeName by Avg Price
select
    TypeName,
    avg(Price) as avg_Price
from laptops
group by TypeName
order by avg_Price desc;

-- most Commonly used Primary_Storage and  Avg Price
select
    Primary_Storage,
    count(Primary_Storage) as cnt,
    avg(Price) as avg_Price
from laptops
group by Primary_Storage
order by avg_Price desc;

-- What is the most common 'Operating_System' used and Avg Price in laptops?
select
    Operating_System,
    count(Operating_System) as count_Operating_System,
    avg(Price) as avg_price
from laptops
group by Operating_System
order by count_Operating_System desc;

-- Weight Range by Avg_Price
select
   Case
      when Inches < 14.0 then 'Small'
      when Inches >=14.0 and Inches <17.0 then 'medium'
      else 'Heavy'
      end as Weight_range,
      avg(Price) as avg_price,
      count( Case
      when Inches < 14.0 then 'Small'
      when Inches >=14.0 and Inches <17.0 then 'medium'
      else 'Heavy'
      end) as cnt
from laptops
group by weight_range
order by avg_price desc;

-- Most Commonly Used GPU Brand and avg price
select
    Gpu_Brand,
    count(Gpu_Brand) as count_Gpu_Brand,
    avg(Price) as avg_price
from laptops
group by Gpu_Brand
order by count_Gpu_Brand desc;
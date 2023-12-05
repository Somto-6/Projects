-- Data exploration with SQL

select * from fatalities_isr_pse;

Select count(*) from fatalities_isr_pse
where citizenship like '%lesti%';

-- Select count(*) from fatalities_isr_pse
-- where citizenship = 'palestinian';

Select count(*) from fatalities_isr_pse
where citizenship = 'Israeli';

Select age, count(*) from fatalities_isr_pse
where age <> 'null'
group by age;

Select age, count(*) from fatalities_isr_pse
where age <> 'null' and citizenship like '%lesti%'
group by age
order by age;

Select age, count(*) from fatalities_isr_pse
where age <> 'null' and citizenship like '%ael%'
group by age
order by age;

select date_of_death, count(*) as total_deaths_per_day from fatalities_isr_pse
group by date_of_death
order by total_deaths_per_day desc;

select date_of_death, count(*) as total_deaths_per_day from fatalities_isr_pse
where citizenship like '%lesti%'
group by date_of_death 
order by total_deaths_per_day desc;

select date_of_death, count(*) as total_deaths_per_day from fatalities_isr_pse
where citizenship like '%ael%'
group by date_of_death 
order by total_deaths_per_day desc;

select age, date_of_death, count(*) as total_deaths_per_day from fatalities_isr_pse
where citizenship like '%lesti%' and age != 'null'
group by age, date_of_death
order by total_deaths_per_day desc;

select age, date_of_death, count(*) as total_deaths_per_day from fatalities_isr_pse
where citizenship like '%ael%' and age != 'null'
group by age, date_of_death
order by total_deaths_per_day desc;

select event_location, count(*) as highest_death_count from fatalities_isr_pse
where citizenship like '%ael%' and event_location != 'null'
group by event_location
order by highest_death_count desc;

select event_location, count(*) as highest_death_count from fatalities_isr_pse
where citizenship like '%lesti%' and event_location != 'null'
group by event_location
order by highest_death_count desc;

select event_location, date_of_death, count(*) as total_deaths_per_day from fatalities_isr_pse
where citizenship like '%ael%' and event_location != 'null'
group by event_location, date_of_death
order by total_deaths_per_day desc;

select event_location, date_of_death, count(*) as total_deaths_per_day from fatalities_isr_pse
where citizenship like '%lesti%' and event_location != 'null'
group by event_location, date_of_death
order by total_deaths_per_day desc;

select count(date_of_death) from fatalities_isr_pse; 

select event_location_region, date_of_death, count(*) as total_deaths_per_day from fatalities_isr_pse
where citizenship like '%lesti%' and event_location_region != 'null'
group by event_location_region, date_of_death
order by total_deaths_per_day desc;

select event_location_region, date_of_death, count(*) as total_deaths_per_day from fatalities_isr_pse
where citizenship like '%ael%' and event_location_region != 'null'
group by event_location_region, date_of_death
order by total_deaths_per_day desc limit 5;

select event_location_region, count(*) as highest_death_count from fatalities_isr_pse
where citizenship like '%lesti%' and event_location_region != 'null'
group by event_location_region
order by highest_death_count desc;

select event_location_region, count(*) as highest_death_count from fatalities_isr_pse
where citizenship like '%ael%' and event_location_region != 'null'
group by event_location_region
order by highest_death_count desc;

select citizenship, took_part_in_hostilities, count(*) as no_of_deaths from fatalities_isr_pse
where took_part_in_hostilities != 'null'
group by citizenship, took_part_in_hostilities
order by no_of_deaths desc;

select citizenship, gender, count(*) as no_of_deaths from fatalities_isr_pse
where gender != 'null'
group by citizenship, gender
order by no_of_deaths desc;

select citizenship, age, count(*) as no_of_deaths from fatalities_isr_pse
where age != 'null'
group by citizenship, age
order by no_of_deaths desc;

select place_of_residence, count(*) as no_of_deaths from fatalities_isr_pse
where citizenship != 'Israeli'
group by place_of_residence
order by no_of_deaths desc;

select place_of_residence, count(*) as no_of_deaths from fatalities_isr_pse
-- where citizenship != 'Palestinian'
group by place_of_residence
order by no_of_deaths desc;

select citizenship, type_of_injury, count(*) as no_of_deaths from fatalities_isr_pse
where type_of_injury != 'null'
group by citizenship, type_of_injury
order by no_of_deaths desc;

select citizenship, killed_by, count(*) as no_of_deaths from fatalities_isr_pse
-- where age != 'null'
group by citizenship, killed_by
order by no_of_deaths desc;

select ammunition, count(*) as ammunitions_used from fatalities_isr_pse
where ammunition != 'null'
group by ammunition
order by ammunitions_used desc;

select citizenship, place_of_residence_district, type_of_injury, count(*) as injury_by_location from fatalities_isr_pse
where citizenship != 'null' and place_of_residence_district != 'null' and type_of_injury != 'null'
group by citizenship, place_of_residence_district, type_of_injury
order by injury_by_location desc;

select type_of_injury, date_of_event, date_of_death, datediff(date_of_death, date_of_event) as event_death_margin_days from fatalities_isr_pse
where type_of_injury != 'null'
-- group by type_of_injury, date_of_event, date_of_death
order by event_death_margin_days desc;

-- creating views for visualizations 
create view genderdistribution as
select citizenship, gender, count(*) as no_of_deaths from fatalities_isr_pse
where gender != 'null'
group by citizenship, gender
order by no_of_deaths desc;

create view agedistribution as
select citizenship, age, count(*) as no_of_deaths from fatalities_isr_pse
where age != 'null'
group by citizenship, age
order by no_of_deaths desc;

create view deathperday as
select date_of_death, count(*) as total_deaths_per_day from fatalities_isr_pse
group by date_of_death
order by total_deaths_per_day desc;

create view tookpartinhostilities as
select citizenship, took_part_in_hostilities, count(*) as no_of_deaths from fatalities_isr_pse
where took_part_in_hostilities != 'null'
group by citizenship, took_part_in_hostilities
order by no_of_deaths desc;

create view deathbyplaceofresidence as
select place_of_residence, count(*) as no_of_deaths from fatalities_isr_pse
-- where citizenship != 'Palestinian'
group by place_of_residence
order by no_of_deaths desc;

create view deathbyinjurytype as 
select citizenship, type_of_injury, count(*) as no_of_deaths from fatalities_isr_pse
where type_of_injury != 'null'
group by citizenship, type_of_injury
order by no_of_deaths desc;

create view killedby as 
select citizenship, killed_by, count(*) as no_of_deaths from fatalities_isr_pse
-- where age != 'null'
group by citizenship, killed_by
order by no_of_deaths desc;

create view ammunitionused as 
select ammunition, count(*) as ammunitions_used from fatalities_isr_pse
where ammunition != 'null'
group by ammunition
order by ammunitions_used desc;

create view injurytypebycit_place as
select citizenship, place_of_residence_district, type_of_injury, count(*) as injury_by_location from fatalities_isr_pse
where citizenship != 'null' and place_of_residence_district != 'null' and type_of_injury != 'null'
group by citizenship, place_of_residence_district, type_of_injury
order by injury_by_location desc;

create view event_death_margin as 
select type_of_injury, date_of_event, date_of_death, datediff(date_of_death, date_of_event) as event_death_margin_days from fatalities_isr_pse
where type_of_injury != 'null'
-- group by type_of_injury, date_of_event, date_of_death
order by event_death_margin_days desc;

select * from tookpartinhostilities
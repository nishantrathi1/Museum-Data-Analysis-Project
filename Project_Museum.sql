--1) Fetch all the paintings which are not displayed on any museums?

select * from work$
where museum_id is null

--2) Are there museuems without any paintings?

select * from museum$ where 
museum_id is null

--3) How many paintings have an asking price of more than their regular price? 

select * from product_size$
where sale_price > regular_price

--4) Identify the paintings whose asking price is less than 50% of its regular price

select * from product_size$
where sale_price < (0.5 * regular_price)

--5) Which canva size costs the most?

select * from canvas_size$
select * from product_size$

select cs.size_id, 
max(sale_price) as price
from canvas_size$ cs join product_size$ ps
on cs.size_id = ps.size_id
group by cs.size_id
order by MAX(sale_price) desc


--6) Delete duplicate records from work, product_size, subject and image_link tables
select * from work$
select count(work_id) as count_, work_id from work$
group by work_id
having count(work_id) >1

select count(work_id) as count_, work_id from product_size$
group by work_id
having count(work_id) >1

select count(work_id) as count_, work_id from subject$
group by work_id
having count(work_id) >1

select count(work_id) as count_, work_id from image_link$
group by work_id
having count(work_id) >1

--7) Identify the museums with invalid city information in the given dataset

select * from museum$
where city is null

--8) Museum_Hours table has 1 invalid entry. Identify it and remove it.

select * from museum_hours$

		SELECT distinct cast([close] as time)
		FROM Museum_Hours$
		WHERE isdate([close]) = 1;

--10) Identify the museums which are open on both Sunday and Monday. Display museum name, city.

select distinct name,city from museum$ m 
join museum_hours$ mh on
m.museum_id = mh.museum_id
where day in ('Sunday','Monday')
group by name,city
HAVING COUNT(DISTINCT mh.day) = 2;

--11) How many museums are open every single day?

select count(*) as count_
from (select museum_id from museum_hours$
where day in ('Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday')
group by museum_id
having COUNT(DISTINCT day) = 7) as d

--12) Which are the top 5 most popular museum? (Popularity is defined based on most no of paintings in a museum)

select count(work_id) as count_, museum_id 
from work$
where museum_id is not null
group by museum_id
order by count(work_id) desc
limit 5

--13) Who are the top 5 most popular artist? (Popularity is defined based on most no of paintings done by an artist)

select * from artist$
select * from work$

select count(w.work_id) as no_of_paintings, a.full_name,a.nationality
from work$ w join artist$ a
on w.artist_id = a.artist_id
group by w.artist_id,a.full_name,a.nationality
order by count(w.work_id) desc

--14) Display the 3 least popular canva sizes

select * from canvas_size$
select * from product_size$

select count(ps.size_id) as no_of_counts, cs.label,
DENSE_RANK() over (order by count(ps.size_id)) as rnk
from product_size$ ps join canvas_size$ cs
on ps.size_id = cs.size_id
group by ps.size_id ,cs.label

--15) Which museum is open for the longest during a day. Dispay museum name, state and hours open and which day?

select * from museum_hours$
select * from museum$

select m.name,m.state,mh.day, CAST(CAST(mh.close AS datetime) - CAST(mh.open AS datetime) AS time) AS duration
from museum$ m join museum_hours$ mh
on m.museum_id = mh.museum_id

--16) Which museum has the most no of most popular painting style?

select * from museum$
select * from work$

select count(w.work_id), m.name,w.style
from museum$ m join work$ w
on m.museum_id = w.museum_id
group by m.name,w.style
order by count(w.work_id) desc

--17) Identify the artists whose paintings are displayed in multiple countries

select * from museum$
select * from artist$
select * from work$

with cte as (
select distinct a.full_name,m.country 
from work$ w join artist$ a on 
a.artist_id = w.artist_id join museum$ m
on m.museum_id = w.museum_id)
select full_name,count(country) 
from
cte
group by full_name 
having count(country) >1


with cte as
		(select distinct a.full_name as artist
		--, w.name as painting, m.name as museum
		, m.country
		from work$ w
		join artist$ a on a.artist_id=w.artist_id
		join museum$ m on m.museum_id=w.museum_id)
	select artist,count(1) as no_of_countries
	from cte
	group by artist
	having count(1)>1
	order by 2 desc;

	--18) Display the country and the city with most no of museums. Output 2 seperate columns to mention the city and country. 
	--If there are multiple value, seperate them with comma.


select city, country,count(*) as museum_count
from museum$
group by city, country
order by museum_count desc



--19 Identify the artist and the museum where the most expensive and least expensive painting is placed.
--Display the artist name, sale_price, painting name, museum name, museum city and canvas label 

select * from product_size$
select * from work$
select * from canvas_size$
select * from artist$
select * from museum$




--20 Which country has the 5th highest no of paintings?

select * from museum$
select * from work$

with cte as(
select m.country, count(w.name) as no_of_paintings,
rank() over (order by count(w.name) desc) as rnk_
from museum$ m join work$ w
on m.museum_id = w.museum_id
group by m.country
)
select country, no_of_paintings
from cte 
where rnk_ = 5

select m.country, count(w.name) as no_of_paintings
from museum$ m join work$ w
on m.museum_id = w.museum_id
group by m.country
order by count(w.name) desc

-- 21) Which are the 3 most popular and 3 least popular painting styles?

select * from work$

with cte as(
select style, count(*) as count_,
rank() over (order by count(*) desc) as rnk_,count(1) over()as records
from work$
where style is not null
group by style)
select style, count_
from cte where rnk_ > records - 3 or rnk_ < 4


--22) Which artist has the most no of Portraits paintings outside USA?. 
--Display artist name, no of paintings and the artist nationality.

select * from subject$
select * from museum$
select * from work$
select * from artist$
	
select a.full_name,a.nationality,count(m.name) as no_of_paintings
from work$ w join artist$ a
on a.artist_id = w.artist_id join museum$ m on
m.museum_id = w.museum_id join subject$ s on
w.work_id = s.work_id
where m.country not in ('USA')
and s.subject = 'Portraits'
group by a.full_name,a.nationality
order by count(m.name) desc

























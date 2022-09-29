create table [Table A] (dimension_1 varchar(10), dimension_2 varchar(10), dimension_3 varchar(10), measure_1 int);
create table [Table B] (dimension_1 varchar(10), dimension_2 varchar(10), measure_2 int);
create table [Table MAP] (dimension_1 varchar(10), correct_dimension_2 varchar(10));

insert into [Table A] values ('a','I','K','1')
insert into [Table A] values ('a','J','L','7')
insert into [Table A] values ('b','I','M','2')
insert into [Table A] values ('c','J','N','5')

insert into [Table B] values ('a','J',7)
insert into [Table B] values ('b','J',10)
insert into [Table B] values ('d','J',4)

insert into [Table MAP] values ('a','W')
insert into [Table MAP] values ('a','W')
insert into [Table MAP] values ('b','X')
insert into [Table MAP] values ('c','Y')
insert into [Table MAP] values ('b','X')
insert into [Table MAP] values ('d','Z')

select * from [Table A]
select * from [Table B]
select * from [Table MAP]
;
with 
m as (
	SELECT DISTINCT dimension_1, correct_dimension_2 FROM [Table MAP]
),
t as (
	SELECT a.dimension_1, m.correct_dimension_2, measure_1, 0 measure_2 
	FROM [Table A] a
	LEFT JOIN m ON m.dimension_1=a.dimension_1

	UNION ALL

	SELECT b.dimension_1, m.correct_dimension_2, 0,  measure_2 
	FROM [Table B] b
	LEFT JOIN m ON m.dimension_1=b.dimension_1
)
SELECT 
	 t.dimension_1
	,t.correct_dimension_2 dimension_2
	,sum(t.measure_1) measure_1
	,sum(t.measure_2) measure_1
FROM t 
GROUP BY t.dimension_1, t.correct_dimension_2  
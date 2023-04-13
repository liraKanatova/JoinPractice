alter table mentors add unique (email);

--1 Получите все записи таблицы groups
select * from groups;
--2 Получите общее количество записей таблицы groups
select  count(*)from groups ;
--3 Выведите группы их курсы
select group_name,c.course_name from groups join courses c on groups.id=c.id ;
--4 Выведите курсы групп у которых курс начался с 2020-1-1 по 2023-3-3
select * from groups join courses c on groups.id=c.id where date_of_start between '2020-1-1'and '2023-3-3';
--5 Выведите  имена,  дату  рождения  студентов  ,  которые  родились  с  1980-1-1  по  2004-12-12,  и  название группы
select first_name,date_of_birth,g.group_name from students
join groups g on students.id=g.id  where date_of_birth between '1980-1-1 ' and '2004-12-12';
--6 Выведите суммарный возраст всех студентов курса 'Python'
alter table students add column age int;
update students set age=date_part('year',age(current_date,date_of_birth));
select sum(age) from students join groups g on students.id=g.id join courses c on students.id=c.id where course_name='Python';
--7 Вывести полное имя, возраст, почту студентов и название группы, где айди группы равен 3
select concat(first_name,' ',last_name) full_name, age,email, group_name from students join groups g on g.id=students.group_id where g.id=3;
--8 Вывести все курсы одной группы, где название группы  'Java-9'
select course_name,group_name from groups join courses c on groups.id = c.group_id where group_name='Java-9';
--9 Вывести название всех групп и количество студентов в группе
select g.group_name,count(*) from students join groups g on g.id=students.group_id group by  group_name;
--10 Вывести название всех групп и количество студентов в группе, если в группе больше 4 студентов
select g.group_name,count(*) from students join groups g on g.id=students.group_id group by g.group_name having count(*)>4;
--11 Отсортируйте  имена  студентов  группы  по  убыванию,  где  айди  группы  равна  4  и  выведите  айди
-- студента, имя, пол и название группы
select s.id,s.first_name,s.group_id,group_name from groups
join students s on groups.id = s.group_id where group_id=4 order by s.first_name desc;

-- Вывести все курсы
select * from courses;
-- Вывести все уроки курса 'Technical English'
select course_name,l.lesson_name from courses left join lessons l on courses.id=l.course_id where course_name='Technical English';
-- Вывести количество всех студентов курса id = 4
select  count(*) from courses join groups g on courses.group_id=g.id join students s on g.id=s.group_id where courses.id=4;
-- Вывести имя, почту, специализацию ментора и название курса где курс айди равен 2
select m.first_name, m.email,m.specialization,course_name from courses join mentors m on courses.id=m.course_id  where courses.id=2;
-- Посчитить сколько менторов в каждом курсе
select m.first_name, count(course_name) as total_course from courses
join mentors m on courses.id=m.course_id group by m.first_name order by m.first_name;
--  Сгруппируйте  и  посчитайте  менторов  в  каждом  курсе  и  выведите  только  те  курсы,  где  в  курсе больше 2 менторов

--  Вывести  название,  дату  и  полное  имя  ментора,  все  курсы  которые  начинаются  с  2020-1-1  по 2023-3-3
select course_name,date_of_start,m.first_name from courses left join mentors m on courses.id=m.course_id where date_of_start between  '2020-1-1' and '2023-3-3';
-- Вывести имя, почту, возраст студентов курса 'Java
select course_name,first_name,email,age from courses join students s on courses.group_id = s.group_id where course_name='Java';
-- Вывести тот курс у где нет ментора
select course_name,m.first_name from courses left join  mentors m on courses.id=m.course_id where m.first_name is null ;
-- Вывести тот курс у где нет уроков
select course_name,l.lesson_name from courses left join lessons l on courses.id=l.course_id where l.lesson_name is null ;
-- Вывести тот курс у где нет студентов
select course_name,s.first_name from courses left join students s on courses.group_id = s.group_id where s.first_name is null;

select * from students;
--1 Вывести общее количество студентов
select count(*) from students;
--2 Вывести общее количество студентов, которым 18 и старше
select count(*)  from students s where age>=18;
--3 Вывести имя, почту и пол студента, айди группы которого равна 2
select id,first_name,email,gender from students where id=2;
--4 Вывести суммарный возраст всех студентов, которые младше 20
select sum(age) from students where age<18;
--5 Вывести группу студента, айди которого равна 4
select g.group_name,first_name from students join groups g on g.id=students.group_id where students.id=4;
--6 Сгруппируйте студентов по gender и выведите общее количество gender
select  gender,count(gender) from students group by gender;
--7 Найдите студента с айди 8 и обновите его данные
update students set first_name='Bella',last_name='Hadid',email='bella@gmail.com'where id=8;
--8 Найдите самого старшего студента курса, айди курса которого равна 5
select first_name,course_name,age from students join groups g on g.id = students.group_id
join courses c on g.id = c.group_id where c.id=5 order by age desc limit 1;
--9 Добавьте unique constraint email в столбец таблицы students
alter table students add unique (email);
--10 Добавьте check constraint gender в столбец таблицы mentors
alter table mentors add constraint gender check ( gender='Female' or gender= 'Male');
--11 Добавьте check constraint gender в столбец таблицы students
alter table students add constraint gender check ( gender='Female' or gender='Male');
--12 Переименуйте таблицу mentors в instructors
alter table mentors rename to instructors;


select * from instructors;
--1 Вывести средний возраст всех менторов

--2 Вывести имя, почту и специализацию ментора группы 'Java-9'
select first_name,email,specialization from instructors
join courses c on c.id = instructors.course_id join groups g on g.id = c.group_id where group_name='Java-9';
--3 Вывести всех менторов, чей опыт превышает 1 год
select * from instructors where experience>1;
--4 Вывести ментора у которого нет курса
select first_name,course_name from instructors left join courses c on c.id = instructors.course_id where course_name is null ;
--5 Вывести айди, имя ментора и его студентов
select instructors.id,instructors.first_name,s.first_name,c.course_name from instructors join courses c on c.id = instructors.course_id
join groups g on g.id = c.group_id join students s on g.id = s.group_id;
--6 Посчитать сколько студентов у каждого ментора, и вывести полное имя ментора и количество его студентов
select concat(instructors.first_name,' ',instructors.last_name) full_name,count(s.first_name)as student from instructors join courses c on c.id=instructors.course_id                                                                                                                     join groups g on g.id=c.group_id join students s on g.id=s.group_id group by full_name order by full_name;
--7 Вывести ментора у которого нет студентов

--8 Вывести ментора у которого студентов больше чем 2
select instructors.first_name,count(s.first_name)as total_student from instructors
join courses c on c.id = instructors.course_id join groups g on g.id = c.group_id
join students s on g.id = s.group_id group by instructors.first_name having count(s.first_name)>2;
--9 Вывести курсы ментора с айди 5
select c.course_name,instructors.first_name from instructors join courses c on c.id = instructors.course_id where instructors.id=5;
--10 Вывести все уроки ментора, айди которого равен 5
select l.lesson_name,instructors.first_name from instructors join courses c on c.id=instructors.course_id
join lessons l on l.course_id=c.id where instructors.id=5;


--1 Вывести все уроки
select * from lessons;
--2 Получить все уроки студента, айди которого равен 2
select lesson_name,s.first_name from lessons join courses c on lessons.course_id = c.id join groups g on g.id = c.group_id
join students s on g.id = s.group_id where s.id=2;
--3 Посчитать  уроки  каждой  группы  и  вывести  название  группы  и  количество  уроков,  где  количество уроков больше чем 2
select g.group_name,count(l.lesson_name)as total_lesson from lessons l join courses c on c.id=l.course_id
join groups g on c.group_id = g.id group by g.group_name having count(l.lesson_name)>2;
--4 Отсортировать уроки студента по названию, где айди студента равна 7
select lesson_name,s.first_name from lessons join courses c on lessons.course_id = c.id
join groups g on c.group_id = g.id join students s on g.id = s.group_id where s.id=7 order by lesson_name;
--5 Получить все уроки курса, где название курса 'Python kids'
select lesson_name,course_name from lessons full join courses c on c.id=lessons.course_id where course_name='Python kids';
--6 Получить все уроки ментора, айди которого равен 5
select lesson_name,i.first_name from lessons join courses c on lessons.course_id = c.id
join instructors i on lessons.course_id = i.course_id where i.id=5;


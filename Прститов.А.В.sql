--Задание 1: Выбрать номера компьютерных лабораторий с вакантной должностью заведующего
SELECT lab_number 
FROM laboratories 
WHERE head_id IS NULL;
--Задание 2: Выбрать номера лабораторий выпускающих кафедр
SELECT lab_number 
FROM laboratories 
WHERE department_id IN (
    SELECT id 
    FROM departments 
    WHERE is_graduating = TRUE
);
--Задание 3: Создать таблицу с данными из задания 1
SELECT l.lab_number, 
       d.department_name,
       l.equipment_type,
       l.work_places,
       l.floor_number
INTO vacant_labs
FROM laboratories l
JOIN departments d ON l.department_id = d.id
WHERE l.head_id IS NULL;



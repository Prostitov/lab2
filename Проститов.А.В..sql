--Задание 1 Выбрать номера компьютерных лабораторий, с вакантной должностью заведующего лабораторией.
SELECT laboratory_number 
FROM Laboratories 
WHERE head_of_lab IS NULL OR head_of_lab = '' OR head_of_lab = 'Вакансия';
--Задание 2 Выбрать номера всех лабораторий, входящих в состав выпускающих кафедр.
SELECT l.laboratory_number 
FROM Laboratories l
JOIN Departments d ON l.department_number = d.department_number
WHERE d.is_head_department = TRUE;
--Задание 3 Создать таблицу, содержащую данные 1 запроса с указанием кафедр, к которым относятся лаборатории, и данных из таблицы «лаборатории».
SELECT l.*, d.department_name
INTO Vacant_Laboratories
FROM Laboratories l
JOIN Departments d ON l.department_number = d.department_number
WHERE l.head_of_lab IS NULL OR l.head_of_lab = '' OR l.head_of_lab = 'Вакансия';
--Задание 4 Добавить в созданную таблицу все лаборатории кафедр, названия которых начинаются на согласные буквы.
SELECT 
    laboratory_number AS "№ Лаборатории", 
    lab_name AS "Название лаб.", 
    department_name AS "Название кафедры",
    UPPER(SUBSTRING(department_name FROM 1 FOR 1)) AS "Первая буква"
FROM Vacant_Laboratories;
INSERT INTO Vacant_Laboratories
SELECT l.*, d.department_name
FROM Laboratories l
JOIN Departments d ON l.department_number = d.department_number
WHERE d.department_name ~* '^[ВКНСПМФЦТЛБГРДЖЗ]';

--Задание 5 Увеличить количество рабочих мест в 2 раза всем лабораториям, имеющим проектное оборудование.
UPDATE Vacant_Laboratories
SET workstations_count = workstations_count * 2
WHERE has_project_equipment = TRUE;

--Задание 6 Из созданной таблицы удалить все записи для лабораторий, находящихся на 2 этаже. 
DELETE FROM Vacant_Laboratories
WHERE laboratory_number >= 200 AND laboratory_number < 300;

--Задание 7 Посчитать количество лабораторий и среднее количество оборудованных рабочих мест в лабораториях на каждой кафедре. 
SELECT department_number, 
       COUNT(*) AS labs_count, 
       ROUND(AVG(workstations_count), 2) AS avg_workstations
FROM Laboratories
GROUP BY department_number;

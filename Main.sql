--------------------Запрос на случай если надо очисть бд-------------------------

--USE PatrioticWar;
--go

--DROP TABLE IF EXISTS Soldiers;
--DROP TABLE IF EXISTS Operations;
--DROP TABLE IF EXISTS Divisions;
--DROP TABLE IF EXISTS ParticipatedIn;
--DROP TABLE IF EXISTS Сommanded;
--DROP TABLE IF EXISTS ServedWith;

--USE master;
--go
--DROP DATABASE PatrioticWar;
--go

--------------------------------------------------------------------------



USE master;
GO

IF NOT EXISTS (SELECT * FROM sys.databases WHERE NAME = 'PatrioticWar')
    CREATE DATABASE PatrioticWar;
GO

USE PatrioticWar;
GO

CREATE TABLE Soldiers (
    ID INT PRIMARY KEY,
    Фамилия NVARCHAR(50) NOT NULL,
    Имя NVARCHAR(50) NOT NULL,
    Отчество NVARCHAR(50),
    Звание NVARCHAR(50),
    ГодРождения INT,
    ГодСмерти INT
) AS NODE;

CREATE TABLE Operations (
    ID INT PRIMARY KEY,
    Название NVARCHAR(100) NOT NULL,
    ДатаНачала DATE,
    ДатаОкончания DATE,
    Результат NVARCHAR(50)
) AS NODE;

CREATE TABLE Divisions (
    ID INT PRIMARY KEY,
    Название NVARCHAR(100) NOT NULL,
    Тип NVARCHAR(50),
    ГодСоздания INT
) AS NODE;

-- УчаствовалВ
CREATE TABLE ParticipatedIn AS EDGE;

-- Командовал
CREATE TABLE Сommanded AS EDGE;

-- СлужилС
CREATE TABLE ServedWith AS EDGE;

INSERT INTO Soldiers (ID, Фамилия, Имя, Отчество, Звание, ГодРождения, ГодСмерти) VALUES
(1, 'Жуков', 'Георгий', 'Константинович', 'Маршал Советского Союза', 1896, 1974),
(2, 'Рокоссовский', 'Константин', 'Константинович', 'Маршал Советского Союза', 1896, 1968),
(3, 'Ватутин', 'Николай', 'Фёдорович', 'Генерал армии', 1901, 1944),
(4, 'Чуйков', 'Василий', 'Иванович', 'Генерал-полковник', 1900, 1982),
(5, 'Зайцев', 'Василий', 'Григорьевич', 'Капитан', 1915, 1991),
(6, 'Кожедуб', 'Иван', 'Никитович', 'Маршал авиации', 1920, 1991),
(7, 'Демьянская', 'Зоя', 'Анатольевна', 'Красноармеец', 1923, 1941),
(8, 'Гастелло', 'Николай', 'Францевич', 'Капитан', 1907, 1941),
(9, 'Карбышев', 'Дмитрий', 'Михайлович', 'Генерал-лейтенант', 1880, 1945),
(10, 'Павлов', 'Яков', 'Федотович', 'Старший лейтенант', 1917, 1981);

INSERT INTO Operations (ID, Название, ДатаНачала, ДатаОкончания, Результат) VALUES
(1, 'Оборона Москвы', '1941-09-30', '1942-04-20', 'Победа СССР'),
(2, 'Сталинградская битва', '1942-07-17', '1943-02-02', 'Победа СССР'),
(3, 'Курская битва', '1943-07-05', '1943-08-23', 'Победа СССР'),
(4, 'Операция Багратион', '1944-06-22', '1944-08-29', 'Победа СССР'),
(5, 'Берлинская операция', '1945-04-16', '1945-05-08', 'Победа СССР'),
(6, 'Оборона Бреста', '1941-06-22', '1941-07-20', 'Победа Германии'),
(7, 'Прорыв блокады Ленинграда', '1943-01-12', '1944-01-27', 'Победа СССР'),
(8, 'Смоленское сражение', '1941-07-10', '1941-09-10', 'Победа Германии'),
(9, 'Харьковская операция', '1942-05-12', '1942-05-29', 'Поражение СССР'),
(10, 'Висло-Одерская операция', '1945-01-12', '1945-02-03', 'Победа СССР');

INSERT INTO Divisions (ID, Название, Тип, ГодСоздания) VALUES
(1, '150-я стрелковая дивизия', 'Стрелковая', 1940),
(2, '6-я гвардейская танковая армия', 'Танковая', 1943),
(3, '316-я стрелковая дивизия', 'Стрелковая', 1941),
(4, '1-я воздушная армия', 'Авиационная', 1942),
(5, '62-я армия', 'Общевойсковая', 1942),
(6, '3-й гвардейский кавалерийский корпус', 'Кавалерийский', 1941),
(7, '8-я гвардейская армия', 'Общевойсковая', 1941),
(8, '4-я ударная армия', 'Общевойсковая', 1941),
(9, '5-я гвардейская танковая армия', 'Танковая', 1943),
(10, '2-я гвардейская армия', 'Общевойсковая', 1942);

INSERT INTO ParticipatedIn ($from_id, $to_id)
VALUES
((SELECT $node_id FROM Soldiers WHERE ID = 1), (SELECT $node_id FROM Operations WHERE ID = 1)),
((SELECT $node_id FROM Soldiers WHERE ID = 1), (SELECT $node_id FROM Operations WHERE ID = 3)),
((SELECT $node_id FROM Soldiers WHERE ID = 1), (SELECT $node_id FROM Operations WHERE ID = 5)),
((SELECT $node_id FROM Soldiers WHERE ID = 2), (SELECT $node_id FROM Operations WHERE ID = 1)),
((SELECT $node_id FROM Soldiers WHERE ID = 2), (SELECT $node_id FROM Operations WHERE ID = 4)),
((SELECT $node_id FROM Soldiers WHERE ID = 4), (SELECT $node_id FROM Operations WHERE ID = 2)),
((SELECT $node_id FROM Soldiers WHERE ID = 4), (SELECT $node_id FROM Operations WHERE ID = 5)),
((SELECT $node_id FROM Soldiers WHERE ID = 3), (SELECT $node_id FROM Operations WHERE ID = 9)),
((SELECT $node_id FROM Soldiers WHERE ID = 5), (SELECT $node_id FROM Operations WHERE ID = 10)),
((SELECT $node_id FROM Soldiers WHERE ID = 6), (SELECT $node_id FROM Operations WHERE ID = 10)),
((SELECT $node_id FROM Soldiers WHERE ID = 7), (SELECT $node_id FROM Operations WHERE ID = 8)),
((SELECT $node_id FROM Soldiers WHERE ID = 8), (SELECT $node_id FROM Operations WHERE ID = 6)),
((SELECT $node_id FROM Soldiers WHERE ID = 9), (SELECT $node_id FROM Operations WHERE ID = 7)),
((SELECT $node_id FROM Soldiers WHERE ID = 10), (SELECT $node_id FROM Operations WHERE ID = 2));



INSERT INTO Сommanded ($from_id, $to_id)
VALUES
((SELECT $node_id FROM Soldiers WHERE ID = 1), (SELECT $node_id FROM Divisions WHERE ID = 7)),
((SELECT $node_id FROM Soldiers WHERE ID = 2), (SELECT $node_id FROM Divisions WHERE ID = 1)),
((SELECT $node_id FROM Soldiers WHERE ID = 3), (SELECT $node_id FROM Divisions WHERE ID = 2)),
((SELECT $node_id FROM Soldiers WHERE ID = 4), (SELECT $node_id FROM Divisions WHERE ID = 5)),
((SELECT $node_id FROM Soldiers WHERE ID = 5), (SELECT $node_id FROM Divisions WHERE ID = 3)),
((SELECT $node_id FROM Soldiers WHERE ID = 6), (SELECT $node_id FROM Divisions WHERE ID = 4)),
((SELECT $node_id FROM Soldiers WHERE ID = 7), (SELECT $node_id FROM Divisions WHERE ID = 6)),
((SELECT $node_id FROM Soldiers WHERE ID = 8), (SELECT $node_id FROM Divisions WHERE ID = 8)),
((SELECT $node_id FROM Soldiers WHERE ID = 9), (SELECT $node_id FROM Divisions WHERE ID = 10)),
((SELECT $node_id FROM Soldiers WHERE ID = 10), (SELECT $node_id FROM Divisions WHERE ID = 9));



INSERT INTO ServedWith ($from_id, $to_id)
VALUES
((SELECT $node_id FROM Soldiers WHERE ID = 4), (SELECT $node_id FROM Soldiers WHERE ID = 5)),
((SELECT $node_id FROM Soldiers WHERE ID = 5), (SELECT $node_id FROM Soldiers WHERE ID = 10)),
((SELECT $node_id FROM Soldiers WHERE ID = 10), (SELECT $node_id FROM Soldiers WHERE ID = 4)),
((SELECT $node_id FROM Soldiers WHERE ID = 7), (SELECT $node_id FROM Soldiers WHERE ID = 8)),
((SELECT $node_id FROM Soldiers WHERE ID = 8), (SELECT $node_id FROM Soldiers WHERE ID = 9)),
((SELECT $node_id FROM Soldiers WHERE ID = 7), (SELECT $node_id FROM Soldiers WHERE ID = 2)),
((SELECT $node_id FROM Soldiers WHERE ID = 6), (SELECT $node_id FROM Soldiers WHERE ID = 1)),
((SELECT $node_id FROM Soldiers WHERE ID = 1), (SELECT $node_id FROM Soldiers WHERE ID = 2)),
((SELECT $node_id FROM Soldiers WHERE ID = 2), (SELECT $node_id FROM Soldiers WHERE ID = 3)),
((SELECT $node_id FROM Soldiers WHERE ID = 3), (SELECT $node_id FROM Soldiers WHERE ID = 4));



------------------MATCH------------------

SELECT 
    S.ID, 
    CONCAT(S.Фамилия, ' ', S.Имя) AS Солдат,
    O.Название AS Операция
FROM 
    dbo.Soldiers AS S,
    dbo.ParticipatedIn AS P,
    dbo.Operations AS O
WHERE 
    MATCH(S-(P)->O)
    AND O.Название = 'Сталинградская битва';

SELECT 
    S.Фамилия, S.Имя, O.Название AS Операция, O.Результат
FROM 
    dbo.Soldiers AS S, 
    dbo.ParticipatedIn AS P, 
    dbo.Operations AS O
WHERE 
    MATCH(S-(P)->O)
    AND S.ID = 1;

SELECT 
    D.Название AS Дивизия, 
    S.Фамилия, S.Имя, S.Звание
FROM 
    dbo.Soldiers AS S, 
    dbo.Сommanded AS C, 
    dbo.Divisions AS D
WHERE 
    MATCH(S-(C)->D)
    AND D.ID = 7;


SELECT 
    S1.Фамилия AS Солдат1, 
    S2.Фамилия AS Солдат2
FROM 
    dbo.Soldiers AS S1, 
    dbo.ServedWith AS SW, 
    dbo.Soldiers AS S2
WHERE 
    MATCH(S1-(SW)->S2)
    AND S1.ID = 4;


SELECT 
    O.Название AS Операция, 
    D.Название AS Дивизия, 
    S.Фамилия AS Командир
FROM 
    dbo.Operations AS O, 
    dbo.ParticipatedIn AS P, 
    dbo.Soldiers AS S,
	dbo.Сommanded AS C, 
    dbo.Divisions AS D
WHERE 
    MATCH(O<-(P)-S-(C)->D)
    AND O.ID = 5;



------------------Shortest_path------------------

SELECT 
    P1.Имя AS StartSoldier,
    STRING_AGG(CONCAT(A2.Название, ', ', A2.Результат), ' -> ') 
        WITHIN GROUP (GRAPH PATH) AS PathToOperations
FROM Soldiers AS P1,
     ParticipatedIn FOR PATH AS pa,
     Operations FOR PATH AS A2
WHERE MATCH(SHORTEST_PATH(P1(-(pa)->A2)+))
  AND P1.Имя = 'Василий';


SELECT 
    P1.Имя AS StartSoldier,
    STRING_AGG(CONCAT(A2.Название, ', ', A2.Результат), ' -> ') 
        WITHIN GROUP (GRAPH PATH) AS PathToOperations
FROM Soldiers AS P1,
     ParticipatedIn FOR PATH AS pa,
     Operations FOR PATH AS A2
WHERE MATCH(SHORTEST_PATH(P1(-(pa)->A2){1,3}))
  AND P1.Имя = 'Константин';


  ------------------Power BI------------------

SELECT @@SERVERNAME

SELECT S1.ID IdFirst

,CONCAT(S1.Фамилия, ' ', S1.Имя) AS First
,CONCAT(N'Soldiers', S1.id) AS [First image name]
,S2.ID AS IdSecond
,CONCAT(S2.Фамилия, ' ', S2.Имя) AS Second
,CONCAT(N'Soldiers', S2.id) AS [Second image name]

FROM dbo.Soldiers AS S1
,dbo. ServedWith AS Ser
,dbo.Soldiers AS S2
WHERE MATCH (S1-(Ser)->S2)


SELECT
    S1.ID AS IdFirst,
    S1.Фамилия AS First,
    CONCAT(N'Soldiers', S1.ID) AS [First image name],
    O.ID AS IdSecond,  
    O.Название AS Second,  
    CONCAT(N'Operations', O.ID) AS [Second image name]  
FROM
    dbo.Soldiers AS S1,
    dbo.ParticipatedIn AS Part,
    dbo.Operations AS O
WHERE
    MATCH(S1-(Part)->O)


SELECT
    S.ID AS IdFirst,
    S.Фамилия AS First,
    CONCAT(N'Soldiers', S.ID) AS [First image name],
    D.ID AS IdSecond,  
    D.Название AS Second,  
    CONCAT(N'Divisions', D.ID) AS [Second image name]  
FROM
    dbo.Soldiers AS S,
    dbo.Сommanded AS C,
    dbo.Divisions AS D
WHERE
    MATCH(S-(C)->D)

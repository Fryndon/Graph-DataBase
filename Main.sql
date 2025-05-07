--------------------������ �� ������ ���� ���� ������ ��-------------------------

--USE PatrioticWar;
--go

--DROP TABLE IF EXISTS Soldiers;
--DROP TABLE IF EXISTS Operations;
--DROP TABLE IF EXISTS Divisions;
--DROP TABLE IF EXISTS ParticipatedIn;
--DROP TABLE IF EXISTS �ommanded;
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
    ������� NVARCHAR(50) NOT NULL,
    ��� NVARCHAR(50) NOT NULL,
    �������� NVARCHAR(50),
    ������ NVARCHAR(50),
    ����������� INT,
    ��������� INT
) AS NODE;

CREATE TABLE Operations (
    ID INT PRIMARY KEY,
    �������� NVARCHAR(100) NOT NULL,
    ���������� DATE,
    ������������� DATE,
    ��������� NVARCHAR(50)
) AS NODE;

CREATE TABLE Divisions (
    ID INT PRIMARY KEY,
    �������� NVARCHAR(100) NOT NULL,
    ��� NVARCHAR(50),
    ����������� INT
) AS NODE;

-- �����������
CREATE TABLE ParticipatedIn AS EDGE;

-- ����������
CREATE TABLE �ommanded AS EDGE;

-- �������
CREATE TABLE ServedWith AS EDGE;

INSERT INTO Soldiers (ID, �������, ���, ��������, ������, �����������, ���������) VALUES
(1, '�����', '�������', '��������������', '������ ���������� �����', 1896, 1974),
(2, '������������', '����������', '��������������', '������ ���������� �����', 1896, 1968),
(3, '�������', '�������', 'Ը�������', '������� �����', 1901, 1944),
(4, '������', '�������', '��������', '�������-���������', 1900, 1982),
(5, '������', '�������', '�����������', '�������', 1915, 1991),
(6, '�������', '����', '���������', '������ �������', 1920, 1991),
(7, '����������', '���', '�����������', '������������', 1923, 1941),
(8, '��������', '�������', '���������', '�������', 1907, 1941),
(9, '��������', '�������', '����������', '�������-���������', 1880, 1945),
(10, '������', '����', '���������', '������� ���������', 1917, 1981);

INSERT INTO Operations (ID, ��������, ����������, �������������, ���������) VALUES
(1, '������� ������', '1941-09-30', '1942-04-20', '������ ����'),
(2, '�������������� �����', '1942-07-17', '1943-02-02', '������ ����'),
(3, '������� �����', '1943-07-05', '1943-08-23', '������ ����'),
(4, '�������� ���������', '1944-06-22', '1944-08-29', '������ ����'),
(5, '���������� ��������', '1945-04-16', '1945-05-08', '������ ����'),
(6, '������� ������', '1941-06-22', '1941-07-20', '������ ��������'),
(7, '������ ������� ����������', '1943-01-12', '1944-01-27', '������ ����'),
(8, '���������� ��������', '1941-07-10', '1941-09-10', '������ ��������'),
(9, '����������� ��������', '1942-05-12', '1942-05-29', '��������� ����'),
(10, '�����-�������� ��������', '1945-01-12', '1945-02-03', '������ ����');

INSERT INTO Divisions (ID, ��������, ���, �����������) VALUES
(1, '150-� ���������� �������', '����������', 1940),
(2, '6-� ����������� �������� �����', '��������', 1943),
(3, '316-� ���������� �������', '����������', 1941),
(4, '1-� ��������� �����', '�����������', 1942),
(5, '62-� �����', '�������������', 1942),
(6, '3-� ����������� ������������� ������', '�������������', 1941),
(7, '8-� ����������� �����', '�������������', 1941),
(8, '4-� ������� �����', '�������������', 1941),
(9, '5-� ����������� �������� �����', '��������', 1943),
(10, '2-� ����������� �����', '�������������', 1942);

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



INSERT INTO �ommanded ($from_id, $to_id)
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
    CONCAT(S.�������, ' ', S.���) AS ������,
    O.�������� AS ��������
FROM 
    dbo.Soldiers AS S,
    dbo.ParticipatedIn AS P,
    dbo.Operations AS O
WHERE 
    MATCH(S-(P)->O)
    AND O.�������� = '�������������� �����';

SELECT 
    S.�������, S.���, O.�������� AS ��������, O.���������
FROM 
    dbo.Soldiers AS S, 
    dbo.ParticipatedIn AS P, 
    dbo.Operations AS O
WHERE 
    MATCH(S-(P)->O)
    AND S.ID = 1;

SELECT 
    D.�������� AS �������, 
    S.�������, S.���, S.������
FROM 
    dbo.Soldiers AS S, 
    dbo.�ommanded AS C, 
    dbo.Divisions AS D
WHERE 
    MATCH(S-(C)->D)
    AND D.ID = 7;


SELECT 
    S1.������� AS ������1, 
    S2.������� AS ������2
FROM 
    dbo.Soldiers AS S1, 
    dbo.ServedWith AS SW, 
    dbo.Soldiers AS S2
WHERE 
    MATCH(S1-(SW)->S2)
    AND S1.ID = 4;


SELECT 
    O.�������� AS ��������, 
    D.�������� AS �������, 
    S.������� AS ��������
FROM 
    dbo.Operations AS O, 
    dbo.ParticipatedIn AS P, 
    dbo.Soldiers AS S,
	dbo.�ommanded AS C, 
    dbo.Divisions AS D
WHERE 
    MATCH(O<-(P)-S-(C)->D)
    AND O.ID = 5;



------------------Shortest_path------------------

SELECT 
    P1.��� AS StartSoldier,
    STRING_AGG(CONCAT(A2.��������, ', ', A2.���������), ' -> ') 
        WITHIN GROUP (GRAPH PATH) AS PathToOperations
FROM Soldiers AS P1,
     ParticipatedIn FOR PATH AS pa,
     Operations FOR PATH AS A2
WHERE MATCH(SHORTEST_PATH(P1(-(pa)->A2)+))
  AND P1.��� = '�������';


SELECT 
    P1.��� AS StartSoldier,
    STRING_AGG(CONCAT(A2.��������, ', ', A2.���������), ' -> ') 
        WITHIN GROUP (GRAPH PATH) AS PathToOperations
FROM Soldiers AS P1,
     ParticipatedIn FOR PATH AS pa,
     Operations FOR PATH AS A2
WHERE MATCH(SHORTEST_PATH(P1(-(pa)->A2){1,3}))
  AND P1.��� = '����������';


  ------------------Power BI------------------

SELECT @@SERVERNAME

SELECT S1.ID IdFirst

,CONCAT(S1.�������, ' ', S1.���) AS First
,CONCAT(N'Soldiers', S1.id) AS [First image name]
,S2.ID AS IdSecond
,CONCAT(S2.�������, ' ', S2.���) AS Second
,CONCAT(N'Soldiers', S2.id) AS [Second image name]

FROM dbo.Soldiers AS S1
,dbo. ServedWith AS Ser
,dbo.Soldiers AS S2
WHERE MATCH (S1-(Ser)->S2)


SELECT
    S1.ID AS IdFirst,
    S1.������� AS First,
    CONCAT(N'Soldiers', S1.ID) AS [First image name],
    O.ID AS IdSecond,  
    O.�������� AS Second,  
    CONCAT(N'Operations', O.ID) AS [Second image name]  
FROM
    dbo.Soldiers AS S1,
    dbo.ParticipatedIn AS Part,
    dbo.Operations AS O
WHERE
    MATCH(S1-(Part)->O)


SELECT
    S.ID AS IdFirst,
    S.������� AS First,
    CONCAT(N'Soldiers', S.ID) AS [First image name],
    D.ID AS IdSecond,  
    D.�������� AS Second,  
    CONCAT(N'Divisions', D.ID) AS [Second image name]  
FROM
    dbo.Soldiers AS S,
    dbo.�ommanded AS C,
    dbo.Divisions AS D
WHERE
    MATCH(S-(C)->D)

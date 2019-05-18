---------------GET NUM OF PATIENT WITH DIAGNOSIS S,T,K---------------------------

SELECT COUNT(DISTINCT A.PATIENT_ID)
FROM
(
SELECT DISTINCT PRESCRIPTIONS.PATIENT_ID,birthdate,
COUNT(DISTINCT ATC_CODE) AS ATC_SUM
FROM PRESCRIPTIONS 
WHERE (ATC_CODE IN (SELECT CODE FROM ATC4CODES) OR ATC_CODE LIKE 'G03C%' OR ATC_CODE LIKE 'N05A%' )
GROUP BY PRESCRIPTIONS.PATIENT_ID,birthdate
) A INNER JOIN PRESCRIPTIONS ON PRESCRIPTIONS.PATIENT_ID=A.PATIENT_ID
--WHERE ICD10_CODE LIKE '%S%'
--WHERE ICD10_CODE LIKE '%T%' AND ICD10_CODE NOT LIKE '%T8%' AND ICD10_CODE NOT LIKE '%T9%'
WHERE ICD10_CODE LIKE '%K2%' OR ICD10_CODE  LIKE '%K30%' OR ICD10_CODE  LIKE '%K31%' 



SELECT COUNT(DISTINCT PATIENT_ID)
FROM PRESCRIPTIONS
--WHERE ICD10_CODE LIKE '%S%'
--WHERE ICD10_CODE LIKE '%T%' AND ICD10_CODE NOT LIKE '%T8%' AND ICD10_CODE NOT LIKE '%T9%'
WHERE ICD10_CODE LIKE '%K2%' OR ICD10_CODE  LIKE '%K30%' OR ICD10_CODE  LIKE '%K31%' 

-------------------------------------------------------------------------------




--------------GET PATIENTS FOR SPECIFIC AGE AND ATC4CODES NUMBER-----------
DECLARE @AGE NVARCHAR(20)
SET @AGE='100+'

DECLARE @NUMOFATCs INT
SET @NUMOFATCs=1

SELECT DISTINCT PATIENT_ID,birthdate,
COUNT(DISTINCT ATC_CODE) AS ATC_SUM
FROM PRESCRIPTIONS 
WHERE (ATC_CODE IN (SELECT CODE FROM ATC4CODES) OR ATC_CODE LIKE 'G03C%' OR ATC_CODE LIKE 'N05A%' ) AND BIRTHDATE=@AGE
GROUP BY PATIENT_ID,birthdate
HAVING COUNT(DISTINCT ATC_CODE)=@NUMOFATCs



SELECT COUNT(DISTINCT PATIENT_ID)
FROM PRESCRIPTIONS
WHERE BIRTHDATE=@AGE


-------------------------------------------------------------------------------



--------------------------GET PATIENTS WITH AT LEAST ONE ATC4CODE----------------
SELECT DISTINCT PATIENT_ID,birthdate,
COUNT(DISTINCT ATC_CODE) AS ATC_SUM
FROM PRESCRIPTIONS 
WHERE (ATC_CODE IN (SELECT CODE FROM ATC4CODES) OR ATC_CODE LIKE 'G03C%' OR ATC_CODE LIKE 'N05A%' )
GROUP BY PATIENT_ID,birthdate
ORDER BY PATIENT_ID ASC
---------------------------------------------------------------------------------



------------------------GET NUMBER OF PRESCRIPTIONS AND DISTINCT PATIENTS--------------
SELECT COUNT(*) FROM PRESCRIPTIONS;
SELECT COUNT(DISTINCT PATIENT_ID) FROM PRESCRIPTIONS;

--SELECT PATIENT_ID,ATC_CODE FROM PRESCRIPTIONS 
--WHERE PATIENT_ID='00167E67A817B864CC5F08DF40652585C4F480D9' AND 
--(ATC_CODE IN(SELECT CODE FROM ATC4CODES) OR ATC_CODE LIKE 'G03C%' OR ATC_CODE LIKE 'N05A%')
----------------------------------------------------------------------------------------



------------------------GET NUMBER OF PATIENTS PER ATC4CODE NUMBER-------------------------------
SELECT 'AT LEAST 1' AS NUM_OF_ATCs,COUNT(*) AS NUM_OF_PATIENTS FROM
(
SELECT DISTINCT PATIENT_ID,birthdate,
COUNT(DISTINCT ATC_CODE) AS ATC_SUM
FROM PRESCRIPTIONS --INNER JOIN ATC4CODES ON ATC_CODE=CODE
WHERE (ATC_CODE IN (SELECT CODE FROM ATC4CODES) OR ATC_CODE LIKE 'G03C%' OR ATC_CODE LIKE 'N05A%' )
GROUP BY PATIENT_ID,birthdate
) A

UNION

SELECT '1' AS NUM_OF_ATCs,COUNT(*) AS NUM_OF_PATIENTS FROM
(
SELECT DISTINCT PATIENT_ID,birthdate,
COUNT(DISTINCT ATC_CODE) AS ATC_SUM
FROM PRESCRIPTIONS --INNER JOIN ATC4CODES ON ATC_CODE=CODE
WHERE (ATC_CODE IN (SELECT CODE FROM ATC4CODES) OR ATC_CODE LIKE 'G03C%' OR ATC_CODE LIKE 'N05A%' )
GROUP BY PATIENT_ID,birthdate
HAVING COUNT(DISTINCT ATC_CODE)=1
) B

UNION

SELECT '2' AS NUM_OF_ATCs,COUNT(*) AS NUM_OF_PATIENTS FROM
(
SELECT DISTINCT PATIENT_ID,birthdate, 
COUNT(DISTINCT ATC_CODE) AS ATC_SUM
FROM PRESCRIPTIONS --INNER JOIN ATC4CODES ON ATC_CODE=CODE
WHERE (ATC_CODE IN (SELECT CODE FROM ATC4CODES) OR ATC_CODE LIKE 'G03C%' OR ATC_CODE LIKE 'N05A%' )
GROUP BY PATIENT_ID,birthdate
HAVING COUNT(DISTINCT ATC_CODE)=2
) C

UNION

SELECT '3' AS NUM_OF_ATCs,COUNT(*) AS NUM_OF_PATIENTS FROM
(
SELECT DISTINCT PATIENT_ID,birthdate,
COUNT(DISTINCT ATC_CODE) AS ATC_SUM
FROM PRESCRIPTIONS --INNER JOIN ATC4CODES ON ATC_CODE=CODE
WHERE (ATC_CODE IN (SELECT CODE FROM ATC4CODES) OR ATC_CODE LIKE 'G03C%' OR ATC_CODE LIKE 'N05A%' )
GROUP BY PATIENT_ID,birthdate
HAVING COUNT(DISTINCT ATC_CODE)=3
) D

UNION

SELECT '4' AS NUM_OF_ATCs,COUNT(*) AS NUM_OF_PATIENTS FROM
(
SELECT DISTINCT PATIENT_ID,birthdate,
COUNT(DISTINCT ATC_CODE) AS ATC_SUM
FROM PRESCRIPTIONS 
WHERE (ATC_CODE IN (SELECT CODE FROM ATC4CODES) OR ATC_CODE LIKE 'G03C%' OR ATC_CODE LIKE 'N05A%' )
GROUP BY PATIENT_ID,birthdate--,ATC_EXISTS
HAVING COUNT(DISTINCT ATC_CODE)=4
) E

UNION

SELECT '>4' AS NUM_OF_ATCs,COUNT(*) AS NUM_OF_PATIENTS FROM
(
SELECT DISTINCT PATIENT_ID,birthdate,
COUNT(DISTINCT ATC_CODE) AS ATC_SUM
FROM PRESCRIPTIONS 
WHERE (ATC_CODE IN (SELECT CODE FROM ATC4CODES) OR ATC_CODE LIKE 'G03C%' OR ATC_CODE LIKE 'N05A%' )
GROUP BY PATIENT_ID,birthdate
HAVING COUNT(DISTINCT ATC_CODE)>4
) F

-------------------------------------------------------------------------------------------------------------


-------------------------GET NUMBER OF PATIENTS PER ATC AND AGE-------------------------------------------------------
SELECT ATC_CODE, COUNT(DISTINCT PATIENT_ID) AS NUMOFPATIENTS
FROM PRESCRIPTIONS
WHERE (ATC_CODE IN (SELECT CODE FROM ATC4CODES) OR ATC_CODE LIKE 'G03C%' OR ATC_CODE LIKE 'N05A%')
GROUP BY ATC_CODE
ORDER BY ATC_CODE

DECLARE @AGE NVARCHAR(20)
SET @AGE='100+'

SELECT ATC_CODE,BIRTHDATE, COUNT(DISTINCT PATIENT_ID) AS NUMOFPATIENTS
FROM PRESCRIPTIONS
WHERE (ATC_CODE IN (SELECT CODE FROM ATC4CODES) OR ATC_CODE LIKE 'G03C%' OR ATC_CODE LIKE 'N05A%')
AND BIRTHDATE=@AGE
GROUP BY ATC_CODE,BIRTHDATE
ORDER BY ATC_CODE
--------------------------------------------------------------------------------------------------------------



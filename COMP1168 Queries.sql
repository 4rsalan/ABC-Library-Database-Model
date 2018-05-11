USE projschema;

-- Query 1
SELECT * FROM projschema.title WHERE edition = 2;
-- */

-- Query 2
SELECT 	CONCAT(P.Patron_First_Name," ", P.Patron_Last_Name) AS Patron_Name , M.Membership_Name
FROM Patron P NATURAL JOIN Memberships M;
-- */

-- Query 3
SELECT * FROM projschema.publisher p, projschema.title t, projschema.book b, projschema.borrow_book bb
WHERE p.Publisher_ID_PK = t.Publisher_ID_FK
AND t.Title_ID_PK = b.Title_FK
AND b.Book_Barcode_ID_PK = bb.Book_Barcode_ID_FK;
-- */

-- Query 4
SELECT count(*) FROM borrow_dvd
where (
return_date>due_date
);
-- */

-- Query 5
SELECT * FROM title ORDER BY Publisher_ID_FK;
-- */

-- Query 6
SELECT Borrow_DVD_ID_PK, Patron_ID_FK, DVD_Barcode_ID_FK, Borrow_Date
FROM borrow_dvd
WHERE (datediff(Return_Date,Borrow_Date))>4
GROUP BY Patron_ID_FK
HAVING Borrow_date > "2018-02-05"
ORDER BY Borrow_DVD_ID_PK;
-- */

-- Query 7
CREATE VIEW Authors_and_Titles AS SELECT 
t.TitleName, ac.Title_ID_FK, ac.Author_ID_FK, a.Author_First_Name, a.Author_Last_Name
FROM projschema.title t, projschema.author a, projschema.author_creates ac
WHERE t.Title_ID_PK = ac.Title_ID_FK
AND ac.Author_ID_FK = a.authorID_PK;
-- */ 

-- Query 8
SELECT Patron_ID_FK, Borrow_Book_ID_PK, Late_Fees
FROM Borrow_Book B LEFT OUTER Join Patron P
ON B.Patron_ID_FK = P.Library_Card_ID_PK
ORDER BY Patron_ID_FK;
-- */

-- Query 9
SELECT Patron_First_Name, Patron_Last_Name FROM patron 
WHERE Library_Card_ID_PK IN
(SELECT Patron_ID_FK FROM borrow_book
	WHERE Late_Fees > 0);
-- */

-- Query 10
SELECT DISTINCT B1.Patron_ID_FK, B1.Borrow_CD_ID_PK, B1.CD_Barcode_ID_FK
FROM Borrow_CD B1 JOIN Borrow_CD B2
ON B1.Patron_ID_FK = B2.Patron_ID_FK AND
B1.Borrow_CD_ID_PK = B2.Borrow_CD_ID_PK AND
B1.CD_Barcode_ID_FK = B2.CD_Barcode_ID_FK
ORDER BY  B1.Patron_ID_FK
-- */

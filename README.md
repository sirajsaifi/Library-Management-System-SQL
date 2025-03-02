# **Library Management System**

![](https://github.com/sirajsaifi/Library-Management-System-SQL/blob/main/library.jpg)

---

## **Project Overview**

This project demonstrates the implementation of a Library Management System using SQL. It includes creating and managing tables, performing CRUD operations, and executing advanced SQL queries. The goal is to showcase skills in database design, manipulation, and querying.

An ERD diagram is included to visually represent the database schema and relationships between tables.

---

## **Entity Relationship Diagram (ERD)**
![](https://github.com/sirajsaifi/Library-Management-System-SQL/blob/main/libraryMSysERD.png)


## **Objective**

1. Set up the Library Management System Database: Create and populate the database with tables for branches, employees, members, books, issued status, and return status.
2. CRUD Operations: Perform Create, Read, Update, and Delete operations on the data.
3. CTAS (Create Table As Select): Utilize CTAS to create new tables based on query results.
4. Advanced SQL Queries: Develop complex queries to analyze and retrieve specific data.
  

## **Identifying Business Problems**

1. Create a New Book Record
"978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"

2. Update an Existing Member's Address

3. Delete a Record from the Issued Status Table
Objective: Delete the record with issued_id = 'IS104' from the issued_status table.

4. Retrieve All Books Issued by a Specific Employee
Objective: Select all books issued by the employee with emp_id = 'E101'.

5. List Members Who Have Issued More Than One Book
Objective: Use GROUP BY to find members who have issued more than one book.

6. Create Summary Tables: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt

7. Retrieve All Books in a Specific Category

8. Find Total Rental Income by Category

9. List Members Who Registered in the Last 180 Days

10. List Employees with Their Branch Manager's Name and their branch details

11. Create a Table of Books with Rental Price Above a Certain Threshold

12. Retrieve the List of Books Not Yet Returned

13. Identify Members with Overdue Books
Write a query to identify members who have overdue books (assume a 30-day return period). Display the member's name, book title, issue date, and days overdue.

14. Update Book Status on Return
Write a query to update the status of books in the books table to "available" when they are returned (based on entries in the return_status table).

15. Branch Performance Report
Create a query that generates a performance report for each branch, showing the number of books issued, the number of books returned, and the total revenue generated from book rentals.

16. Create a Table of Active Members
Use the CREATE TABLE AS (CTAS) statement to create a new table active_members containing members who have issued at least one book in the last 6 months.

17. Find Employees with the Most Book Issues Processed
Write a query to find the top 3 employees who have processed the most book issues. Display the employee name, number of books processed, and their branch.

18. Stored Procedure Objective: 
Create a stored procedure to manage the status of books in a library system. 
Description: Write a stored procedure that updates the status of a book in the library based on its issuance. 
The procedure should function as follows: 
The stored procedure should take the book_id as an input parameter. 
The procedure should first check if the book is available (status = 'yes'). 
If the book is available, it should be issued, and the status in the books table should be updated to 'no'. 
If the book is not available (status = 'no'), the procedure should return an error message indicating that the book is currently not available.
*/


## Reports

- **Database Schema**: Detailed table structures and relationships.
- **Data Analysis**: Insights into book categories, employee salaries, member registration trends, and issued books.
- **Summary Reports**: Aggregated data on high-demand books and employee performance.


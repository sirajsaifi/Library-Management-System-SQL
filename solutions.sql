-- Task 1. create a New Book Record 
-- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"

insert 
into 
	books(isbn, book_title, category, rental_price, status, author, publisher)
values
	('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');


-- Task 2: update an Existing Member's Address

update
	members
set
	member_address = '125 Main St'
where
	member_id = 'C101';


-- Task 3: Delete a Record from the issued Status table 
-- Objective: Delete the record with issued_id = 'is121' from the issued_status table.

delete 
from 
	issued_status
where
	issued_id = 'is121';


-- Task 4: Retrieve All Books issued by a Specific Employee 
-- Objective: select all books issued by the employee with emp_id = 'E101'.

select * 
from 
	issued_status
where 
	issued_emp_id = 'E101';


-- Task 5: List Members Who Have issued More Than one Book -- Objective: Use group by to find members who have issued more than one book.

select 
    ist.issued_emp_id,
     e.emp_name
from 
	issued_status as ist
join
	employees as e
on 
	e.emp_id = ist.issued_emp_id
group by 1, 2
having count(ist.issued_id) > 1;


-- CTas
-- Task 6: create Summary tables: Used CTas to generate new tables based on query results - each book and total book_issued_cnt**

create table 
	book_cnts
as    
	select 
		b.isbn,
		b.book_title,
		count(ist.issued_id) as no_issued
	from 
		books as b
	join
		issued_status as ist on ist.issued_book_isbn = b.isbn
	group by 1, 2;


-- Task 7. Retrieve All Books in a Specific Category:

select * 
from 
	books
where 
	category = 'Classic';

    
-- Task 8: Find Total Rental income by Category:

select
    b.category,
    sum(b.rental_price),
    count(*)
from 
	books as b
join
	issued_status as ist on ist.issued_book_isbn = b.isbn
group by 1;


-- Task 9: List Members Who Registered in the Last 180 Days:

select * 
from
	members
where 
	reg_date >= CURRENT_DATE - inTERVAL 180 day;


-- task 10: List Employees with Their Branch Manager's Name and their branch details:

select 
    e1.*,
    b.manager_id,
    e2.emp_name as manager
from 
	employees as e1
join 
	branch as b on b.branch_id = e1.branch_id
join
	employees as e2 on b.manager_id = e2.emp_id;


-- Task 11. create a table of Books with Rental Price Above a Certain Threshold 7USD:

create table 
	books_price_greater_than_seven
as    
	select * 
	from 
		Books
	where 
		rental_price > 7;


-- Task 12: Retrieve the List of Books Not Yet Returned

select 
    distinct ist.issued_book_name
from 
	issued_status as ist
left join
	return_status as rs on ist.issued_id = rs.issued_id
where 
	rs.return_id is null;


/*
Task 13: 
Identify Members with Overdue Books
Write a query to identify members who have overdue books (assume a 30-day return period). 
Display the member's_id, member's name, book title, issue date, and days overdue.
*/

select 
    ist.issued_member_id,
    m.member_name,
    bk.book_title,
    ist.issued_date,
    current_date - ist.issued_date as over_dues_days
from 
	issued_status as ist
join
	members as m on m.member_id = ist.issued_member_id
join
	books as bk on bk.isbn = ist.issued_book_isbn
left join
	return_status as rs on rs.issued_id = ist.issued_id
where 
    rs.return_date is null
and
    (current_date - ist.issued_date) > 30
order by 1;


/*    
Task 14: update Book Status on Return
Write a query to update the status of books in the books table to "Yes" when they are returned (based on entries in the return_status table).
*/

DELIMITER $$

create procedure add_return_records (
    in p_return_id varchar(10), 
    in p_issued_id varchar(10), 
    in p_book_quality varchar(10)
)

begin
    declare v_isbn varchar(50);
    declare v_book_name varchar(80);

    insert into 
		return_status (return_id, issued_id, return_date, book_quality)
    values 
		(p_return_id, p_issued_id, CURDATE(), p_book_quality);

    select 
		issued_book_isbn, issued_book_name
    into 
		v_isbn, v_book_name
    from 
		issued_status
   where 
		issued_id = p_issued_id;

    
    update books
    set status = 'yes'
   where isbn = v_isbn;

    -- Display a message
    select concat('Thank you for returning the book: ', v_book_name) as message;
end $$

DELIMITER ;

-- Testing FUNCTIon add_return_records
select * from books
where isbn = '978-0-307-58837-1';

select * from issued_status
where issued_book_isbn = '978-0-307-58837-1';

select * from return_status
where issued_id = 'is135';

-- calling function 
CALL add_return_records('RS138', 'is135', 'Good');
-- calling function 
CALL add_return_records('RS148', 'is140', 'Good');


/*
Task 15: Branch Performance Report
Create a query that generates a performance report for each branch, showing the number of books issued, the number of books returned, and the total revenue generated from book rentals.
*/

create table branch_reports
as
	select 
		b.branch_id,
		b.manager_id,
		count(ist.issued_id) as number_book_issued,
		count(rs.return_id) as number_of_book_return,
		sum(bk.rental_price) as total_revenue
	from 
		issued_status as ist
	join
		employees as e on e.emp_id = ist.issued_emp_id
	join
		branch as b on e.branch_id = b.branch_id
	left join
		return_status as rs on rs.issued_id = ist.issued_id
	join
		books as bk on ist.issued_book_isbn = bk.isbn
	group by 1, 2;

select * from branch_reports;


-- Task 16: CTas: Create a Table of Active Members
-- Use the CREATE TABLE as (CTas) statement to create a new table active_members containing members who have issued at least one book in the last 2 months.

create table active_members
as
	select * 
	from 
        members
	where
		member_id in 
			(select 
				distinct issued_member_id   
			from 
				issued_status
			where 
				issued_date >= CURRENT_DATE - interval 2 month
			)
;
select * from active_members;


-- Task 17: Find Employees with the Most Book issues Processed
-- Write a query to find the top 3 employees who have processed the most book issues. Display the employee name, number of books processed, and their branch.

select 
    e.emp_name,
    b.*,
    count(ist.issued_id) as no_book_issued
from 
	issued_status as ist
join
	employees as e on e.emp_id = ist.issued_emp_id
join
	branch as b on e.branch_id = b.branch_id
group by 1, 2;


/*
Task 18: Stored Procedure Objective: 
Create a stored procedure to manage the status of books in a library system. 
Description: Write a stored procedure that updates the status of a book in the library based on its issuance. 
The procedure should function as follows: 
The stored procedure should take the book_id as an input parameter. 
The procedure should first check if the book is available (status = 'yes'). 
If the book is available, it should be issued, and the status in the books table should be updated to 'no'. 
If the book is not available (status = 'no'), the procedure should return an error message indicating that the book is currently not available.
*/

DELIMITER $$

create procedure issue_book(
    in p_issued_id varchar(10), 
    in p_issued_member_id varchar(30), 
    in p_issued_book_isbn varchar(30), 
    in p_issued_emp_id varchar(10)
)

begin
    declare v_status varchar(10);

    select status into v_status
    from 
		books
    where 
		isbn = p_issued_book_isbn;

    if v_status = 'yes' then
        insert into 
			issued_status (issued_id, issued_member_id, issued_date, issued_book_isbn, issued_emp_id)
        values 
			(p_issued_id, p_issued_member_id, CURDATE(), p_issued_book_isbn, p_issued_emp_id);

        update books
        set status = 'no'
        where isbn = p_issued_book_isbn;

        select CONCAT('Book records added successfully for book ISBN: ', p_issued_book_isbn) AS message;

    else
        select CONCAT('Sorry, the book you requested is unavailable. ISBN: ', p_issued_book_isbn) AS message;
    end if;

end $$

DELIMITER ;



select * from books;
select * from issued_status;


CALL issue_book('is155', 'C108', '978-0-553-29698-2', 'E104');



CALL issue_book('is156', 'C108', '978-0-375-41398-8', 'E104');


select * from books
where isbn = '978-0-375-41398-8'
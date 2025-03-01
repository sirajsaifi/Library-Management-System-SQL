insert into
	issued_status(issued_id, issued_member_id, issued_book_name, issued_date, issued_book_isbn, issued_emp_id)
values
	('IS151', 'C118', 'The Catcher in the Rye', CURRENT_DATE - INTERVAL 24 day,  '978-0-553-29698-2', 'E108'),
	('IS152', 'C119', 'The Catcher in the Rye', CURRENT_DATE - INTERVAL 13 day,  '978-0-553-29698-2', 'E109'),
	('IS153', 'C106', 'Pride and Prejudice', CURRENT_DATE - INTERVAL 7 day,  '978-0-14-143951-8', 'E107'),
	('IS154', 'C105', 'The Road', CURRENT_DATE - INTERVAL 32 day,  '978-0-375-50167-0', 'E101');

alter table
	return_status
add column
	book_quality varchar(15) default('Good');

update
	return_status
set
	book_quality = 'Damaged'
where
	issued_id 
in
	('IS112', 'IS117', 'IS118');
create database libraryManagement;

use libraryManagement;

create table branch (
	branch_id varchar(10),
	manager_id varchar(10),
	branch_address varchar(30),
	contact_no varchar(15),
    primary key(branch_id)
);


create table employees (
	emp_id varchar(10),
	emp_name varchar(30),
	position varchar(30),
	salary decimal(10,2),
	branch_id varchar(10),
	primary key (emp_id),
	foreign key (branch_id) references branch(branch_id)
);

create table members (
	member_id varchar(10),
	member_name varchar(30),
	member_address varchar(30),
	reg_date date,
	primary key (member_id)
);


create table books (
	isbn varchar(50),
	book_title varchar(80),
	category varchar(30),
	rental_price decimal(10,2),
	status varchar(10),
	author varchar(30),
	publisher varchar(30),
	primary key (isbn)
);


create table issued_status (
	issued_id varchar(10),
	issued_member_id varchar(30),
	issued_book_name varchar(80),
	issued_date date,
	issued_book_isbn varchar(50),
	issued_emp_id varchar(10),
	primary key (issued_id),
	foreign key (issued_member_id) references members(member_id),
	foreign key (issued_emp_id) references employees(emp_id),
	foreign key (issued_book_isbn) references books(isbn) 
);


create table return_status (
	return_id varchar(10),
	issued_id varchar(30),
	return_book_name varchar(80),
	return_date date,
	return_book_isbn varchar(50),
	primary key (return_id),
	foreign key (return_book_isbn) references books(isbn)
);
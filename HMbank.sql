--Creating table for Customers

Create table Customers(
customers_id int not null primary key,
First_name varchar (20) not null ,
last_name varchar (10) not null ,
DOB date not null,
email varchar(20) not null,
phone_number bigint not null,
address varchar (20) not null)

--Creating table for Accounts

CREATE TABLE Accounts (
    account_id INT PRIMARY KEY,
	customer_id int,
    account_type VARCHAR(50),
    balance DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customers_id)
)
--Creating table for transactions

CREATE TABLE transactions(
transaction_id int not null Primary Key, 
account_id int not null,
Foreign Key (account_id) REFERENCES Accounts(account_id),
transaction_type varchar(20),
amount decimal(10,2),
transaction_date date)

insert into Customers values (1,'Chris','Smalling','2003-02-12','chris@gmail.com',9443021233,'Chennai'),
                             (2,'Lexi','Sweetlin','2001-03-11','sweety@gmail.com',9435421233,'Delhi'),
							 (3,'Will','Smith','2000-08-13','will@gmail.com',489398929,'Chennai'),
							 (4,'priya','Mohan','2004-12-3','priyamohan@gmail.com',347768839,'Hyderabad'),
							 (5,'Dany','joseph','2005-05-10','dany@gmail.com',9976848939,'Kerala'),
							 (6,'selvam','Mani','2002-03-06','selva@gmail.com',684893922,'Chennai'),
							 (7,'Jeff','Hardy','2007-03-15','hardy21@gmail.com',8783622991,'Kolkata'),
							 (8,'arun','john','2005-08-08','arunraj@gmail.com',2193793929,'Bangalore'),
							 (9,'sam','joel','2003-02-21','samjoel@gmail.com',7638392992,'Chennai'),
							 (10,'harish','kalyan','2000-04-22','harish@gmail.com',90329329,'Delhi')


insert into Accounts values(101,1,'savings', 5000.00),
(102,2,'current',10000.00),
(103,3,'savings',17500.00),
(104,4,'zero_balance',17500.50),
(105,5,'current',14000.00),
(106,6,'savings',180000.00),
(107,7,'savings',15000.00),
(108,8,'current',80000.00),
(109,9,'zero_balance',45000.00),
(110,10,'current',25000.00)


insert into transactions values(1,101,'Deposit',1000.00,'2024-04-01') ,
                               (2,102,'Deposit',5000.00,'2024-04-02'),
                               (3,103,'Withdraw',3000.00,'2024-04-05'),
                               (4,104,'Withdraw',3000.00,'2024-04-04'),
                               (5,105,'Deposit',7000.00,'2024-04-05'), 
                               (6,106,'Transfer',4000.00,'2024-04-06'),
                               (7,107,'Withdraw',10000.00,'2024-04-07'),
							   (8,108,'Deposit',9000.00,'2024-04-08'),
                               (9,109,'Transfer',1000.00,'2024-04-09'),
                               (10,110,'Transfer',2000.00,'2024-04-10')
						
select * from Customers
select * from Accounts
select * from transactions

--TASK 1

--1. Write a SQL query to retrieve the name, account type and email of all customers.

select concat(Customers.First_name,' ',Customers.last_name) as name , Accounts.account_type, Customers.email from Customers, Accounts 
where Customers.customers_id=Accounts.customer_id


--2. Write a SQL query to list all transaction corresponding customer.

select Customers.First_name, transactions.transaction_id,transaction_date,transactions.transaction_type from Customers,Transactions,Accounts where Customers.customers_id=Accounts.customer_id AND accounts.account_id=transactions.account_id

--3. Write a SQL query to increase the balance of a specific account by a certain amount. 

UPDATE Accounts
set balance = balance + 3000.00
where account_id = 104

select * from Accounts

--4. Write a SQL query to Combine first and last names of customers as a full_name.

select concat(Customers.First_name,' ',Customers.last_name) as name from Customers

--5. Write a SQL query to remove accounts with a balance of zero where the account type is savings. 

delete from Accounts where balance = 0 AND account_type = 'savings'

--6. Write a SQL query to Find customers living in a specific city

select * from customers where address='Chennai'

--7. Write a SQL query to Get the account balance for a specific account. 

select balance from Accounts where account_type='savings'

--8. Write a SQL query to List all current accounts with a balance greater than $1,000. 

select * from Accounts where balance > 1000

--9. Write a SQL query to Retrieve all transactions for a specific account.

select * from transactions where account_id=101

--10. Write a SQL query to Calculate the interest accrued on savings accounts based on a  given interest rate. 

select account_id,balance * (1 / 100) as interest from Accounts where 
    account_type = 'savings';


--11. Write a SQL query to Identify accounts where the balance is less than a specified overdraft limit. 

select * from Accounts where balance < 20000.00;

--12. Write a SQL query to Find customers not living in a specific city. 

select * from Customers where address <> 'chennai'

--Tasks 3: Aggregate functions, Having, Order By, GroupBy and Joins: 

--1. Write a SQL query to Find the average account balance for all customers.   

select AVG(balance) from Accounts

--2. Write a SQL query to Retrieve the top 10 highest account balances.  

SELECT top 10 customer_id, balance
FROM Accounts
ORDER BY balance DESC

--3. Write a SQL query to Calculate Total Deposits for All Customers in specific date. 

SELECT amount as total from transactions
where transaction_type='deposit'
AND transaction_date='2024-04-02'

--4. Write a SQL query to Find the Oldest and Newest Customers. 

select top 1 * from Customers 
order by DOB desc 

select MIN(DOB) AS old_customers,
       MAX(DOB) AS new_customers
From Customers

--5. Write a SQL query to Retrieve transaction details along with the account type. 

select  t.transaction_id,t.transaction_type,t.transaction_date,t.amount,a.account_type 
from Accounts  as a
join transactions as t
on a.account_id=t.account_id


--6. Write a SQL query to Get a list of customers along with their account details. 

SELECT c.customers_id,c.First_name,c.last_name,c.DOB,c.email,c.phone_number,c.address,a.account_id,a.account_type,a.balance FROM 
Customers c JOIN  Accounts a ON c.customers_id = a.customer_id;

--7. Write a SQL query to Retrieve transaction details along with customer information for a specific account. 

select  c.customers_id,c.First_name,c.last_name,c.DOB,c.email,c.phone_number,c.address,t.transaction_id,t.transaction_type,t.amount,t.transaction_date
from Customers c join Accounts a
on c.customers_id=a.customer_id
join transactions t 
on a.account_id=t.account_id
where a.account_id=101

--8. Write a SQL query to Identify customers who have more than one account. 

SELECT c.customers_id,c.First_name from Customers as c
join Accounts a
on c.customers_id=a.customer_id
group by c.customers_id,c.First_name
having COUNT(a.account_id )>1 



--10. Write a SQL query to Calculate the average daily balance for each account over a specified 
--period. 

SELECT 
    account_id,
    AVG(balance) AS average_daily_balance
FROM 
    (
        SELECT 
            a.account_id,
            transaction_date,
            SUM(balance) AS balance
        FROM 
            Transactions t join Accounts a on a.account_id=t.account_id
        GROUP BY 
            a.account_id, t.transaction_date
    ) AS daily_balances
GROUP BY 
    account_id;


--11. Calculate the total balance for each account type. 

select account_type,sum(balance) from Accounts group by account_type

--12. Identify accounts with the highest number of transactions order by descending order. 

select a.account_id,COUNT(t.transaction_id) as transactions_num
from Accounts a join transactions t on a.account_id = t.account_id
group by
a.account_id
order by 
transactions_num desc;


--13. List customers with high aggregate account balances, along with their account types. 



select c.customers_id,sum(a.balance),a.account_type from
Customers c join Accounts a on a.customer_id=c.customers_id
group by c.customers_id,a.balance,a.account_type
order by a.balance desc


                      

--Task 4

--1. Retrieve the customer(s) with the highest account balance. 

select c.customers_id,c.First_name,a.balance  from Customers c
join accounts a
on c.customers_id=a.customer_id
where a.balance in (select top 1 balance from Accounts 
order by balance desc)

--2. Calculate the average account balance for customers who have more than one account. 

SELECT AVG(avg_balance) AS average_balance
FROM (
    SELECT customer_id, AVG(balance) AS avg_balance
    FROM Accounts
    GROUP BY customer_id
    HAVING COUNT(*) > 1
) AS multi_account_customers


--3. Retrieve accounts with transactions whose amounts exceed the average transaction amount. 

SELECT account_id,transaction_id,transaction_type,amount
FROM Transactions WHERE 
amount > (SELECT AVG(amount) FROM Transactions)
    

--4. Identify customers who have no recorded transactions. 

SELECT c.customers_id, c.first_name, c.last_name
FROM Customers c
LEFT JOIN Accounts a ON c.customers_id = a.customer_id
WHERE a.account_id IS NULL;



--5. Calculate the total balance of accounts with no recorded transactions. 

SELECT SUM(balance) AS total_balance_no_transactions
FROM Accounts
WHERE account_id NOT IN (SELECT account_id FROM Transactions);



--6. Retrieve transactions for accounts with the lowest balance. 


select t.transaction_id,t.account_id,t.transaction_type,t.amount,t.transaction_date
from transactions t JOIN
Accounts a ON a.account_id = t.account_id 
where a.balance = (select MIN(balance) from Accounts);


--7. Identify customers who have accounts of multiple types. 

SELECT 
    c.customers_id,
    c.first_name,
    c.last_name
FROM 
    Customers c
JOIN 
    Accounts a ON c.customers_id = a.customer_id
GROUP BY 
    c.customers_id, c.first_name, c.last_name
HAVING 
    COUNT(DISTINCT a.account_type) > 1;


--8. Calculate the percentage of each account type out of the total number of accounts. 

select 
    account_type,
    count(account_type) as num_accounts,
    (count(account_type) * 100.0 / (select count(*) from Accounts)) AS percentage
from 
    Accounts
group by 
    account_type;


--9. Retrieve all transactions for a customer with a given customer_id. 

select * from Transactions where 
account_id in (select account_id from Accounts where customer_id = 102)

--10. Calculate the total balance for each account type, including a subquery within the SELECT 

select account_type,sum(balance) from Accounts 
group by account_type

SELECT 
    account_type,
    (SELECT SUM(balance) FROM Accounts a WHERE a.account_type = ac.account_type) AS total_balance
FROM 
    (SELECT DISTINCT account_type FROM Accounts) AS ac;

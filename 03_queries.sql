-- A. Basic SELECT and WHERE

-- List all customers from Pune.
-- Show all accounts with a balance greater than 100,000.
-- Find all transactions of type WITHDRAW with amount above 2,000.
-- List all loans that are still PENDING.

#1)
select * from customers
where city="Pune";

#2)
select * from accounts
where balance>100000;

#3)
select * from transactions
where txn_type="WITHDRAW" and amount>2000;

#4)
select * from loans
where status="Pending";




-- B. JOINs
-- 5. Show each account with the customer's first name and last name.
-- 6. Show each transaction with the customer's name (you will need to join 3 tables).
-- 7. List all employees along with their branch name and city.
-- 8. Find customers who have never taken a loan (use a LEFT JOIN).

#5)
select c.first_name,c.last_name,a.* 
from customers as c join accounts as a on c.customer_id=a.customer_id;

#6)
select c.first_name,c.last_name,t.*
from customers as c join accounts as a on c.customer_id=a.customer_id
join transactions as t on a.account_id=t.account_id;

#7)
select e.*,b.branch_name,b.city
from employees as e left join branches as b on e.branch_id=b.branch_id;

#8)
select c.customer_id,c.first_name,c.last_name from customers as c
left join loans as l on c.customer_id=l.customer_id
where l.loan_id is null;



-- C. GROUP BY and HAVING
-- 9. Find the total balance held at each branch.
-- 10. Count how many accounts each customer has.
-- 11. Find customers who have more than 1 account.
-- 12. Find the total transaction amount, grouped by transaction type.

#9)
select b.branch_id,b.branch_name,sum(a.balance) as Total_Balance
from branches as b join accounts as a on b.branch_id=a.branch_id
group by b.branch_id,b.branch_name;

#10)
select c.customer_id,c.first_name,count(a.account_id) as Total_Acc
from customers as c join accounts as a on c.customer_id=a.customer_id
group by c.customer_id,c.first_name
having Total_Acc>1;

#11)
select c.customer_id,c.first_name,count(a.account_id) as Total_Acc
from customers as c join accounts as a on c.customer_id=a.customer_id
group by c.customer_id,c.first_name;

#12)
select txn_type as Transaction_Type,sum(amount) as Total_amount
from transactions
group by txn_type;


-- D. Subqueries
-- 13. Find customers whose account balance is above the average balance of all accounts.
-- 14. Find the branch with the highest total loan amount (use a subquery).
-- 15. List accounts that have never had a single transaction.

#13)
select c.customer_id,c.first_name,c.last_name,a.account_type,a.balance
from customers as c join accounts as a on c.customer_id=a.customer_id
where a.balance>(select avg(balance) from accounts);

#14)
select branch_id,sum(principal) from loans
group by branch_id
having sum(principal)=(select max(loan) as Total_loan from (select branch_id,sum(principal) as loan from loans
group by branch_id) as loan1);

#15)
select a.account_id,count(t.txn_id) as Total_Transactions from accounts as a left join transactions as t on a.account_id=t.account_id
group by a.account_id
having count(t.txn_id)<1;


-- E. CTEs (WITH clause)
-- 16. Write a CTE that calculates each branch's total deposits, then use it to find the top 3 branches.
-- 17. Write a CTE that finds each customer's total loan amount, then filter for customers with more than 500,000 total.

#16)
select * from loans;

with top as (

select b.branch_id,sum(t.amount) as Total 
from branches as b join accounts as a on b.branch_id=a.branch_id
join transactions as t on a.account_id=t.account_id
where t.txn_type="DEPOSIT"
group by b.branch_id )

select * from top
order by Total desc
limit 3;


#17)
with cust as (
select c.customer_id,sum(l.principal) as Total_loan from
customers as c join loans as l on c.customer_id=l.customer_id
group by c.customer_id)

select * from cust
where Total_loan>500000;



-- F. Window functions
-- 18. Rank customers by their account balance, from highest to lowest.
-- 19. For each account, show a running total of transactions ordered by date.
-- 20. Find each customer's most recent transaction using ROW_NUMBER().

select * from accounts;
select * from transactions;

#18)
with cust as (select c.customer_id,sum(a.balance) as Balance
from customers as c join accounts as a on c.customer_id=a.customer_id
group by c.customer_id )
select *,dense_rank() over (order by Balance desc) as Rank_
from cust;


#19)
 -- For each account, show a running total of transactions ordered by date.
with acc as (select a.account_id,t.txn_type,t.amount,sum(CASE 
    WHEN t.txn_type IN ('DEPOSIT','TRANSFER_IN')  THEN t.amount
    WHEN t.txn_type IN ('WITHDRAW','TRANSFER_OUT') THEN -t.amount
END) over (partition by t.account_id order by t.txn_date) as Running_Total
from accounts as a join transactions as t on a.account_id=t.account_id)
select * from acc;

#20)
-- Find each customer's most recent transaction using ROW_NUMBER().
with rec as (select row_number() over (partition by c.customer_id order by t.txn_date desc) as Row_n, c.customer_id,t.*
from customers as c join accounts as a on c.customer_id=a.customer_id 
join transactions as t on a.account_id=t.account_id)
select * from rec
where Row_n=1;



#creating views
-- customer_account_summary — one row per customer, showing their full name, city, 
-- how many accounts they have, and their total balance across all accounts.

-- monthly_deposit_report — total deposit amount per branch per month (columns: branch name, year, month, total deposits).

create view cust_details as (
select c.customer_id,c.first_name,c.last_name,c.city,count(a.account_id) as Total_acc,coalesce(sum(a.balance),0) as Total_Bal
from customers as c left join accounts as a on c.customer_id=a.customer_id
group by c.customer_id,c.first_name,c.last_name,c.city);

select * from cust_details;

create view monthly_rep as (select b.branch_name,year(t.txn_date) as Year_,month(t.txn_date) as Month_,sum(case 
when t.txn_type in ("DEPOSIT","TRANSFER_IN") then amount
end) as Total_dep from branches as b join accounts as a on b.branch_id=a.branch_id join transactions as t on a.account_id=t.account_id
group by b.branch_name,Year_,Month_);

select * from monthly_rep;

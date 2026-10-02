-- =====================================================
-- Bank Management System
-- File: 02_data.sql
-- Purpose: Insert a small, easy-to-read sample dataset
-- Row counts: 5 branches, 10 employees, 30 customers,
--             50 accounts, 150 transactions, 15 loans,
--             24 loan_payments (sample for a few loans)
-- =====================================================

USE bank_db;

-- -----------------------------------------------------
-- 1. BRANCHES (5)
-- -----------------------------------------------------
INSERT INTO branches (branch_name, city, ifsc_code) VALUES
('MG Road Branch',       'Pune',      'BANK0001001'),
('Andheri Branch',       'Mumbai',    'BANK0001002'),
('Connaught Place',      'Delhi',     'BANK0001003'),
('Koramangala Branch',   'Bangalore', 'BANK0001004'),
('Banjara Hills Branch', 'Hyderabad', 'BANK0001005');

-- -----------------------------------------------------
-- 2. EMPLOYEES (10)
-- -----------------------------------------------------
INSERT INTO employees (branch_id, full_name, role, hire_date) VALUES
(1, 'Amit Sharma',  'MANAGER',      '2021-03-15'),
(1, 'Neha Verma',   'TELLER',       '2022-06-01'),
(2, 'Rohan Gupta',  'TELLER',       '2020-11-20'),
(2, 'Priya Singh',  'LOAN_OFFICER', '2019-08-10'),
(3, 'Karan Mehta',  'MANAGER',      '2021-01-05'),
(3, 'Isha Patel',   'TELLER',       '2023-02-14'),
(4, 'Arjun Reddy',  'TELLER',       '2022-09-09'),
(4, 'Diya Nair',    'LOAN_OFFICER', '2020-05-22'),
(5, 'Vivaan Rao',   'MANAGER',      '2018-12-01'),
(5, 'Sara Joshi',   'TELLER',       '2023-07-19');

-- -----------------------------------------------------
-- 3. CUSTOMERS (30)
-- -----------------------------------------------------
INSERT INTO customers (first_name, last_name, phone, email, city, date_of_birth) VALUES
('Aarav',   'Sharma',   '9800000001', 'aarav.sharma1@example.com',   'Pune',      '1995-04-12'),
('Vivaan',  'Verma',    '9800000002', 'vivaan.verma2@example.com',   'Mumbai',    '1990-08-23'),
('Aditya',  'Gupta',    '9800000003', 'aditya.gupta3@example.com',   'Delhi',     '1998-01-30'),
('Vihaan',  'Singh',    '9800000004', 'vihaan.singh4@example.com',   'Bangalore', '1993-11-05'),
('Arjun',   'Kumar',    '9800000005', 'arjun.kumar5@example.com',    'Hyderabad', '1988-06-17'),
('Sai',     'Patel',    '9800000006', 'sai.patel6@example.com',      'Chennai',   '1996-09-09'),
('Reyansh', 'Mehta',    '9800000007', 'reyansh.mehta7@example.com',  'Kolkata',   '1991-03-03'),
('Ayaan',   'Shah',     '9800000008', 'ayaan.shah8@example.com',     'Ahmedabad', '1999-12-25'),
('Krishna', 'Joshi',    '9800000009', 'krishna.joshi9@example.com',  'Jaipur',    '1994-07-14'),
('Ishaan',  'Reddy',    '9800000010','ishaan.reddy10@example.com',   'Surat',     '1997-02-28'),
('Rohan',   'Iyer',     '9800000011','rohan.iyer11@example.com',     'Pune',      '1992-10-19'),
('Kabir',   'Nair',     '9800000012','kabir.nair12@example.com',     'Mumbai',    '1989-05-08'),
('Aryan',   'Rao',      '9800000013','aryan.rao13@example.com',      'Delhi',     '2000-01-11'),
('Dhruv',   'Chopra',   '9800000014','dhruv.chopra14@example.com',   'Bangalore', '1995-08-30'),
('Karan',   'Malhotra', '9800000015','karan.malhotra15@example.com', 'Hyderabad', '1993-04-21'),
('Ananya',  'Sharma',   '9800000016','ananya.sharma16@example.com',  'Chennai',   '1996-11-02'),
('Diya',    'Verma',    '9800000017','diya.verma17@example.com',     'Kolkata',   '1998-07-07'),
('Saanvi',  'Gupta',    '9800000018','saanvi.gupta18@example.com',   'Ahmedabad', '1991-09-15'),
('Aadhya',  'Singh',    '9800000019','aadhya.singh19@example.com',   'Jaipur',    '1994-03-24'),
('Kiara',   'Kumar',    '9800000020','kiara.kumar20@example.com',    'Surat',     '1997-12-06'),
('Myra',    'Patel',    '9800000021','myra.patel21@example.com',     'Pune',      '1990-06-13'),
('Sara',    'Mehta',    '9800000022','sara.mehta22@example.com',     'Mumbai',    '1999-01-27'),
('Anika',   'Shah',     '9800000023','anika.shah23@example.com',     'Delhi',     '1992-08-19'),
('Riya',    'Joshi',    '9800000024','riya.joshi24@example.com',     'Bangalore', '1995-05-05'),
('Isha',    'Reddy',    '9800000025','isha.reddy25@example.com',     'Hyderabad', '1988-10-30'),
('Priya',   'Iyer',     '9800000026','priya.iyer26@example.com',     'Chennai',   '2001-02-14'),
('Neha',    'Nair',     '9800000027','neha.nair27@example.com',      'Kolkata',   '1993-07-22'),
('Pooja',   'Rao',      '9800000028','pooja.rao28@example.com',      'Ahmedabad', '1996-04-09'),
('Rohan',   'Chopra',   '9800000029','rohan.chopra29@example.com',   'Jaipur',    '1990-11-16'),
('Kabir',   'Malhotra', '9800000030','kabir.malhotra30@example.com', 'Surat',     '1994-09-03');

-- -----------------------------------------------------
-- 4. ACCOUNTS (50) -- first 30 customers get 1 account each,
--    then customers 1-20 get a second account
-- -----------------------------------------------------
INSERT INTO accounts (customer_id, branch_id, account_type, balance, status, opened_date) VALUES
(1,  1, 'SAVINGS', 45230.50,  'ACTIVE', '2021-05-10'),
(2,  2, 'CURRENT', 128900.00, 'ACTIVE', '2020-03-22'),
(3,  3, 'SAVINGS', 5320.75,   'ACTIVE', '2022-01-18'),
(4,  4, 'SAVINGS', 76400.00,  'ACTIVE', '2019-07-09'),
(5,  5, 'CURRENT', 9999.99,   'ACTIVE', '2023-02-14'),
(6,  1, 'SAVINGS', 234500.00, 'ACTIVE', '2018-11-30'),
(7,  2, 'SAVINGS', 67000.00,  'ACTIVE', '2021-09-05'),
(8,  3, 'CURRENT', 15800.25,  'ACTIVE', '2020-06-17'),
(9,  4, 'SAVINGS', 382900.75, 'ACTIVE', '2022-04-23'),
(10, 5, 'SAVINGS', 2100.00,   'FROZEN', '2019-12-02'),
(11, 1, 'CURRENT', 55600.50,  'ACTIVE', '2021-08-14'),
(12, 2, 'SAVINGS', 98700.00,  'ACTIVE', '2020-10-11'),
(13, 3, 'SAVINGS', 4300.25,   'ACTIVE', '2023-01-09'),
(14, 4, 'CURRENT', 161200.00, 'ACTIVE', '2018-05-27'),
(15, 5, 'SAVINGS', 8850.00,   'ACTIVE', '2022-07-19'),
(16, 1, 'SAVINGS', 47200.75,  'ACTIVE', '2021-02-25'),
(17, 2, 'CURRENT', 305600.00, 'ACTIVE', '2019-09-08'),
(18, 3, 'SAVINGS', 1200.50,   'CLOSED', '2020-04-16'),
(19, 4, 'SAVINGS', 73900.00,  'ACTIVE', '2022-11-03'),
(20, 5, 'CURRENT', 21500.25,  'ACTIVE', '2021-06-21'),
(21, 1, 'SAVINGS', 63000.00,  'ACTIVE', '2019-03-30'),
(22, 2, 'SAVINGS', 8100.75,   'ACTIVE', '2023-05-12'),
(23, 3, 'CURRENT', 149800.00, 'ACTIVE', '2020-08-24'),
(24, 4, 'SAVINGS', 27600.50,  'ACTIVE', '2022-02-07'),
(25, 5, 'SAVINGS', 5400.00,   'ACTIVE', '2021-10-15'),
(26, 1, 'CURRENT', 91200.25,  'ACTIVE', '2019-06-28'),
(27, 2, 'SAVINGS', 3300.00,   'ACTIVE', '2023-03-19'),
(28, 3, 'SAVINGS', 210500.00, 'ACTIVE', '2020-12-05'),
(29, 4, 'CURRENT', 46700.50,  'ACTIVE', '2022-09-22'),
(30, 5, 'SAVINGS', 12900.75,  'ACTIVE', '2021-04-11'),
(1,  2, 'CURRENT', 8700.00,   'ACTIVE', '2023-06-30'),
(2,  3, 'SAVINGS', 154000.25, 'ACTIVE', '2020-01-14'),
(3,  4, 'SAVINGS', 2900.50,   'ACTIVE', '2022-08-08'),
(4,  5, 'CURRENT', 67800.00,  'ACTIVE', '2019-11-26'),
(5,  1, 'SAVINGS', 19500.75,  'ACTIVE', '2021-07-02'),
(6,  2, 'SAVINGS', 88200.00,  'ACTIVE', '2020-05-19'),
(7,  3, 'CURRENT', 4600.25,   'FROZEN', '2023-04-03'),
(8,  4, 'SAVINGS', 132700.00, 'ACTIVE', '2019-02-16'),
(9,  5, 'SAVINGS', 7100.50,   'ACTIVE', '2022-10-29'),
(10, 1, 'CURRENT', 275300.00, 'ACTIVE', '2021-01-08'),
(11, 2, 'SAVINGS', 15600.75,  'ACTIVE', '2020-09-21'),
(12, 3, 'SAVINGS', 3900.00,   'ACTIVE', '2023-07-14'),
(13, 4, 'CURRENT', 59800.25,  'ACTIVE', '2019-04-27'),
(14, 5, 'SAVINGS', 118200.00, 'ACTIVE', '2022-01-10'),
(15, 1, 'SAVINGS', 6300.50,   'ACTIVE', '2021-11-23'),
(16, 2, 'CURRENT', 41500.00,  'ACTIVE', '2020-07-06'),
(17, 3, 'SAVINGS', 9200.75,   'ACTIVE', '2023-02-28'),
(18, 4, 'SAVINGS', 187600.00, 'ACTIVE', '2019-08-19'),
(19, 5, 'CURRENT', 2400.25,   'ACTIVE', '2022-05-02'),
(20, 1, 'SAVINGS', 71300.00,  'ACTIVE', '2021-03-15');

-- -----------------------------------------------------
-- 5. TRANSACTIONS (150) -- cycles through the 50 accounts
--    3 times, mixing the 4 transaction types
-- -----------------------------------------------------
INSERT INTO transactions (account_id, txn_type, amount, txn_date, description) VALUES
(1,'DEPOSIT',5000.00,'2024-01-05','Salary deposit'),(2,'WITHDRAW',1200.00,'2024-01-06','ATM withdrawal'),
(3,'DEPOSIT',3000.00,'2024-01-07','Cash deposit'),(4,'TRANSFER_OUT',7500.00,'2024-01-08','Rent payment'),
(5,'TRANSFER_IN',7500.00,'2024-01-08','Rent received'),(6,'WITHDRAW',2000.00,'2024-01-09','ATM withdrawal'),
(7,'DEPOSIT',15000.00,'2024-01-10','Salary deposit'),(8,'WITHDRAW',500.00,'2024-01-11','ATM withdrawal'),
(9,'DEPOSIT',4200.00,'2024-01-12','Cash deposit'),(10,'TRANSFER_OUT',1000.00,'2024-01-13','Bill payment'),
(11,'DEPOSIT',6000.00,'2024-01-14','Salary deposit'),(12,'WITHDRAW',3200.00,'2024-01-15','ATM withdrawal'),
(13,'DEPOSIT',1800.00,'2024-01-16','Cash deposit'),(14,'TRANSFER_IN',9000.00,'2024-01-17','Refund'),
(15,'WITHDRAW',700.00,'2024-01-18','ATM withdrawal'),(16,'DEPOSIT',12000.00,'2024-01-19','Salary deposit'),
(17,'TRANSFER_OUT',2500.00,'2024-01-20','Bill payment'),(18,'WITHDRAW',900.00,'2024-01-21','ATM withdrawal'),
(19,'DEPOSIT',5400.00,'2024-01-22','Cash deposit'),(20,'TRANSFER_IN',3000.00,'2024-01-23','Refund'),
(21,'DEPOSIT',7200.00,'2024-01-24','Salary deposit'),(22,'WITHDRAW',1500.00,'2024-01-25','ATM withdrawal'),
(23,'DEPOSIT',9800.00,'2024-01-26','Cash deposit'),(24,'TRANSFER_OUT',4000.00,'2024-01-27','Rent payment'),
(25,'WITHDRAW',600.00,'2024-01-28','ATM withdrawal'),(26,'DEPOSIT',11000.00,'2024-01-29','Salary deposit'),
(27,'TRANSFER_IN',2200.00,'2024-01-30','Refund'),(28,'WITHDRAW',1800.00,'2024-01-31','ATM withdrawal'),
(29,'DEPOSIT',3400.00,'2024-02-01','Cash deposit'),(30,'TRANSFER_OUT',6000.00,'2024-02-02','Bill payment'),
(31,'DEPOSIT',8800.00,'2024-02-03','Salary deposit'),(32,'WITHDRAW',2100.00,'2024-02-04','ATM withdrawal'),
(33,'DEPOSIT',1400.00,'2024-02-05','Cash deposit'),(34,'TRANSFER_IN',5500.00,'2024-02-06','Refund'),
(35,'WITHDRAW',900.00,'2024-02-07','ATM withdrawal'),(36,'DEPOSIT',13500.00,'2024-02-08','Salary deposit'),
(37,'TRANSFER_OUT',3300.00,'2024-02-09','Bill payment'),(38,'WITHDRAW',450.00,'2024-02-10','ATM withdrawal'),
(39,'DEPOSIT',6700.00,'2024-02-11','Cash deposit'),(40,'TRANSFER_IN',4100.00,'2024-02-12','Refund'),
(41,'DEPOSIT',9200.00,'2024-02-13','Salary deposit'),(42,'WITHDRAW',1700.00,'2024-02-14','ATM withdrawal'),
(43,'DEPOSIT',2900.00,'2024-02-15','Cash deposit'),(44,'TRANSFER_OUT',5000.00,'2024-02-16','Rent payment'),
(45,'WITHDRAW',800.00,'2024-02-17','ATM withdrawal'),(46,'DEPOSIT',10500.00,'2024-02-18','Salary deposit'),
(47,'TRANSFER_IN',2600.00,'2024-02-19','Refund'),(48,'WITHDRAW',1300.00,'2024-02-20','ATM withdrawal'),
(49,'DEPOSIT',4700.00,'2024-02-21','Cash deposit'),(50,'TRANSFER_OUT',7200.00,'2024-02-22','Bill payment'),
(1,'WITHDRAW',2200.00,'2024-02-23','ATM withdrawal'),(2,'DEPOSIT',6100.00,'2024-02-24','Cash deposit'),
(3,'TRANSFER_IN',3800.00,'2024-02-25','Refund'),(4,'WITHDRAW',950.00,'2024-02-26','ATM withdrawal'),
(5,'DEPOSIT',8300.00,'2024-02-27','Salary deposit'),(6,'TRANSFER_OUT',1600.00,'2024-02-28','Bill payment'),
(7,'WITHDRAW',700.00,'2024-03-01','ATM withdrawal'),(8,'DEPOSIT',12400.00,'2024-03-02','Salary deposit'),
(9,'TRANSFER_IN',2900.00,'2024-03-03','Refund'),(10,'WITHDRAW',1100.00,'2024-03-04','ATM withdrawal'),
(11,'DEPOSIT',5600.00,'2024-03-05','Cash deposit'),(12,'TRANSFER_OUT',3400.00,'2024-03-06','Bill payment'),
(13,'WITHDRAW',500.00,'2024-03-07','ATM withdrawal'),(14,'DEPOSIT',9900.00,'2024-03-08','Salary deposit'),
(15,'TRANSFER_IN',4300.00,'2024-03-09','Refund'),(16,'WITHDRAW',1900.00,'2024-03-10','ATM withdrawal'),
(17,'DEPOSIT',7500.00,'2024-03-11','Cash deposit'),(18,'TRANSFER_OUT',2100.00,'2024-03-12','Bill payment'),
(19,'WITHDRAW',650.00,'2024-03-13','ATM withdrawal'),(20,'DEPOSIT',11200.00,'2024-03-14','Salary deposit'),
(21,'TRANSFER_IN',3600.00,'2024-03-15','Refund'),(22,'WITHDRAW',1250.00,'2024-03-16','ATM withdrawal'),
(23,'DEPOSIT',6800.00,'2024-03-17','Cash deposit'),(24,'TRANSFER_OUT',4700.00,'2024-03-18','Rent payment'),
(25,'WITHDRAW',780.00,'2024-03-19','ATM withdrawal'),(26,'DEPOSIT',13900.00,'2024-03-20','Salary deposit'),
(27,'TRANSFER_IN',2400.00,'2024-03-21','Refund'),(28,'WITHDRAW',1050.00,'2024-03-22','ATM withdrawal'),
(29,'DEPOSIT',5200.00,'2024-03-23','Cash deposit'),(30,'TRANSFER_OUT',6300.00,'2024-03-24','Bill payment'),
(31,'WITHDRAW',890.00,'2024-03-25','ATM withdrawal'),(32,'DEPOSIT',10100.00,'2024-03-26','Salary deposit'),
(33,'TRANSFER_IN',3100.00,'2024-03-27','Refund'),(34,'WITHDRAW',1400.00,'2024-03-28','ATM withdrawal'),
(35,'DEPOSIT',7900.00,'2024-03-29','Cash deposit'),(36,'TRANSFER_OUT',2800.00,'2024-03-30','Bill payment'),
(37,'WITHDRAW',600.00,'2024-03-31','ATM withdrawal'),(38,'DEPOSIT',14200.00,'2024-04-01','Salary deposit'),
(39,'TRANSFER_IN',4600.00,'2024-04-02','Refund'),(40,'WITHDRAW',1750.00,'2024-04-03','ATM withdrawal'),
(41,'DEPOSIT',6500.00,'2024-04-04','Cash deposit'),(42,'TRANSFER_OUT',5100.00,'2024-04-05','Rent payment'),
(43,'WITHDRAW',900.00,'2024-04-06','ATM withdrawal'),(44,'DEPOSIT',9300.00,'2024-04-07','Salary deposit'),
(45,'TRANSFER_IN',2700.00,'2024-04-08','Refund'),(46,'WITHDRAW',1150.00,'2024-04-09','ATM withdrawal'),
(47,'DEPOSIT',5800.00,'2024-04-10','Cash deposit'),(48,'TRANSFER_OUT',3900.00,'2024-04-11','Bill payment'),
(49,'WITHDRAW',700.00,'2024-04-12','ATM withdrawal'),(50,'DEPOSIT',10800.00,'2024-04-13','Salary deposit'),
(1,'TRANSFER_IN',3300.00,'2024-04-14','Refund'),(2,'WITHDRAW',1600.00,'2024-04-15','ATM withdrawal'),
(3,'DEPOSIT',6900.00,'2024-04-16','Cash deposit'),(4,'TRANSFER_OUT',4400.00,'2024-04-17','Bill payment'),
(5,'WITHDRAW',850.00,'2024-04-18','ATM withdrawal'),(6,'DEPOSIT',12600.00,'2024-04-19','Salary deposit'),
(7,'TRANSFER_IN',2900.00,'2024-04-20','Refund'),(8,'WITHDRAW',1350.00,'2024-04-21','ATM withdrawal'),
(9,'DEPOSIT',5100.00,'2024-04-22','Cash deposit'),(10,'TRANSFER_OUT',5600.00,'2024-04-23','Rent payment'),
(11,'WITHDRAW',750.00,'2024-04-24','ATM withdrawal'),(12,'DEPOSIT',9700.00,'2024-04-25','Salary deposit'),
(13,'TRANSFER_IN',3400.00,'2024-04-26','Refund'),(14,'WITHDRAW',1450.00,'2024-04-27','ATM withdrawal'),
(15,'DEPOSIT',7300.00,'2024-04-28','Cash deposit'),(16,'TRANSFER_OUT',2600.00,'2024-04-29','Bill payment'),
(17,'WITHDRAW',600.00,'2024-04-30','ATM withdrawal'),(18,'DEPOSIT',11500.00,'2024-05-01','Salary deposit'),
(19,'TRANSFER_IN',3700.00,'2024-05-02','Refund'),(20,'WITHDRAW',1250.00,'2024-05-03','ATM withdrawal'),
(21,'DEPOSIT',6400.00,'2024-05-04','Cash deposit'),(22,'TRANSFER_OUT',4900.00,'2024-05-05','Bill payment'),
(23,'WITHDRAW',800.00,'2024-05-06','ATM withdrawal'),(24,'DEPOSIT',13100.00,'2024-05-07','Salary deposit'),
(25,'TRANSFER_IN',2500.00,'2024-05-08','Refund'),(26,'WITHDRAW',1050.00,'2024-05-09','ATM withdrawal'),
(27,'DEPOSIT',5900.00,'2024-05-10','Cash deposit'),(28,'TRANSFER_OUT',3700.00,'2024-05-11','Bill payment'),
(29,'WITHDRAW',690.00,'2024-05-12','ATM withdrawal'),(30,'DEPOSIT',10300.00,'2024-05-13','Salary deposit'),
(31,'TRANSFER_IN',3200.00,'2024-05-14','Refund'),(32,'WITHDRAW',1400.00,'2024-05-15','ATM withdrawal'),
(33,'DEPOSIT',7100.00,'2024-05-16','Cash deposit'),(34,'TRANSFER_OUT',2900.00,'2024-05-17','Bill payment'),
(35,'WITHDRAW',650.00,'2024-05-18','ATM withdrawal'),(36,'DEPOSIT',14700.00,'2024-05-19','Salary deposit'),
(37,'TRANSFER_IN',4200.00,'2024-05-20','Refund'),(38,'WITHDRAW',1800.00,'2024-05-21','ATM withdrawal'),
(39,'DEPOSIT',6200.00,'2024-05-22','Cash deposit'),(40,'TRANSFER_OUT',5300.00,'2024-05-23','Rent payment'),
(41,'WITHDRAW',920.00,'2024-05-24','ATM withdrawal'),(42,'DEPOSIT',9600.00,'2024-05-25','Salary deposit'),
(43,'TRANSFER_IN',2800.00,'2024-05-26','Refund'),(44,'WITHDRAW',1180.00,'2024-05-27','ATM withdrawal'),
(45,'DEPOSIT',5700.00,'2024-05-28','Cash deposit'),(46,'TRANSFER_OUT',4100.00,'2024-05-29','Bill payment'),
(47,'WITHDRAW',730.00,'2024-05-30','ATM withdrawal'),(48,'DEPOSIT',11800.00,'2024-05-31','Salary deposit'),
(49,'TRANSFER_IN',3500.00,'2024-06-01','Refund'),(50,'WITHDRAW',1620.00,'2024-06-02','ATM withdrawal');

-- -----------------------------------------------------
-- 6. LOANS (15)
-- -----------------------------------------------------
INSERT INTO loans (customer_id, branch_id, principal, interest_rate, tenure_months, status, start_date) VALUES
(1,  1, 500000.00, 9.50,  36, 'ACTIVE',   '2023-06-10'),
(2,  2, 200000.00, 10.00, 24, 'ACTIVE',   '2023-09-15'),
(3,  3, 800000.00, 8.75,  60, 'ACTIVE',   '2022-11-01'),
(4,  4, 150000.00, 11.00, 12, 'CLOSED',   '2022-01-20'),
(5,  5, 300000.00, 9.25,  36, 'ACTIVE',   '2023-03-05'),
(6,  1, 100000.00, 12.00, 12, 'CLOSED',   '2021-08-14'),
(7,  2, 950000.00, 8.50,  60, 'ACTIVE',   '2023-01-25'),
(8,  3, 250000.00, 10.50, 24, 'PENDING',  NULL),
(9,  4, 400000.00, 9.75,  36, 'ACTIVE',   '2022-07-30'),
(10, 5, 600000.00, 9.00,  48, 'ACTIVE',   '2023-04-18'),
(11, 1, 180000.00, 11.25, 12, 'REJECTED', NULL),
(12, 2, 700000.00, 8.90,  60, 'ACTIVE',   '2022-05-09'),
(13, 3, 220000.00, 10.75, 24, 'PENDING',  NULL),
(14, 4, 350000.00, 9.40,  36, 'CLOSED',   '2021-12-02'),
(15, 5, 900000.00, 8.60,  60, 'ACTIVE',   '2023-02-11');

-- -----------------------------------------------------
-- 7. LOAN_PAYMENTS -- 6 EMIs each for 4 loans (sample only,
--    not the full schedule for every loan)
-- -----------------------------------------------------
INSERT INTO loan_payments (loan_id, due_date, emi_amount, paid_date, status) VALUES
(1, '2023-07-10', 16000.00, '2023-07-09', 'PAID'),
(1, '2023-08-10', 16000.00, '2023-08-10', 'PAID'),
(1, '2023-09-10', 16000.00, '2023-09-12', 'LATE'),
(1, '2023-10-10', 16000.00, '2023-10-10', 'PAID'),
(1, '2023-11-10', 16000.00, '2023-11-09', 'PAID'),
(1, '2023-12-10', 16000.00, NULL,         'DUE'),
(2, '2023-10-15', 9200.00,  '2023-10-15', 'PAID'),
(2, '2023-11-15', 9200.00,  '2023-11-14', 'PAID'),
(2, '2023-12-15', 9200.00,  '2023-12-16', 'LATE'),
(2, '2024-01-15', 9200.00,  '2024-01-15', 'PAID'),
(2, '2024-02-15', 9200.00,  NULL,         'DUE'),
(2, '2024-03-15', 9200.00,  NULL,         'DUE'),
(3, '2022-12-01', 16400.00, '2022-11-30', 'PAID'),
(3, '2023-01-01', 16400.00, '2023-01-02', 'LATE'),
(3, '2023-02-01', 16400.00, '2023-02-01', 'PAID'),
(3, '2023-03-01', 16400.00, '2023-03-01', 'PAID'),
(3, '2023-04-01', 16400.00, '2023-03-30', 'PAID'),
(3, '2023-05-01', 16400.00, NULL,         'DUE'),
(4, '2022-02-20', 13800.00, '2022-02-19', 'PAID'),
(4, '2022-03-20', 13800.00, '2022-03-20', 'PAID'),
(4, '2022-04-20', 13800.00, '2022-04-22', 'LATE'),
(4, '2022-05-20', 13800.00, '2022-05-20', 'PAID'),
(4, '2022-06-20', 13800.00, '2022-06-19', 'PAID'),
(4, '2022-07-20', 13800.00, '2022-07-20', 'PAID');

-- -----------------------------------------------------
-- Verify row counts
-- -----------------------------------------------------
SELECT 'branches' AS table_name, COUNT(*) AS row_count FROM branches
UNION ALL SELECT 'employees', COUNT(*) FROM employees
UNION ALL SELECT 'customers', COUNT(*) FROM customers
UNION ALL SELECT 'accounts', COUNT(*) FROM accounts
UNION ALL SELECT 'transactions', COUNT(*) FROM transactions
UNION ALL SELECT 'loans', COUNT(*) FROM loans
UNION ALL SELECT 'loan_payments', COUNT(*) FROM loan_payments;

select * from customers;
-- =====================================================
-- Bank Management System (MySQL 8.0+)
-- File: 01_schema.sql
-- Purpose: Create the database and all tables
-- =====================================================

DROP DATABASE IF EXISTS bank_db;
CREATE DATABASE bank_db;
USE bank_db;

-- -----------------------------------------------------
-- 1. BRANCHES
-- -----------------------------------------------------
CREATE TABLE branches (
    branch_id    INT AUTO_INCREMENT PRIMARY KEY,
    branch_name  VARCHAR(100) NOT NULL,
    city         VARCHAR(50)  NOT NULL,
    ifsc_code    VARCHAR(11)  NOT NULL UNIQUE
);

-- -----------------------------------------------------
-- 2. EMPLOYEES
-- -----------------------------------------------------
CREATE TABLE employees (
    employee_id  INT AUTO_INCREMENT PRIMARY KEY,
    branch_id    INT NOT NULL,
    full_name    VARCHAR(100) NOT NULL,
    role         ENUM('TELLER','MANAGER','LOAN_OFFICER') NOT NULL,
    hire_date    DATE NOT NULL,
    CONSTRAINT fk_emp_branch
        FOREIGN KEY (branch_id) REFERENCES branches(branch_id)
);

-- -----------------------------------------------------
-- 3. CUSTOMERS
-- -----------------------------------------------------
CREATE TABLE customers (
    customer_id    INT AUTO_INCREMENT PRIMARY KEY,
    first_name     VARCHAR(50)  NOT NULL,
    last_name      VARCHAR(50)  NOT NULL,
    phone          VARCHAR(15)  NOT NULL UNIQUE,
    email          VARCHAR(100) UNIQUE,
    city           VARCHAR(50),
    date_of_birth  DATE NOT NULL,
    created_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- -----------------------------------------------------
-- 4. ACCOUNTS
-- -----------------------------------------------------
CREATE TABLE accounts (
    account_id     INT AUTO_INCREMENT PRIMARY KEY,
    customer_id    INT NOT NULL,
    branch_id      INT NOT NULL,
    account_type   ENUM('SAVINGS','CURRENT') NOT NULL,
    balance        DECIMAL(15,2) NOT NULL DEFAULT 0.00,
    status         ENUM('ACTIVE','FROZEN','CLOSED') NOT NULL DEFAULT 'ACTIVE',
    opened_date    DATE NOT NULL,
    CONSTRAINT chk_balance CHECK (balance >= 0),
    CONSTRAINT fk_acc_customer
        FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    CONSTRAINT fk_acc_branch
        FOREIGN KEY (branch_id) REFERENCES branches(branch_id)
);

-- -----------------------------------------------------
-- 5. TRANSACTIONS
-- -----------------------------------------------------
CREATE TABLE transactions (
    txn_id       BIGINT AUTO_INCREMENT PRIMARY KEY,
    account_id   INT NOT NULL,
    txn_type     ENUM('DEPOSIT','WITHDRAW','TRANSFER_IN','TRANSFER_OUT') NOT NULL,
    amount       DECIMAL(15,2) NOT NULL,
    txn_date     DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    description  VARCHAR(200),
    CONSTRAINT chk_amount CHECK (amount > 0),
    CONSTRAINT fk_txn_account
        FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);

-- -----------------------------------------------------
-- 6. LOANS
-- -----------------------------------------------------
CREATE TABLE loans (
    loan_id         INT AUTO_INCREMENT PRIMARY KEY,
    customer_id     INT NOT NULL,
    branch_id       INT NOT NULL,
    principal       DECIMAL(15,2) NOT NULL,
    interest_rate   DECIMAL(5,2)  NOT NULL,   -- yearly rate in %
    tenure_months   INT NOT NULL,
    status          ENUM('PENDING','ACTIVE','CLOSED','REJECTED') NOT NULL DEFAULT 'PENDING',
    start_date      DATE,
    CONSTRAINT chk_principal CHECK (principal > 0),
    CONSTRAINT chk_tenure CHECK (tenure_months > 0),
    CONSTRAINT fk_loan_customer
        FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    CONSTRAINT fk_loan_branch
        FOREIGN KEY (branch_id) REFERENCES branches(branch_id)
);

-- -----------------------------------------------------
-- 7. LOAN PAYMENTS (EMI schedule)
-- -----------------------------------------------------
CREATE TABLE loan_payments (
    payment_id   INT AUTO_INCREMENT PRIMARY KEY,
    loan_id      INT NOT NULL,
    due_date     DATE NOT NULL,
    emi_amount   DECIMAL(15,2) NOT NULL,
    paid_date    DATE,
    status       ENUM('DUE','PAID','LATE') NOT NULL DEFAULT 'DUE',
    CONSTRAINT chk_emi CHECK (emi_amount > 0),
    CONSTRAINT fk_pay_loan
        FOREIGN KEY (loan_id) REFERENCES loans(loan_id)
);

-- -----------------------------------------------------
-- 8. AUDIT LOG (filled by a trigger later)
-- -----------------------------------------------------
CREATE TABLE audit_log (
    log_id       BIGINT AUTO_INCREMENT PRIMARY KEY,
    account_id   INT NOT NULL,
    old_balance  DECIMAL(15,2),
    new_balance  DECIMAL(15,2),
    changed_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


show tables;
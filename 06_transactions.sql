-- =====================================================
-- Bank Management System
-- File: 06_transactions.sql
-- Purpose: Show COMMIT, ROLLBACK, and SAVEPOINT in action
-- =====================================================

USE bank_db;

-- -----------------------------------------------------
-- 1. A transaction that fully fails and rolls back
-- -----------------------------------------------------
SELECT balance FROM accounts WHERE account_id = 3;   -- note this value

START TRANSACTION;
    UPDATE accounts SET balance = balance - 300 WHERE account_id = 3;
    -- imagine something goes wrong here (e.g. the receiver account is invalid)
ROLLBACK;

SELECT balance FROM accounts WHERE account_id = 3;   -- unchanged, proves the rollback worked


-- -----------------------------------------------------
-- 2. SAVEPOINT -- undo only ONE step, keep the rest
-- -----------------------------------------------------
SELECT account_id, balance FROM accounts WHERE account_id IN (1,2);  -- note both values

START TRANSACTION;

    -- Step 1: deposit into account 1 (we want to KEEP this)
    UPDATE accounts SET balance = balance + 1000 WHERE account_id = 1;
    INSERT INTO transactions (account_id, txn_type, amount, description)
    VALUES (1, 'DEPOSIT', 1000.00, 'Step 1 - kept after savepoint rollback');

    SAVEPOINT after_deposit;

    -- Step 2: a withdrawal from account 2 (we will decide to UNDO just this)
    UPDATE accounts SET balance = balance - 500 WHERE account_id = 2;

    -- Changed our mind about step 2 only -- undo it, step 1 stays
    ROLLBACK TO SAVEPOINT after_deposit;

COMMIT;

SELECT account_id, balance FROM accounts WHERE account_id IN (1,2);
-- account 1 should be +1000 from before
-- account 2 should be UNCHANGED (its withdrawal was undone)


-- -----------------------------------------------------
-- 3. The CHECK constraint as a safety net
-- An update that would take balance below 0 is blocked
-- by chk_balance, even inside a transaction.
-- -----------------------------------------------------
SELECT balance FROM accounts WHERE account_id = 5;

START TRANSACTION;
    UPDATE accounts SET balance = balance - 999999999 WHERE account_id = 5;
    -- MySQL will reject this line with a CHECK constraint error.
    -- The row is NOT changed. You can now either:
    --   ROLLBACK;   -- to be safe and end the transaction cleanly
    -- or fix the amount and try again.
ROLLBACK;

SELECT balance FROM accounts WHERE account_id = 5;   -- unchanged

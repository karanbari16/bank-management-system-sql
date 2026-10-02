-- =====================================================
-- Bank Management System
-- File: 07_indexes.sql
-- Purpose: Show the effect of an index using EXPLAIN
-- =====================================================

USE bank_db;

-- -----------------------------------------------------
-- BEFORE: no index on (account_id, txn_date)
-- MySQL has to scan every row in transactions to find matches.
-- Look at the "type" column -- it will say ALL (full table scan)
-- -----------------------------------------------------
EXPLAIN SELECT * FROM transactions
WHERE account_id = 5 AND txn_date > '2024-03-01';


-- -----------------------------------------------------
-- Add a composite index.
-- account_id first, because we filter on it with "=" (exact match).
-- txn_date second, because we filter on it with a range (">").
-- This order matters -- an index works left to right.
-- -----------------------------------------------------
CREATE INDEX idx_txn_account_date ON transactions(account_id, txn_date);


-- -----------------------------------------------------
-- AFTER: same query, now MySQL can jump straight to the
-- matching rows instead of scanning the whole table.
-- "type" should change to "ref" or "range", and "rows" should drop.
-- -----------------------------------------------------
EXPLAIN SELECT * FROM transactions
WHERE account_id = 5 AND txn_date > '2024-03-01';

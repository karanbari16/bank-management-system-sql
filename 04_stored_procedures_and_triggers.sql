-- Procedure transfer_money — takes sender_account_id, receiver_account_id, and amount. 
-- It should: check the sender has enough balance, subtract from sender, add to receiver, 
-- and insert two rows into transactions (one TRANSFER_OUT, one TRANSFER_IN).
delimiter $$
create procedure transfer( in acc_id int,in rev_id int,in amt dec(15,2))
BEGIN
    DECLARE sender_balance DECIMAL(15,2);
 
    IF amt <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Transfer amount must be greater than zero';
    END IF;
 
    START TRANSACTION;
 
    -- FOR UPDATE locks this row so two transfers on the same
    -- account can't both read the same balance at once
    SELECT balance INTO sender_balance
    FROM accounts
    WHERE account_id = acc_id
    FOR UPDATE;
 
    IF sender_balance IS NULL THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Sender account not found';
    ELSEIF sender_balance < amt THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insufficient balance';
    ELSE
        UPDATE accounts
        SET balance = balance - amt
        WHERE account_id = acc_id;
 
        UPDATE accounts
        SET balance = balance + amt
        WHERE account_id = rev_id;
 
        INSERT INTO transactions (account_id, txn_type, amount, description)
        VALUES (acc_id, 'TRANSFER_OUT', amt,
                CONCAT('Transfer to account ', rev_id));
 
        INSERT INTO transactions (account_id, txn_type, amount, description)
        VALUES (rev_id, 'TRANSFER_IN', amt,
                CONCAT('Transfer from account ', acc_id));
 
        COMMIT;
    END IF;
END$$
DELIMITER ;
 
-- Test it:
CALL transfer(1, 2, 5000.00);
CALL transfer(3, 2, 999999999.00); 




-- Function get_loan_interest — takes principal and rate, returns the simple interest amount (principal * rate / 100).

DELIMITER $$
CREATE FUNCTION get_loan_interest(
    principal DECIMAL(15,2),
    rate      DECIMAL(5,2)
)
RETURNS DECIMAL(15,2)
DETERMINISTIC
BEGIN
    RETURN ROUND(principal * rate / 100, 2);
END$$
DELIMITER ;
 
SELECT get_loan_interest(500000, 9.5);
SELECT loan_id, principal, interest_rate, get_loan_interest(principal, interest_rate) AS interest
FROM loans;




-- Trigger log_balance_change — after any UPDATE on accounts, insert a row into audit_log with the account_id, old balance, and new balance.

DELIMITER $$
CREATE TRIGGER log_balance_change
AFTER UPDATE ON accounts
FOR EACH ROW
BEGIN
    IF OLD.balance <> NEW.balance THEN
        INSERT INTO audit_log (account_id, old_balance, new_balance)
        VALUES (NEW.account_id, OLD.balance, NEW.balance);
    END IF;
END$$
DELIMITER ;
 
-- Test it: run transfer_money above, then check the log:
SELECT * FROM audit_log ORDER BY log_id DESC;
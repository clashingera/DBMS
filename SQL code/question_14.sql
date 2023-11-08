
14.

a)	Consider table Stud(Roll, Att,Status)

Write a PL/SQL block for following requirement and handle the exceptions. Roll no. of student will be entered by user. Attendance of roll no. entered by user will be checked in Stud table. If attendance is less than 75% then display the message “Term not granted” and set the status in stud table as “D”. Otherwise display message “Term granted” and set the status in stud table as “ND”
b)	Write a PL/SQL block for following requirement using user defined exception handling. The account_master table records the current balance for an account, which is updated whenever, any deposits or withdrawals takes place. If the withdrawal attempted is more than the current balance held in the account. The user defined exception is raised, displaying an appropriate message. Write a PL/SQL block for above requirement using user defined exception handling.

a) PL/SQL Block to Check Student Attendance and Set Status:

```sql
-- Assuming you have a table named Stud with columns Roll, Att, and Status

DECLARE
    v_roll_number NUMBER;
    v_attendance NUMBER;
BEGIN
    -- Get the roll number from the user
    v_roll_number := &roll_number;

    -- Check the attendance for the given roll number
    SELECT Att
    INTO v_attendance
    FROM Stud
    WHERE Roll = v_roll_number;

    -- Check if attendance is less than 75%
    IF v_attendance < 75 THEN
        DBMS_OUTPUT.PUT_LINE('Term not granted');
        -- Set the status in the Stud table as "D"
        UPDATE Stud
        SET Status = 'D'
        WHERE Roll = v_roll_number;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Term granted');
        -- Set the status in the Stud table as "ND"
        UPDATE Stud
        SET Status = 'ND'
        WHERE Roll = v_roll_number;
    END IF;

    COMMIT;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Student not found');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;
/
```

In the above PL/SQL block, we first retrieve the student's attendance based on the provided roll number. Then, we check the attendance percentage and set the status accordingly. Finally, we update the status in the Stud table.

b) PL/SQL Block for User-Defined Exception Handling for Account Balance:

```sql
-- Assuming you have a table named account_master with columns account_number and balance

DECLARE
    v_account_number NUMBER;
    v_withdrawal_amount NUMBER;
    v_current_balance NUMBER;

    -- Define a user-defined exception
    insufficient_funds EXCEPTION;
    PRAGMA EXCEPTION_INIT(insufficient_funds, -20000);

BEGIN
    -- Get account number and withdrawal amount from the user
    v_account_number := &account_number;
    v_withdrawal_amount := &withdrawal_amount;

    -- Check the current balance for the given account number
    SELECT balance
    INTO v_current_balance
    FROM account_master
    WHERE account_number = v_account_number;

    -- Check if withdrawal amount is more than the current balance
    IF v_withdrawal_amount > v_current_balance THEN
        RAISE insufficient_funds;
    ELSE
        -- Perform the withdrawal and update the balance
        UPDATE account_master
        SET balance = balance - v_withdrawal_amount
        WHERE account_number = v_account_number;

        DBMS_OUTPUT.PUT_LINE('Withdrawal successful');
    END IF;

    COMMIT;
EXCEPTION
    WHEN insufficient_funds THEN
        DBMS_OUTPUT.PUT_LINE('Insufficient funds for withdrawal');
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Account not found');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;
/
```

In the above PL/SQL block, we define a user-defined exception named `insufficient_funds` and use it to raise an exception when the withdrawal amount exceeds the current balance. We handle this exception and provide an appropriate error message.

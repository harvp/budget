USE `budget_manager`;
DROP procedure IF EXISTS `create_tx`;

DELIMITER $$
USE `budget_manager`$$
CREATE PROCEDURE `create_tx` (
    IN p_subaccount_name VARCHAR(255),
    IN p_dollars DECIMAL(10,2),
    IN p_tx_date DATE, 
    IN p_add_or_remove ENUM('add', 'remove'),
    IN p_user_name VARCHAR(45)
)          
                
BEGIN
    DECLARE v_user_id INT;
    DECLARE v_subaccount_id INT;
    DECLARE v_total DECIMAL(10,2);

    -- Get user_id from users table
    SELECT user_id INTO v_user_id 
    FROM budget_manager.users 
    WHERE user_name = p_user_name 
    LIMIT 1;


    -- Get subaccount id from subaccounts table
    SELECT id INTO v_subaccount_id 
    FROM budget_manager.subaccounts 
    WHERE name = p_subaccount_name
    LIMIT 1;

    -- Insert transaction into transactions table
    INSERT INTO budget_manager.transactions (
        amount,
        subaccount_id,
        transaction_date,
        transaction_type,
        user_id
    )
    VALUES (
        p_dollars,
        v_subaccount_id,
        p_tx_date,
        p_add_or_remove,
        v_user_id
    );
    
 -- Get current balance from subaccounts table
    SELECT balance INTO v_total
    FROM budget_manager.subaccounts
    WHERE id = v_subaccount_id;

 -- Update the balance based on add or remove
    IF p_add_or_remove = 'add' THEN
        UPDATE budget_manager.subaccounts
        SET balance = v_total + p_dollars
        WHERE id = v_subaccount_id;
    ELSE 
        UPDATE budget_manager.subaccounts
        SET balance = v_total - p_dollars
        WHERE id = v_subaccount_id;
    END IF;

END;$$

DELIMITER ;


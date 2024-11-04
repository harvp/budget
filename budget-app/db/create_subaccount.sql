USE `budget_manager`;
DROP procedure IF EXISTS `create_subaccount`;

DELIMITER $$
USE `budget_manager`$$
-- Input: name of subaccount in varchar 255
-- Function: inserts values as new subaccount for use
CREATE PROCEDURE `create_subaccount` (
	IN p_name VARCHAR(255),
    IN p_beginning_balance DECIMAL(10,2)
)          
                
BEGIN
INSERT INTO budget_manager.subaccounts(
	name,
    balance,
    beginning_balance
)
VALUES (
	p_name,
    p_beginning_balance,
    p_beginning_balance
);
 
END;$$

DELIMITER ;

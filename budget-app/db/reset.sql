USE `budget_manager`;
DROP procedure IF EXISTS `reset`;

DELIMITER $$
USE `budget_manager`$$
CREATE PROCEDURE `reset` ()          
                
BEGIN
	DELETE FROM budget_manager.transactions;
    
    UPDATE budget_manager.subaccounts
	SET balance = beginning_balance;
 
END;$$

DELIMITER ;

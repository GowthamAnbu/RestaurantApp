DELIMITER $$
DROP PROCEDURE IF EXISTS `cancel_order`$$
CREATE PROCEDURE `cancel_order`(IN lid INT,OUT result TEXT)
BEGIN
/* 1 checking whether the order number is valid
 * 1.1 checking whether the order number is ordered food
 * 1.2 checking whether the order has been cancelled */
IF (EXISTS(SELECT ID FROM ORDERS WHERE ID=lid)) THEN
		IF (EXISTS(SELECT ID FROM ORDERS WHERE ID=lid AND STATUS='Ordered')) THEN
		START TRANSACTION;
		SET autocommit=0;
		UPDATE ORDERS SET STATUS='Cancelled' WHERE ID=lid;
			UPDATE ORDER_FOOD_MAINTENANCE
			INNER JOIN ORDERS
			ON ORDER_FOOD_MAINTENANCE.ORDER_ID=ORDERS.ID
			SET ORDER_FOOD_MAINTENANCE.STATUS='Cancelled'
			WHERE ORDERS.ID=lid  
			AND ORDER_FOOD_MAINTENANCE.STATUS='Ordered';
			SET result="Order cancelled successfully";
		COMMIT;
		ELSE 
		SET result="Order has already been cancelled"; 
		END IF;
ELSE
SET result="INVALID ORDER ID";
END IF;
END$$
DELIMITER ;
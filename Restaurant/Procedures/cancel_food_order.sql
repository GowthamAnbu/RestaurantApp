DELIMITER $$
DROP PROCEDURE IF EXISTS `cancel_food_order`$$
CREATE PROCEDURE `cancel_food_order`(IN lid INT,IN lfood_name VARCHAR(30),OUT result TEXT)
BEGIN
/* 1 checking whether the order number is valid
 * 1.1.1 checking whether the seat number ordered food
 * 1.1.1.1 checking whether the food name is valid
 * 1.1.1.2 checking whether the seat number ordered given food*/
DECLARE lfood_id TINYINT;
IF (EXISTS(SELECT ID FROM ORDERS WHERE ID=lid)) THEN
	IF (EXISTS(SELECT ID FROM ORDERS WHERE ID=lid AND STATUS='Ordered')) THEN
		IF (EXISTS(SELECT ID FROM SEED_FOOD WHERE NAME=lfood_name)) THEN
		SET lfood_id=get_food_id(lfood_name);
			IF (isfood_ordered(lid,lfood_id)) THEN
					START TRANSACTION;
					SET autocommit=0;
					UPDATE ORDER_FOOD_MAINTENANCE
					INNER JOIN ORDERS
					ON ORDER_FOOD_MAINTENANCE.ORDER_ID=ORDERS.ID
					SET ORDER_FOOD_MAINTENANCE.STATUS='Cancelled'
					WHERE ORDERS.ID=lid 
					AND ORDER_FOOD_MAINTENANCE.FOOD_ID=lfood_id 
					AND ORDER_FOOD_MAINTENANCE.STATUS='Ordered';
					IF (NOT EXISTS(SELECT ID FROM ORDER_FOOD_MAINTENANCE WHERE ORDER_ID=lid AND STATUS='Ordered'))THEN
					UPDATE ORDERS SET STATUS='Cancelled' WHERE ID=lid;
					END IF;
					SET result="FOOD CANCELLED SUCCESSFULLY";
					COMMIT;
			ELSE
			SET result="SUCH ITEM WAS NOT ORDERED";
			END IF;
		ELSE
		SET result="INVALID FOOD NAME";
		END IF;
	ELSE 
	SET result="ORDER IS CANCELLED ALREADY";
	END IF;
ELSE
SET result="INVALID ORDER ID";
END IF;
END$$
DELIMITER ;
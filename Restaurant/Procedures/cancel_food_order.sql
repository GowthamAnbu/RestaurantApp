DELIMITER $$
DROP PROCEDURE IF EXISTS `cancel_food_order`$$
CREATE PROCEDURE `cancel_food_order`(IN lseat_number TINYINT,IN lfood_name VARCHAR(30),OUT result text)
BEGIN
/* 1 checking whether the seat number is valid
 * 1.1 checking whether the seat number is active
 * 1.1.1 checking whether the seat number ordered food
 * 1.1.1.1 checking whether the seat number ordered valid food
 * 1.1.1.2 invalid food id
 * 1.1.2 checking whether the order has already been paid 
 * 1.1.3 checking whether the order has been cancelled 
 * 1.2 no items ordered*/
DECLARE lfood_id TINYINT;
IF (isseat_number(lseat_number)) THEN
	IF (EXISTS(SELECT SEAT_NUMBER FROM SEED_SEAT WHERE SEAT_NUMBER=lseat_number AND ACTIVE=1)) THEN
	IF (EXISTS(SELECT ID FROM ORDERS WHERE SEAT_NUMBER=lseat_number AND BILL_STATUS=0)) THEN
	SELECT ID INTO lfood_id FROM SEED_FOOD WHERE NAME=lfood_name;
	IF (isfood_ordered(lseat_number,lfood_id)) THEN
			UPDATE ORDER_FOOD_MAINTENANCE
			INNER JOIN ORDERS
			ON ORDER_FOOD_MAINTENANCE.ORDER_ID=ORDERS.ID
			SET ORDER_FOOD_MAINTENANCE.STATUS='Cancelled'
			WHERE ORDERS.SEAT_NUMBER=lseat_number 
			AND ORDER_FOOD_MAINTENANCE.FOOD_ID=lfood_id 
			AND ORDER_FOOD_MAINTENANCE.STATUS='Ordered';
	ELSE
	SELECT "INVALID FOOD NAME";
	END IF;
		ELSEIF (EXISTS(SELECT ID FROM ORDERS WHERE SEAT_NUMBER=lseat_number AND BILL_STATUS=1)) THEN
		SET result= "Bill has been paid";
		ELSEIF (EXISTS(SELECT ID FROM ORDERS WHERE SEAT_NUMBER=lseat_number AND BILL_STATUS=2)) THEN
		SET result= "Order has already been cancelled"; 
		ELSE
		SET result= "No items purchased for this seat number";
		END IF;
ELSE
	SET result= "NO ITEMS ORDERED";
	END IF;
ELSE
SET result= "INVALID SEAT NUMBER";
END IF;
END$$
DELIMITER ;
DELIMITER $$
CREATE PROCEDURE `pay_bill`(lseat_number TINYINT)
BEGIN
/* 1 checking whether the seat number is valid
 * 1.1 checking whether the seat number is active
 * 1.1.1 checking whether the seat number ordered food
 * 1.1.2 checking whether the order has already been paid
 * 1.2 no items ordered*/
IF (isseat_number(lseat_number)) THEN
	IF (isseat_number_active(lseat_number)) THEN
		IF (EXISTS(SELECT ID FROM ORDERS WHERE SEAT_NUMBER=lseat_number AND BILL_STATUS=0)) THEN
		START TRANSACTION;
		SET autocommit=0;
			UPDATE ORDERS SET BILL_STATUS=1 WHERE SEAT_NUMBER=lseat_number AND BILL_STATUS=0;
			UPDATE ORDER_FOOD_MAINTENANCE
			INNER JOIN ORDERS
			ON ORDER_FOOD_MAINTENANCE.ORDER_ID=ORDERS.ID
			SET ORDER_FOOD_MAINTENANCE.STATUS='Paid'
			WHERE ORDERS.SEAT_NUMBER=lseat_number 
			AND ORDERS.BILL_STATUS=1 
			AND ORDER_FOOD_MAINTENANCE.STATUS='Ordered';
			UPDATE SEED_SEAT SET ACTIVE=0 WHERE SEAT_NUMBER=lseat_number;
		COMMIT;
		ELSEIF (EXISTS(SELECT ID FROM ORDERS WHERE SEAT_NUMBER=lseat_number AND BILL_STATUS=1)) THEN
		SELECT "Bill has already been paid";
		ELSE
		SELECT "No items purchased for this seat number";
		END IF;
	ELSE
	SELECT "NO ITEMS ORDERED";
	END IF;
ELSE
SELECT "INVALID SEAT NUMBER";
END IF;
END$$
DELIMITER ;
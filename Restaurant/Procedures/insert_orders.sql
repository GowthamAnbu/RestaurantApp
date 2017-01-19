DELIMITER $$
DROP PROCEDURE IF EXISTS `insert_orders`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_orders`(IN lseat_number TINYINT,OUT lid INT)
BEGIN
/* 1 checking whether seat number has placed no order
 * 2 checking whether seat number has placed order
 * 3.1 checking whether seat number has already paid or cancelled the order placed*/
	IF (NOT EXISTS(SELECT ID FROM ORDERS WHERE SEAT_NUMBER=lseat_number)) THEN
	INSERT INTO ORDERS (SEAT_NUMBER) VALUES (lseat_number);
	SELECT ID INTO lid FROM ORDERS WHERE SEAT_NUMBER=lseat_number;
	END IF;
	IF (EXISTS(SELECT ID FROM ORDERS WHERE SEAT_NUMBER=lseat_number
	AND BILL_STATUS=0)) THEN
	SELECT ID INTO lid FROM ORDERS WHERE SEAT_NUMBER=lseat_number AND BILL_STATUS=0;		
	ELSE
	 IF (EXISTS(SELECT ID FROM ORDERS WHERE SEAT_NUMBER=lseat_number
	AND BILL_STATUS IN (1,2)))THEN
	INSERT INTO ORDERS (SEAT_NUMBER) VALUES (lseat_number);
	SELECT ID INTO lid FROM ORDERS WHERE SEAT_NUMBER=lseat_number AND BILL_STATUS=0;	
	END IF;
	END IF;	
END$$
DELIMITER ;
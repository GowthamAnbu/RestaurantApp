DELIMITER $$
USE `restaurant`$$
DROP PROCEDURE IF EXISTS `place_orders`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `place_orders`(lseat_number TINYINT,litem_name TEXT,lquantity TEXT,OUT result TEXT)
BEGIN
	IF (isseat_number(lseat_number)) THEN/* check valid seat number */
	IF (!isseat_number_active(lseat_number)) THEN/* check seat number active */
	IF (isitems_present(litem_name)) THEN/* check food is present */
	IF (isquantities_valid(lquantity)) THEN/* check valid quantity */
	IF (!check_input_length(litem_name,lquantity)) THEN/* check proper input */
	IF (!check_number_of_items(litem_name,lquantity)) THEN/* check maximum order limit */
	IF (isfoods_available(litem_name)) THEN/* check stock availability */
		START TRANSACTION;
		SET autocommit=0;
		UPDATE SEED_SEAT SET ACTIVE=1 WHERE SEAT_NUMBER=lseat_number;
		CALL insert_orders(lseat_number,@lorder_id);
		CALL insert_food_orders(@lorder_id,litem_name,lquantity);
		CALL update_price(@lorder_id);
		UPDATE SEED_SEAT SET ACTIVE=0 WHERE SEAT_NUMBER=lseat_number;
		SET result="Order placed successfully";
		COMMIT;
	ELSE
	SET result="sorry such item is out of stock";
	END IF;
	ELSE
	SET result="you have reached maximum order limit ";
	END IF;
	ELSE
	SET result="give proper input";
	END IF;
	ELSE
	SET result="invalid quantity";
	END IF;
	ELSE
	SET result="Sorry we don't serve such item ";
	END IF;		
	ELSE
	SET result="Seat Number already in use";
	END IF;
	ELSE
	SET result="please select a valid seat number";
	END IF;
END$$
DELIMITER ;
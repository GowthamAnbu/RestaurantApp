DELIMITER $$
DROP FUNCTION IF EXISTS `check_number_of_items`$$
CREATE FUNCTION `check_number_of_items`(litem_name TEXT,lquantity TEXT) 
RETURNS BOOLEAN
BEGIN
DECLARE result BOOLEAN DEFAULT FALSE;
DECLARE item_length INT DEFAULT 0;
DECLARE quantity_length INT DEFAULT 0;
/* storing number of items and number of quantities into local variables */
SELECT LENGTH(litem_name)-LENGTH(REPLACE(litem_name,',',''))+1 INTO item_length;
SELECT LENGTH(lquantity)-LENGTH(REPLACE(lquantity,',',''))+1 INTO quantity_length;
/* checking the number of items and quantity with the maximum order limit */
IF (item_length>(SELECT MAX_LIMIT FROM SEED_LIMIT WHERE ID=1)
OR quantity_length>(SELECT MAX_LIMIT FROM SEED_LIMIT WHERE ID=1))THEN
SET result=TRUE;
END IF;
RETURN result;
END$$
DELIMITER ;
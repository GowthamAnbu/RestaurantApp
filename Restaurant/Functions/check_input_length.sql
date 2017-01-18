DELIMITER $$
DROP FUNCTION IF EXISTS `check_input_length`$$
CREATE FUNCTION `check_input_length`(litem_name TEXT,lquantity TEXT) 
RETURNS BOOLEAN
BEGIN
DECLARE result BOOLEAN DEFAULT FALSE;
DECLARE item_length INT DEFAULT 0;
DECLARE quantity_length INT DEFAULT 0;
/* storing number of items and number of quantities into local variables */
SELECT LENGTH(litem_name)-LENGTH(REPLACE(litem_name,',',''))+1 INTO item_length;
SELECT LENGTH(lquantity)-LENGTH(REPLACE(lquantity,',',''))+1 INTO quantity_length;
/* checking the number of items with the number of quantity */
IF (item_length<>quantity_length)THEN
SET result=TRUE;
END IF;
RETURN result;
END$$
DELIMITER ;
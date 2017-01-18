DELIMITER $$
DROP FUNCTION IF EXISTS `isitems_present`$$
CREATE FUNCTION `isitems_present`(item_name TEXT) 
RETURNS BOOLEAN
BEGIN
DECLARE result BOOLEAN DEFAULT TRUE;
DECLARE item_length INT DEFAULT 0;
DECLARE i INT DEFAULT 1;
DECLARE temp_string TEXT;
DECLARE temp_string1 TEXT;
SELECT item_name INTO temp_string;
SELECT item_name INTO temp_string1;
/* storing the number of items in local variable */
SELECT LENGTH(item_name)-LENGTH(REPLACE(item_name,',',''))+1 INTO item_length;
/* while loop to check whether all food items present */
while_loop:
WHILE i<item_length DO
SELECT SUBSTRING(temp_string1,1,(SELECT LOCATE(',',temp_string1)-1)) INTO temp_string;
/* calling the respective function to validate the food item presence */
IF (!isitem_present(temp_string)) THEN
SET result=FALSE;
LEAVE while_loop;
END IF;
SELECT TRIM((SELECT SUBSTRING(temp_string1,1,(SELECT LOCATE(',',temp_string1)))) FROM temp_string1) INTO temp_string1;
SET i=i+1;
END WHILE;
/* calling the respective function to validate the food item presence */
IF (!isitem_present(temp_string1)) THEN
SET result=FALSE;
END IF;
RETURN result;
END$$
DELIMITER ;
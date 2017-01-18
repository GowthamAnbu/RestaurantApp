DELIMITER $$
DROP FUNCTION IF EXISTS `isfoods_available`$$
CREATE FUNCTION `isfoods_available`(lfood_name TEXT) RETURNS TINYINT(1)
BEGIN
DECLARE result BOOLEAN DEFAULT TRUE;
DECLARE item_length INT DEFAULT 0;
DECLARE i INT DEFAULT 1;
DECLARE temp_string TEXT;
DECLARE temp_string1 TEXT;
DECLARE temp_int TINYINT;
SELECT lfood_name INTO temp_string;
SELECT lfood_name INTO temp_string1;
/* storing the number of items in local variable */
SELECT LENGTH(lfood_name)-LENGTH(REPLACE(lfood_name,',',''))+1 INTO item_length;
/* loop to check the stock availability */
while_loop:
WHILE i<item_length DO
SELECT SUBSTRING(temp_string1,1,(SELECT LOCATE(',',temp_string1)-1)) INTO temp_string;
SELECT get_food_id(temp_string) INTO temp_int;
/* calling the corressponding function to check the stock availability */
IF (!isfood_available(temp_int)) THEN
SET result=FALSE;
LEAVE while_loop;
END IF;
SELECT TRIM((SELECT SUBSTRING(temp_string1,1,(SELECT LOCATE(',',temp_string1)))) FROM temp_string1) INTO temp_string1;
SET i=i+1;
END WHILE;
SELECT get_food_id(temp_string1) INTO temp_int;
/* calling the corressponding function to check the stock availability */
IF (!isfood_available(temp_int)) THEN
SET result=FALSE;
END IF;
RETURN result;
END$$

DELIMITER ;
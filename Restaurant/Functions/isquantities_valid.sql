DELIMITER $$
DROP FUNCTION IF EXISTS `isquantities_valid`$$
CREATE FUNCTION `isquantities_valid`(quantity MEDIUMTEXT) RETURNS TINYINT(1)
BEGIN
DECLARE result BOOLEAN DEFAULT TRUE;
DECLARE item_length INT DEFAULT 0;
DECLARE i INT DEFAULT 1;
DECLARE temp_string MEDIUMTEXT;
DECLARE temp_string1 MEDIUMTEXT;
SELECT quantity INTO temp_string;
SELECT quantity INTO temp_string1;
/* storing the number of items in local variable */
SELECT LENGTH(quantity)-LENGTH(REPLACE(quantity,',',''))+1 INTO item_length;
/* while loop to check whether all quantities are valid */
while_loop:
WHILE i<item_length DO
SELECT SUBSTRING(temp_string1,1,(SELECT LOCATE(',',temp_string1)-1)) INTO temp_string;
/* calling the respective function to validate quantity */
IF (!isquantity_valid(temp_string)) THEN
SET result=FALSE;
LEAVE while_loop;
END IF;
SELECT TRIM((SELECT SUBSTRING(temp_string1,1,(SELECT LOCATE(',',temp_string1)))) FROM temp_string1) INTO temp_string1;
SET i=i+1;
END WHILE;
/* calling the respective function to validate quantity */
IF (!isquantity_valid(temp_string1)) THEN
SET result=FALSE;
END IF;
RETURN result;
END$$
DELIMITER ;
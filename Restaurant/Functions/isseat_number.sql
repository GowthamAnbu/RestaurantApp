DELIMITER $$
DROP FUNCTION IF EXISTS `isseat_number`$$
CREATE FUNCTION `isseat_number`(lseat_number TINYINT)
RETURNS BOOLEAN
BEGIN 
DECLARE result BOOLEAN DEFAULT FALSE;
/* checking whether given seat number exists */
IF (EXISTS(SELECT SEAT_NUMBER FROM SEED_SEAT WHERE SEAT_NUMBER=lseat_number)) THEN
SET result=TRUE;
END IF;
RETURN result;
END$$
DELIMITER ;
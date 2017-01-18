DELIMITER $$
DROP FUNCTION IF EXISTS `isseat_number_active`$$
CREATE FUNCTION `isseat_number_active`(lseat_number TINYINT)
RETURNS BOOLEAN
BEGIN
DECLARE result BOOLEAN DEFAULT FALSE;
/* checking whether seat number is active */
IF (EXISTS(SELECT SEAT_NUMBER FROM SEED_SEAT WHERE SEAT_NUMBER=lseat_number AND active=1)) THEN
SET result=TRUE;
END IF;
RETURN result;
END$$
DELIMITER ;
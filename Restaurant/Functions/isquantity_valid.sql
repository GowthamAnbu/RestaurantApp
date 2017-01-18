DELIMITER $$
DROP FUNCTION IF EXISTS `isquantity_valid`$$\
CREATE FUNCTION `isquantity_valid`(quantity MEDIUMTEXT)
RETURNS BOOLEAN
BEGIN
DECLARE result BOOLEAN DEFAULT TRUE;
/* checking whether the quantity is negative or character */
IF (INSTR(quantity,'-') OR CONVERT(quantity,UNSIGNED INT)=0) THEN
SET result=FALSE;
END IF;
RETURN result;
END$$
DELIMITER ;
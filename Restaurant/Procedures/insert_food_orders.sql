DELIMITER $$
CREATE PROCEDURE `insert_food_orders`(lid INT,lfood_name TEXT,lquantity TEXT)
BEGIN
DECLARE item_length INT DEFAULT 0;
DECLARE i INT DEFAULT 1;
DECLARE temp_food_name TEXT;
DECLARE temp_food_name1 TEXT;
DECLARE temp_quantity TEXT;
DECLARE temp_quantity1 TEXT;
SELECT lfood_name INTO temp_food_name;
SELECT lfood_name INTO temp_food_name1;
SELECT lquantity INTO temp_quantity;
SELECT lquantity INTO temp_quantity1;
/* storing the number of items in local variable */
SELECT LENGTH(lfood_name)-LENGTH(REPLACE(lfood_name,',',''))+1 INTO item_length;
/* while loop to insert all the items */
while_loop:
WHILE i<item_length DO
SELECT SUBSTRING(temp_food_name1,1,(SELECT LOCATE(',',temp_food_name1)-1)) INTO temp_food_name;
SELECT SUBSTRING(temp_quantity1,1,(SELECT LOCATE(',',temp_quantity1)-1)) INTO temp_quantity;
/* calling the respective function to insert the item */
CALL insert_food_items(lid,get_food_id(temp_food_name),CONVERT(temp_quantity,UNSIGNED INT));
SELECT TRIM((SELECT SUBSTRING(temp_food_name1,1,(SELECT LOCATE(',',temp_food_name1)))) FROM temp_food_name1)
INTO temp_food_name1;
SELECT TRIM((SELECT SUBSTRING(temp_quantity1,1,(SELECT LOCATE(',',temp_quantity1)))) FROM temp_quantity1)
INTO temp_quantity1;
SET i=i+1;
END WHILE;
/* calling the respective function to insert the item */
CALL insert_food_items(lid,get_food_id(temp_food_name1),CONVERT(temp_quantity1,UNSIGNED INT));
END$$
DELIMITER ;
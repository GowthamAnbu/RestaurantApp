PROCEDURES:

1.place_orders(tinyint,string,string,outparameter)
	/* parameters are -> seatnumber,items,quantities,outparameter */
	Example 1. place_orders(1,'Tea,Coffee','3,2',@out)
	Example 2. place_orders(1,'Tea','1',@out)
	
2.cancel_order(int,outparameter)
	/* parameters are -> orderid,outparameter */
	Example cancel_order(12,@out)
	
3.cancel_food_order(int,varchar(30),outparameter)
	/* parameters are -> orderid,foodname,outparameter */
	Example cancel_food_order(12,'Tea',@out) 
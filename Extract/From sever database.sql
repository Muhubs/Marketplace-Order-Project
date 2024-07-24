INSERT INTO shopee_d (id, orderid, item_code, qty_a,price,qty,net_price,created_date,branch)
	SELECT id , orderid, item_code, qty_a,price,qty,net_price,created_date,branch
	FROM cyber.shopee_d@mdw_dblink;
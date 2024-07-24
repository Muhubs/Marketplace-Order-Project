PROCEDURE Check_Condition IS
    -- Define variables
    a VARCHAR2(20);
    
    -- Declare cursors
    CURSOR c1 IS
        SELECT ORDERID
        FROM SHOPEE_H
        GROUP BY ORDERID 
        HAVING COUNT(*) > 1;
        
    CURSOR c2 IS
        SELECT ORDERID
        FROM (
            SELECT ORDERID
            FROM SHOPEE_H 
            GROUP BY ORDERID, CREATED_DATE
            HAVING COUNT(*) > 1
        );
        
    CURSOR c3 IS
        SELECT DISTINCT A.ORDERID
        FROM SHOPEE_D A, INV_ITEM B
        WHERE TRUNC(A.CREATED_DATE) = TRUNC(sysdate)
        AND A.ITEM_CODE = B.ITEM_CODE(+)
        AND B.ITEM_DESC IS NULL;
        
    CURSOR c4 IS
        SELECT A.ORDERID
        FROM SHOPEE_D A, INV_ITEM B
        WHERE A.ITEM_CODE = B.ITEM_CODE(+)
        AND B.ITEM_STATUS = 'OBSOLUTE';
        
    CURSOR c5 IS
        SELECT ORDERID
        FROM SHOPEE_H
        GROUP BY ORDERID
        HAVING COUNT(*) > 1;
        
    CURSOR c6 IS
        SELECT DISTINCT ORDERID
        FROM (
            SELECT A.ORDERID
            FROM SHOPEE_D A
            WHERE ROUND((A.PRICE - A.NET_PRICE) * 100 / A.PRICE, 2) > 15
        ) A;
        
    CURSOR c7 IS
        SELECT DISTINCT A.ORDERID
        FROM SHOPEE_D A, INV_BOOKITEM B 
        WHERE A.ITEM_CODE = B.ITEM_CODE
        AND A.PRICE <> B.COVER_PRICE_BAHT 
        AND NVL(B.COVER_PRICE_BAHT, 0) > 0;
        
    CURSOR c8 IS    
        SELECT ORDERID
        FROM SHOPEE_H
        WHERE (ORDERID) NOT IN (SELECT ORDERID FROM SHOPEE_NO);
        
    CURSOR c9 IS    
        SELECT ORDERID
        FROM SHOPEE_D
        WHERE (ORDERID) NOT IN (SELECT ORDERID FROM SHOPEE_NO);
        
    CURSOR c10 IS    
        SELECT DISTINCT B.ORDERID
        FROM SHOPEE_D B
        WHERE B.ITEM_CODE IS NULL;
        
    CURSOR c11 IS    
        SELECT B.ORDERID
        FROM SHOPEE_D B
        WHERE B.QTY_A <> B.QTY;
        
    CURSOR c12 IS
        SELECT ORDERID, ITEM_CODE, COUNT(*) CC , CREATED_DATE
        FROM SHOPEE_D
        GROUP BY ORDERID, ITEM_CODE, CREATED_DATE
        HAVING COUNT(*) > 1
        ORDER BY ORDERID, ITEM_CODE;
        
BEGIN
    -- Loop through cursors and insert into tmp_ap
    FOR cur IN c1 LOOP
        INSERT INTO tmp_ap (pmt_nbr) VALUES (cur.ORDERID);
    END LOOP;
    
    FOR cur IN c2 LOOP
        INSERT INTO tmp_ap (pmt_nbr) VALUES (cur.ORDERID);
    END LOOP;
    
    FOR cur IN c3 LOOP
        INSERT INTO tmp_ap (pmt_nbr) VALUES (cur.ORDERID);
    END LOOP;
    
    FOR cur IN c4 LOOP
        INSERT INTO tmp_ap (pmt_nbr) VALUES (cur.ORDERID);
    END LOOP;
    
    FOR cur IN c5 LOOP
        INSERT INTO tmp_ap (pmt_nbr) VALUES (cur.ORDERID);
    END LOOP;
    
    FOR cur IN c6 LOOP
        INSERT INTO tmp_ap (pmt_nbr) VALUES (cur.ORDERID);
    END LOOP;
    
    FOR cur IN c7 LOOP
        INSERT INTO tmp_ap (pmt_nbr) VALUES (cur.ORDERID);
    END LOOP;
    
    FOR cur IN c8 LOOP
        INSERT INTO tmp_ap (pmt_nbr) VALUES (cur.ORDERID);
    END LOOP;
    
    FOR cur IN c9 LOOP
        INSERT INTO tmp_ap (pmt_nbr) VALUES (cur.ORDERID);
    END LOOP;
    
    FOR cur IN c10 LOOP
        INSERT INTO tmp_ap (pmt_nbr) VALUES (cur.ORDERID);
    END LOOP;
    
    FOR cur IN c11 LOOP
        INSERT INTO tmp_ap (pmt_nbr) VALUES (cur.ORDERID);
    END LOOP;
    
    FOR cur IN c12 LOOP
        INSERT INTO tmp_ap (pmt_nbr) VALUES (cur.ORDERID);
    END LOOP;
    
    COMMIT;
    
    message('¨º¡ÒÃµÃÇ¨ÊÍº áÅÐ´Õ´¢éÍÁÙÅ·Ôé§');
    message(' ');
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        NULL; -- Handle exception (if needed)
        
    --WHEN FORM_TRIGGER_FAILURE THEN NULL;
        
END;


----------
DELETE SHOPEE_H WHERE ORDERID IN (select PMT_NBR from tmp_ap);
 DELETE SHOPEE_D WHERE ORDERID IN (select PMT_NBR from tmp_ap);
 DELETE SHOPEE_H WHERE ORDERID IN (SELECT ORDERID FROM SBE_OBJECTS.SHOPEE_KEEP_H);
 DELETE SHOPEE_D WHERE (ORDERID,ITEM_CODE) IN (SELECT ORDERID,ITEM_CODE FROM SHOPEE_KEEP_D);

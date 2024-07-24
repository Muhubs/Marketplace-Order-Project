PROCEDURE Estimate_price IS
V_TMP VARCHAR2(50);
V_BRANCH VARCHAR2(50);
BEGIN
--**************
    V_BRANCH := 'CY';  --******
--**************      
    DELETE JJ_BOOKFAIR_PRICEST WHERE CU_CODE = '100040144' AND BRANCH = 'CY' ;
    DELETE OUTDOOR_SALES_CONVERT;    
    IF V_BRANCH = 'CY' THEN    
        V_TMP := JJ_GENPRICE_EST('100040144', '100666', '00666', '10103', '210','CY');
    END IF;               
COMMIT;

END;
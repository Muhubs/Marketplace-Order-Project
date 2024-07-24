PROCEDURE Export_excel IS
    v_file CLIENT_TEXT_IO.FILE_TYPE;
    v_filename VARCHAR2(100) := 'exported_data.csv'; -- Specify your desired file name
    v_separator VARCHAR2(10) := ','; -- CSV separator (comma)
    a varchar2(100);
BEGIN
    -- Open the file for writing
		a := FBean.Invoke_Char('CTRL.BEAN', 1, 'openFile', 'Open a file...,C:\,*.CSV');
    v_file := CLIENT_TEXT_IO.fopen(a, 'W');
    
    -- Write header row
    CLIENT_TEXT_IO.PUT(v_file, 'SO_NBR' || v_separator || 'SO_DATE' || v_separator || 'ORDER_REF' ||
                                    v_separator || 'CONTACTNAME' || v_separator || 'ITEMAMT_SO' ||
                                    v_separator || 'DLVRYAMT_SO' || v_separator || 'TOTALAMT_SO' ||
                                    v_separator || 'MODIFIED_NOTE' || v_separator || 'CREATED_DATE');

    -- Query data and write to CSV *********Place SO
    FOR rec IN (SELECT A.SO_NBR, A.SO_DATE, A.ORDER_REF, A.CONTACTNAME,  A.ITEMAMT ITEMAMT_SO, A.DLVRYAMT DLVRYAMT_SO, 
            A.TOTALAMT TOTALAMT_SO, A.MODIFIED_NOTE, A.CREATED_DATE                  
            FROM SLE_SALES_ORDER A, SLE_SALES_INVOICE B 
            WHERE A.SO_NBR = B.SO_NBR(+)
            AND A.CUSTOMER_CODE =  '100040144'    
            AND A.SLPRSN_CODE in  ('00666')
            AND A.SALEOFFICE_CODE in ('210')
            AND A.SO_STATUS = 'OPEN'
            AND A.ORDER_REF IN (SELECT VENDOR FROM JJ_BOOKFAIR_PRICEST WHERE CU_CODE = '100040144' AND BRANCH = 'CY') 
            AND B.SO_NBR IS NULL
            ORDER BY A.SO_NBR ) LOOP
        -- Format each row
        CLIENT_TEXT_IO.NEW_LINE(v_file); -- Start new line
        CLIENT_TEXT_IO.PUT(v_file, rec.SO_NBR || v_separator || rec.SO_DATE || v_separator ||''''||rec.ORDER_REF ||
                                    v_separator || rec.CONTACTNAME || v_separator || rec.ITEMAMT_SO ||
                                    v_separator || rec.DLVRYAMT_SO || v_separator || rec.TOTALAMT_SO ||
                                    v_separator || rec.MODIFIED_NOTE || v_separator || rec.CREATED_DATE);
    END LOOP;
    -- Query data and write to CSV *********Place SO
    CLIENT_TEXT_IO.NEW_LINE(v_file); -- Start new line
    CLIENT_TEXT_IO.PUT(v_file, 'Made_Order');
    FOR rec2 IN (select DISTINCT pmt_nbr  from tmp_ap) LOOP
        -- Format each row
        CLIENT_TEXT_IO.NEW_LINE(v_file); -- Start new line
        CLIENT_TEXT_IO.PUT(v_file,''''||rec2.pmt_nbr);
    END LOOP;
            
    -- Close the file
    CLIENT_TEXT_IO.FCLOSE(v_file);

    -- Inform user that export is complete
    MESSAGE('Export to CSV completed.', ACKNOWLEDGE);
EXCEPTION
    WHEN OTHERS THEN
        -- Handle exceptions (e.g., file operations, permissions)
        MESSAGE(SQLERRM, ACKNOWLEDGE);
END EXPORT_EXCEL;

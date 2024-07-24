PROCEDURE ImportCSV IS
		f CLIENT_TEXT_IO.FILE_TYPE;
    file_content VARCHAR2(4000);
    t1 VARCHAR2(4000);
    t2 VARCHAR2(4000);
BEGIN
		:SYSTEM.MESSAGE_LEVEL := '25';
		delete shopee_no;
		delete tmp_ap;
		commit;
		
    -- Open the file
    :MAIN.IMP_FILE := FBean.Invoke_Char('CTRL.BEAN', 1, 'openFile', 'Open a file...,C:\,*.CSV');
    f := CLIENT_TEXT_IO.fopen(:MAIN.IMP_FILE, 'R');
    
    -- Loop to read each line from the file
    LOOP
        -- Read a line from the file
         begin
           CLIENT_TEXT_IO.get_line(f, file_content);
					exception
           when no_data_found then
           exit;
			  end;
          
        
        -- Insert into tmptmp table
        INSERT INTO shopee_no(no, orderid)
        values(regexp_substr(file_content, '[^,]+', 1, 1),regexp_substr(file_content, '[^,]+', 1, 2));
        
        -- Optionally, add a newline between insertions
        CLIENT_TEXT_IO.new_line;
    END LOOP;
		commit;
    -- Close the file
    CLIENT_TEXT_IO.FCLOSE(f);
    
    -- Commit changes
    COMMIT;
    
    -- Optional: Output confirmation
    DBMS_OUTPUT.PUT_LINE('File processing complete.');

END;


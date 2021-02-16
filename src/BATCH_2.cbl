
      ******************************************************************
      *  Batch1 
      *
      ******************************************************************
       IDENTIFICATION              DIVISION.
      ******************************************************************
       PROGRAM-ID.                 BATCH_2.
       AUTHOR.                     UCA
       DATE-WRITTEN.               20201502
      ******************************************************************
       ENVIRONMENT DIVISION. 
      ******************************************************************
       INPUT-OUTPUT SECTION.
        FILE-CONTROL.
           SELECT TRANSACTIONS ASSIGN TO '/oscobol/src/transactions.txt'
           ORGANIZATION IS SEQUENTIAL.
           SELECT VISIT_FILE ASSIGN TO '/oscobol/src/data.txt'
           ORGANIZATION IS SEQUENTIAL.
 
      ******************************************************************
       DATA                        DIVISION.
      ******************************************************************
       FILE SECTION.
       FD TRANSACTIONS.
       01 VISIT-STRUCT.
         02 IP.
           03 IP_1 PIC 9(3).
           03 filler PIC X(1).
           03 IP_2 PIC 9(3).
           03 filler PIC X(1).
           03 IP_3 PIC 9(3).
           03 filler PIC X(1).
           03 IP_4 PIC 9(3).
         02 filler PIC X(5) VALUE 'XXXXX'.
         02 VISIT_DATE.
           03 VDAY PIC X(2).
           03 filler PIC X(1).
           03 VMONTH PIC X(3).
           03 filler PIC X(1).
           03 VYEAR PIC X(4).
           

       FD VISIT_FILE.
        01 INPUT-RECORD    PIC X(51).


      ******************************************************************
       WORKING-STORAGE             SECTION.
      ******************************************************************

       01 TABLE_VISIT.
        02 VISIT-STRUCT_TAB OCCURS 1500 times.
         03 IP_TAB.
           04 IP_1_TAB PIC 9(3).
           04 filler PIC X(1).
           04 IP_2_TAB PIC 9(3).
           04 filler PIC X(1).
           04 IP_3_TAB PIC 9(3).
           04 filler PIC X(1).
           04 IP_4_TAB PIC 9(3).
         03 filler PIC X(5) VALUE 'XXXXX'.
         03 VISIT_DATE_TAB.
           04 VDAY_TAB PIC X(2).
           04 filler PIC X(1).
           04 VMONTH_TAB PIC X(3).
           04 filler PIC X(1).
           04 VYEAR_TAB PIC X(4).       
 
       01 WS-CURRENT-DATE-DATA.
        05  WS-CURRENT-DATE.
           10  WS-CURRENT-YEAR         PIC 9(04).
           10  WS-CURRENT-MONTH        PIC 9(02).
           10  WS-CURRENT-DAY          PIC 9(02).
       05  WS-CURRENT-TIME.
           10  WS-CURRENT-HOURS        PIC 9(02).
           10  WS-CURRENT-MINUTE       PIC 9(02).
           10  WS-CURRENT-SECOND       PIC 9(02).
           10  WS-CURRENT-MILLISECONDS PIC 9(02).

       77 END-OF-FILE PIC Z(1). 
       77 TEMP_A PIC X(50). 
       77 TEMP_B PIC X(100).
       77 TEMP_C PIC X(100).
       77 TEMP_D PIC X(100).
       77 NUM PIC 9(5) VALUE 0.

       77 OCC PIC 999999.

       77 OCC2 PIC 999999.
       77 OCC3 PIC 999999.
       77 NB_ELT PIC 999999  VALUE 1.
       77 IND PIC 999999 VALUE 0.

       77 NO_FIND-IND              PIC X          VALUE "N".
       77 EOF-IND              PIC X          VALUE "N".

       01 WS-EOF-SW PIC X(01) VALUE 'N'.
           88 EOF-SW VALUE 'Y'.
           88 NOT-EOF-SW VALUE 'Y'.
       PROCEDURE                   DIVISION.
      ******************************************************************
       MAIN-RTN.
           DISPLAY "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!".
           DISPLAY "! BATCH 1   :                                    !".
           DISPLAY "! TRAITEMENT BACH STATISTIQUES VISITES           !".
           DISPLAY "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!". 
          

       MAIN-EXT.

           PERFORM 000-TRT-FONC001
              THRU 000-TRT-FONC001-FIN.
	    PERFORM 000-TRT-FONC002
              THRU 000-TRT-FONC002-FIN.
  
           STOP RUN.


       000-TRT-FONC001.
             MOVE FUNCTION CURRENT-DATE TO WS-CURRENT-DATE-DATA
             DISPLAY "PARAGRAPHE TRAITEMENT 1".
             DISPLAY "CURRENT DATE " SPACE WS-CURRENT-DATE-DATA.
      
             OPEN OUTPUT TRANSACTIONS                                
             OPEN INPUT VISIT_FILE
      
      	      MOVE 0 to OCC
      
             PERFORM READ-FILE UNTIL EOF-IND = "Y".
      
             
     
                CLOSE VISIT_FILE.
                CLOSE TRANSACTIONS.
      
                
       000-TRT-FONC001-FIN.


	   READ-FILE.
                
                UNSTRING INPUT-RECORD DELIMITED BY
                " " INTO TEMP_A TEMP_B TEMP_C TEMP_D
                UNSTRING TEMP_A DELIMITED BY "."
                INTO  IP_1 IP_2 IP_3 IP_4 
               
                UNSTRING TEMP_D DELIMITED BY "["
                INTO TEMP_B  TEMP_C
                
                MOVE TEMP_C TO VISIT_DATE
                ADD 1 to NUM
  		  
                MOVE VISIT-STRUCT  TO  VISIT-STRUCT_TAB(OCC) 
		  ADD 1 to OCC
                WRITE VISIT-STRUCT
                READ VISIT_FILE
                AT END
                  MOVE "Y" TO EOF-IND.

	   000-TRT-FONC002.
	       PERFORM TEST AFTER VARYING 
	       OCC2 FROM 1 BY 1 UNTIL OCC2 = OCC
            	  DISPLAY  VISIT-STRUCT_TAB(OCC2)
       
           	PERFORM  000-FIND_ID
          	END-PERFORM.

       000-TRT-FONC002-FIN.
       


       000-FIND_ID.
           MOVE "N" TO NO_FIND-IND
           PERFORM TEST AFTER VARYING
       	   OCC3 FROM 1 BY 1 UNTIL OCC3 <= NB_ELT AND
           NO_FIND-IND NOT = "Y"
           
           IF OCC=4
		     THEN MOVE "Y" TO NO_FIND-IND
	       END-IF
            
           END-PERFORM.

       000-FIND_ID_FIN.
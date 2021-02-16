
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
           03 SEP1 PIC X(1) VALUE '.'.
           03 IP_2 PIC 9(3).
           03 SEP2 PIC X(1) VALUE '.'.
           03 IP_3 PIC 9(3).
           03 SEP3 PIC X(1) VALUE '.'.
           03 IP_4 PIC 9(3).
           03 DATA1_f PIC X(5).
         02 VISIT_DATE.
           03 VDAY PIC X(2).
           03 FILLER PIC X(1).
           03 VMONTH PIC X(3).
           03 FILLER PIC X(1).
           03 VYEAR PIC X(4).
         02 VISITED_STR PIC X(10).
         02 TIMES_VISIT PIC 9(5).
        
         02 LINE-FEED  PIC X.
       FD VISIT_FILE.
        01 INPUT-RECORD    PIC X(51).


      ******************************************************************
       WORKING-STORAGE             SECTION.
      ******************************************************************
       01 VISIT-STRUCT-final.
        02 VISIT_info  OCCURS 3000 times.
           03 ID_IP.
            04 IP_f.
              05 IP_1_f PIC 9(3).
              05 FILLER PIC X(1).
              05 IP_2_f PIC 9(3).
              05 FILLER PIC X(1).
              05 IP_3_f PIC 9(3).
              05 FILLER PIC X(1).
              05 IP_4_f PIC 9(3).
            04 DATA1_f PIC X(5).
            04 VISIT_DATE_TAB_f.
              05 VDAY_f PIC X(2).
              05 FILLER PIC X(1).
              05 FILLER PIC X(1).
              05 VMONTH_f PIC X(3).
              05 FILLER PIC X(1).
              05 VYEAR_f PIC X(4).
           03 VISITED_STR_f PIC X(10).
           03 TIMES_VISIT_f PIC 9(5).   
           03 LINE-FEED_f  PIC X.

       01 TABLE_VISIT.
        02 VISIT-STRUCT_TAB OCCURS 3000 times.
         03 IP_TAB.
           04 IP_1_TAB PIC 9(3).
           04 filler PIC X(1).
           04 IP_2_TAB PIC 9(3).
           04 filler PIC X(1).
           04 IP_3_TAB PIC 9(3).
           04 filler PIC X(1).
           04 IP_4_TAB PIC 9(3).
         03 DATA1 PIC X(5).
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
           PERFORM 300-ECRITURE-FICHIER.


           DISPLAY "FIN PROG"
           STOP RUN.


       000-TRT-FONC001.
             MOVE FUNCTION CURRENT-DATE TO WS-CURRENT-DATE-DATA
             DISPLAY "PARAGRAPHE TRAITEMENT 1".
             DISPLAY "CURRENT DATE " SPACE WS-CURRENT-DATE-DATA.
      
             
             OPEN INPUT VISIT_FILE
      
                MOVE 0 to OCC
      
             PERFORM READ-FILE UNTIL EOF-IND = "Y".
      
             
     
                CLOSE VISIT_FILE.
               
      
                
       000-TRT-FONC001-FIN.

       300-ECRITURE-FICHIER.
           OPEN OUTPUT TRANSACTIONS                                
           PERFORM TEST AFTER VARYING  
           OCC2 FROM 1 BY 1 UNTIL OCC2 = NB_ELT 
              
              MOVE VISIT_info(OCC2) TO VISIT-STRUCT
              MOVE X'0A' TO LINE-FEED
        Move ' VISITED :' TO VISITED_STR
        MOVE '.' TO SEP1
        MOVE '.' TO SEP2
              MOVE '.' TO SEP3
        WRITE VISIT-STRUCT
           END-PERFORM.
 

       READ-FILE.
             READ VISIT_FILE
             AT END
             MOVE "Y" TO EOF-IND.

             UNSTRING INPUT-RECORD DELIMITED BY
             " " INTO TEMP_A TEMP_B TEMP_C TEMP_D
             UNSTRING TEMP_A DELIMITED BY "."
             INTO  IP_1 IP_2 IP_3 IP_4 
            
             UNSTRING TEMP_D DELIMITED BY "["
             INTO TEMP_B  TEMP_C
             UNSTRING TEMP_C  DELIMITED BY "]"
             INTO TEMP_D TEMP_C
                
             MOVE TEMP_D TO  VISIT_DATE
             ADD 1 to NUM
             MOVE X'0A' TO LINE-FEED.
      
             MOVE VISIT-STRUCT  TO  VISIT-STRUCT_TAB(OCC) 
               ADD 1 to OCC.
             
       
      
       000-TRT-FONC002.
           MOVE 0 TO NB_ELT
          



           PERFORM TEST AFTER VARYING 
           OCC2 FROM 1 BY 1 UNTIL OCC2 = OCC
               PERFORM  000-FIND_ID
               PERFORM 00-ANALYSE-FIND
        DISPLAY OCC2           
           END-PERFORM.
       
          
       000-TRT-FONC002-FIN.



       000-FIND_ID.
           MOVE "N" TO NO_FIND-IND
        move 0 TO OCC3
           PERFORM TEST AFTER VARYING
              OCC3 FROM 0 BY 1 UNTIL OCC3 = NB_ELT 
         OR  NO_FIND-IND NOT ="N"
        
               IF IP_TAB(OCC2)=IP_f(OCC3) 
                THEN
                 MOVE "Y" TO NO_FIND-IND
               END-IF
           END-PERFORM.
        
        00-ANALYSE-FIND.
              if NO_FIND-IND NOT = "Y"
              THEN

               MOVE IP_TAB(OCC2)
               TO IP_f(NB_ELT)
               MOVE VISIT_DATE_TAB(OCC2)
               TO VISIT_DATE_TAB_f(NB_ELT)
               MOVE X'0A' TO LINE-FEED_f(NB_ELT)
               ADD 1 TO NB_ELT
               ADD 2 TO TIMES_VISIT_f(NB_ELT)
           else 
           ADD 1 TO TIMES_VISIT_f(OCC3)

           END-IF.
           EXIT. 

      ******************************************************************
      *  Batch1 
      *
      ******************************************************************
       IDENTIFICATION              DIVISION.
      ******************************************************************
       PROGRAM-ID.                 BATCH_1.
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
       01 OUTPUT_RECCORD      PIC X(30000).
       01 TRANSACTION-STRUCT.
         02 UID PIC 9(5).
         02 DESC PIC X(25).
         02 DETAILS.
           03 AMOUNT PIC 9(6)V9(2).
           03 START-BALANCE PIC 9(6)V9(2).
           03 END-BALANCE PIC 9(6)V9(2).
         02 ACCOUNT-ID PIC 9(7).
         02 ACCOUNT-HOLDER PIC A(50).
         02 WS-CURRENT-DATE-TRANSACTION-ID.
           05  WS-CURRENT-DATE.
              10  WS-CURRENT-YEAR         PIC 9(04).
              10  WS-CURRENT-MONTH        PIC 9(02).
              10  WS-CURRENT-DAY          PIC 9(02).
           05 WS-CURRENT-TIME.
              10  WS-CURRENT-HOURS        PIC 9(02).
              10  WS-CURRENT-MINUTE       PIC 9(02).
              10  WS-CURRENT-SECOND       PIC 9(02).
              10  WS-CURRENT-MILLISECONDS PIC 9(02).       


       FD VISIT_FILE
           RECORDING MODE IS V                     
           BLOCK CONTAINS 0                       
           RECORD IS VARYING IN SIZE FROM 100 to 30000.
       01 INPUT-RECORD       PIC X(30000).


      ******************************************************************
       WORKING-STORAGE             SECTION.
      ******************************************************************
       01 VISIT-STRUCT.
         02 IP.
           03 IP_1 PIC 9(3).
           03 filler PIC X(1).
           03 IP_2 PIC 9(3).
           03 filler PIC X(1).
           03 IP_3 PIC 9(3).
           03 filler PIC X(1).
           03 IP_4 PIC 9(3).
         02 filler PIC X(5).
         02 VISIT_DATE.
           03 filler PIC X(1).
           03 VDAY PIC X(2).
           03 filler PIC X(1).
           03 VMONTH PIC X(3).
           03 filler PIC X(1).
           03 VYEAR PIC X(4).
           03 filler PIC X(1).
 
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

       01 TRANSACTION-RECORD.
        02 UID PIC 9(5) VALUE 12345.
        02 DESC PIC X(25) VALUE 'TEST TRANSACTION'.
        02 DETAILS.
       03 AMOUNT PIC 9(6)V9(2) VALUE 000124.34.
       03 START-BALANCE PIC 9(6)V9(2) VALUE 000177.54.
       03 END-BALANCE PIC 9(6)V9(2) VALUE 53.2.
        02 ACCOUNT-ID PIC 9(7) VALUE 1234567.
        02 WS-CURRENT-DATE-TRANSACTION.
           05  WS-CURRENT-DATE.
              10  WS-CURRENT-YEAR         PIC 9(04).
              10  WS-CURRENT-MONTH        PIC 9(02).
              10  WS-CURRENT-DAY          PIC 9(02).
           05 WS-CURRENT-TIME.
              10  WS-CURRENT-HOURS        PIC 9(02).
              10  WS-CURRENT-MINUTE       PIC 9(02).
              10  WS-CURRENT-SECOND       PIC 9(02).
              10  WS-CURRENT-MILLISECONDS PIC 9(02).

       77 END-OF-FILE PIC Z(1). 
      


       PROCEDURE                   DIVISION.
      ******************************************************************
       MAIN-RTN.
           DISPLAY "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!".
           DISPLAY "! BATCH 1   :                                    !".
           DISPLAY "! TRAITEMENT BACH STATISTIQUES VISITES           !".
           DISPLAY "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!". 
          
       MAIN-EXT.
           PERFORM 000-TRT-FONC001             
              THRU 000-TRT-FONC001-FIN
           STOP RUN.


        000-TRT-FONC001.           
           MOVE FUNCTION CURRENT-DATE TO WS-CURRENT-DATE-DATA
           MOVE WS-CURRENT-DATE-DATA TO WS-CURRENT-DATE-TRANSACTION.
           DISPLAY "PARAGRAPHE TRAITEMENT 1".
           DISPLAY WS-CURRENT-DATE-DATA.
           OPEN INPUT VISIT_FILE 
           READ VISIT_FILE
             AT END MOVE 1 TO END-OF-FILE
           END-READ
           
      ******************************************************************
           IF END-OF-FILE = 1
            CLOSE VISIT_FILE
           END-IF
          
           MOVE 0 TO END-OF-FILE.
           OPEN OUTPUT TRANSACTIONS

           PERFORM UNTIL END-OF-FILE = 1
                WRITE OUTPUT_RECCORD FROM INPUT-RECORD
                READ VISIT_FILE
                AT END MOVE 1 TO END-OF-FILE
                END-READ
           END-PERFORM

               
               
           CLOSE TRANSACTIONS.

          



        000-TRT-FONC001-FIN.
           EXIT. 
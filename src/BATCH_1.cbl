
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
 
      ******************************************************************
       DATA                        DIVISION.
      ******************************************************************
       FILE SECTION.
       FD TRANSACTIONS.

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

      ******************************************************************
       WORKING-STORAGE             SECTION.
      ******************************************************************
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
       PROCEDURE                   DIVISION.
      ******************************************************************
       MAIN-RTN.
           DISPLAY "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!".
           DISPLAY "! BATCH 1   :                                    !".
           DISPLAY "! TRAITEMENT BACH STATISTIQUES                   !".
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
           OPEN OUTPUT TRANSACTIONS
              WRITE TRANSACTION-STRUCT FROM TRANSACTION-RECORD
           CLOSE TRANSACTIONS.
        000-TRT-FONC001-FIN.
           EXIT. 
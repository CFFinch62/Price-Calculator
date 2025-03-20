'QB64 Price Calculator
'Author: Chuck Finch - ChuckSoft
'Date: 04/19/2018

'[INTITIALIZE GLOBAL VARIABLES AND CREATE BLANK MAIN PROGRAM WINDOW]
COLOR 0, 0: CLS
COLOR 0, 11: CLS


'[CREATE INITIAL USER INTERFACE]
PrintProgTitle
DrawMainWindow
PrintTextLabels
PrintMainButtons


'[MAIN PROGRAM LOOP]
'DO
'    GOSUB
'LOOP


'[PRINTS PROGRAM TITLE BANNER]
SUB PrintProgTitle
    COLOR 15, 1
    LOCATE 2, 2: PRINT SPACE$(78)
    LOCATE 2, 19
    COLOR 10, 1: PRINT "********** ";
    COLOR 15, 1: PRINT "QB64 PRICE CALCUTATOR";
    COLOR 10, 1: PRINT " *********"
    COLOR 15, 1
END SUB


'[DRAWS MENU SUB WINDOW]
SUB DrawMainWindow:
    DrawBox 4, 3, 20, 35
    COLOR 15, 0
    LOCATE 4, 13: PRINT " Price Calculator "
END SUB


'[PRINT HEADERS FOR DISPLAYING PART DETIALS]
SUB PrintTextLabels:
    COLOR 11, 1
    LOCATE 8, 9: PRINT " PRICE ($):"
    LOCATE 9, 9: PRINT "MARGIN (%):"
    LOCATE 10, 9: PRINT "PROFIT ($):"
    LOCATE 11, 9: PRINT "MARKUP (%):"
    LOCATE 12, 9: PRINT "  COST ($):"
END SUB

SUB PrintMainButtons:
    DrawButton 16, 9, 18, 15, 0, 11, "RESET"
    DrawButton 16, 20, 18, 30, 0, 2, "CALCULATE"
END SUB

'Define (Box with Double Line Border) drawing subroutine.
'When calling DrawBox - Row1,Col1 = Upper Left corner postion, Row2,Col2 = Lower Right corner position.
SUB DrawBox (Row1, Col1, Row2, Col2)
    COLOR 0, 1
    BoxWidth = Col2 - Col1 + 1
    LOCATE Row1, Col1
    PRINT CHR$(201); STRING$(BoxWidth - 2, CHR$(205)); CHR$(187)
    FOR A = Row1 + 1 TO Row2 - 1
        LOCATE A, Col1
        PRINT CHR$(186); SPACE$(BoxWidth - 2); CHR$(186)
    NEXT A
    LOCATE Row2, Col1
    PRINT CHR$(200); STRING$(BoxWidth - 2, CHR$(205)); CHR$(188)
END SUB


'[DRAWS BUTTON ON SCREEN]
SUB DrawButton (Row1, Col1, Row2, Col2, Clr1, Clr2, Name$)
    COLOR Clr1, Clr2
    BoxWidth = Col2 - Col1 + 1
    LOCATE Row1, Col1
    PRINT CHR$(201); STRING$(BoxWidth - 2, CHR$(205)); CHR$(187)
    FOR A = Row1 + 1 TO Row2 - 1
        LOCATE A, Col1
        PRINT CHR$(186); SPACE$(BoxWidth - 2); CHR$(186)
    NEXT A
    LOCATE Row2, Col1
    PRINT CHR$(200); STRING$(BoxWidth - 2, CHR$(205)); CHR$(188)
    LOCATE (Row1 + 1), Col1 + 1
    PRINT Name$
END SUB




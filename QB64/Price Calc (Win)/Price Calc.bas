': This program uses
': InForm - GUI library for QB64 - Beta version 8
': Fellippe Heitor, 2016-2018 - fellippe@qb64.org - @fellippeheitor
': https://github.com/FellippeHeitor/InForm
'-----------------------------------------------------------

': Controls' IDs: ------------------------------------------------------------------
REM NOTICE: THIS FORM HAS BEEN RECENTLY EDITED
'>> The controls in the list below may have been added or renamed,
'>> and previously existing controls may have been deleted since
'>> this program's structure was first generated.
'>> Make sure to check your code in the events SUBs so that
'>> you can take your recent edits into consideration.
': ---------------------------------------------------------------------------------
DIM SHARED QB64PriceCalculator AS LONG
DIM SHARED lblPRICE AS LONG
DIM SHARED lblMARGIN AS LONG
DIM SHARED lblPROFIT AS LONG
DIM SHARED lblMARKUP AS LONG
DIM SHARED lblCOST AS LONG
DIM SHARED txtPrice AS LONG
DIM SHARED txtMargin AS LONG
DIM SHARED txtProfit AS LONG
DIM SHARED txtMarkup AS LONG
DIM SHARED txtCost AS LONG
DIM SHARED btnHELP AS LONG
DIM SHARED btnRESET AS LONG
DIM SHARED btnCALCULATE AS LONG

': External modules: ---------------------------------------------------------------
'$INCLUDE:'InForm\InForm.ui'
'$INCLUDE:'InForm\xp.uitheme'
'$INCLUDE:'Price Calc.frm'

': Event procedures: ---------------------------------------------------------------
SUB __UI_BeforeInit

END SUB

SUB __UI_OnLoad

END SUB

SUB __UI_BeforeUpdateDisplay
    'This event occurs at approximately 30 frames per second.
    'You can change the update frequency by calling SetFrameRate DesiredRate%

END SUB

SUB __UI_BeforeUnload
    'If you set __UI_UnloadSignal = False here you can
    'cancel the user's request to close.

END SUB

SUB __UI_Click (id AS LONG)
    SELECT CASE id
        CASE frmMain

        CASE lblPrice

        CASE lblMargin

        CASE lblProfit

        CASE lblMarkup

        CASE lblCost

        CASE TextBox1

        CASE TextBox2

        CASE TextBox3

        CASE TextBox4

        CASE TextBox5

        CASE cmdReset

        CASE cmdCalc

    END SELECT
END SUB

SUB __UI_MouseEnter (id AS LONG)
    SELECT CASE id
        CASE frmMain

        CASE lblPrice

        CASE lblMargin

        CASE lblProfit

        CASE lblMarkup

        CASE lblCost

        CASE TextBox1

        CASE TextBox2

        CASE TextBox3

        CASE TextBox4

        CASE TextBox5

        CASE cmdReset

        CASE cmdCalc

    END SELECT
END SUB

SUB __UI_MouseLeave (id AS LONG)
    SELECT CASE id
        CASE frmMain

        CASE lblPrice

        CASE lblMargin

        CASE lblProfit

        CASE lblMarkup

        CASE lblCost

        CASE TextBox1

        CASE TextBox2

        CASE TextBox3

        CASE TextBox4

        CASE TextBox5

        CASE cmdReset

        CASE cmdCalc

    END SELECT
END SUB

SUB __UI_FocusIn (id AS LONG)
    SELECT CASE id
        CASE TextBox1

        CASE TextBox2

        CASE TextBox3

        CASE TextBox4

        CASE TextBox5

        CASE cmdReset

        CASE cmdCalc

    END SELECT
END SUB

SUB __UI_FocusOut (id AS LONG)
    'This event occurs right before a control loses focus.
    'To prevent a control from losing focus, set __UI_KeepFocus = True below.
    SELECT CASE id
        CASE TextBox1

        CASE TextBox2

        CASE TextBox3

        CASE TextBox4

        CASE TextBox5

        CASE cmdReset

        CASE cmdCalc

    END SELECT
END SUB

SUB __UI_MouseDown (id AS LONG)
    SELECT CASE id
        CASE frmMain

        CASE lblPrice

        CASE lblMargin

        CASE lblProfit

        CASE lblMarkup

        CASE lblCost

        CASE TextBox1

        CASE TextBox2

        CASE TextBox3

        CASE TextBox4

        CASE TextBox5

        CASE cmdReset

        CASE cmdCalc

    END SELECT
END SUB

SUB __UI_MouseUp (id AS LONG)
    SELECT CASE id
        CASE frmMain

        CASE lblPrice

        CASE lblMargin

        CASE lblProfit

        CASE lblMarkup

        CASE lblCost

        CASE TextBox1

        CASE TextBox2

        CASE TextBox3

        CASE TextBox4

        CASE TextBox5

        CASE cmdReset

        CASE cmdCalc

    END SELECT
END SUB

SUB __UI_KeyPress (id AS LONG)
    'When this event is fired, __UI_KeyHit will contain the code of the key hit.
    'You can change it and even cancel it by making it = 0
    SELECT CASE id
        CASE TextBox1

        CASE TextBox2

        CASE TextBox3

        CASE TextBox4

        CASE TextBox5

        CASE cmdReset

        CASE cmdCalc

    END SELECT
END SUB

SUB __UI_TextChanged (id AS LONG)
    SELECT CASE id
        CASE TextBox1

        CASE TextBox2

        CASE TextBox3

        CASE TextBox4

        CASE TextBox5

    END SELECT
END SUB

SUB __UI_ValueChanged (id AS LONG)
    SELECT CASE id
    END SELECT
END SUB

SUB __UI_FormResized

END SUB



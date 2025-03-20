' Product Pricing Calculator
' Created by Chuck Finch
' E-mail: cfinch@tag-solutions.com
' Web: http://www.tag-solutions.com
' This software is the sole property of Chuck Finch
'(c)2005 TAG Solutions

[setup.main.Window]

    '-----Begin code for #main

    nomainwin
    WindowWidth = 585
    WindowHeight = 480
    UpperLeftX = Int((DisplayWidth - WindowWidth) / 2)
    UpperLeftY = Int((DisplayHeight - WindowHeight) / 2)

    BackgroundColor$ = "darkgreen"
    ForegroundColor$ = "white"

    '-----Begin GUI objects code

    statictext #main.lblPrice, "Selling Price ($)",  20,  40, 280,  40
    statictext #main.lblMargin, "Margin (%)",  20, 100, 280,  40
    statictext #main.lblProfit, "Profit ($)",  20, 160, 280,  40
    statictext #main.lblMarkup, "Markup (%)",  20, 220, 280,  40
    statictext #main.lblCost, "Item Cost ($)",  20, 280, 280,  40

    TextboxColor$ = "darkblue"
    textbox #main.txtPrice, 320,  40, 220,  40
    textbox #main.txtMargin, 320, 100, 220,  40
    textbox #main.txtProfit, 320, 160, 220,  40
    textbox #main.txtMarkup, 320, 220, 220,  40
    textbox #main.txtCost, 320, 280, 220,  40

    button #main.btnClear,"Clear",[Clear], UL,  25, 360, 140,  40
    button #main.btnCalc,"CALCULATE",[Calculate], UL, 320, 360, 220,  40

    '-----end GUI objects code

    '-----Begin menu code

    menu #main, "&File",_
                "&Calculate", [Calculate],_
                "C&lear"    , [Clear],_
                "E&xit"     , [quit.main]

    menu #main, "&Help",_
                "How It Works", [Help]


    '-----end menu code

    open "Product Pricing Calculator" for window as #main
    print #main, "font verdana 18 bold"
    print #main, "trapclose [quit.main]"


[main.inputLoop]   'wait here for input event
    wait


[Calculate]   'Perform action for menu &File, item &Calculate

    'Determines entered values and calls appropriate calculation routine

    print #main.txtPrice, "!contents? Price$";
    print #main.txtMargin, "!contents? Margin$";
    print #main.txtProfit, "!contents? Profit$";
    print #main.txtMarkup, "!contents? Markup$";
    print #main.txtCost, "!contents? Cost$";

    ValueCount = 0
    CalcType$ = ""

    if Price$ <> "" Then
        CalcType$ = CalcType$ + "Price"
        ValueCount = ValueCount + 1
    end if

    if Margin$ <> "" Then
        CalcType$ = CalcType$ + "Margin"
        ValueCount = ValueCount + 1
    end if

    if Profit$ <> "" Then
        CalcType$ = CalcType$ + "Profit"
        ValueCount = ValueCount + 1
    end if

    if Markup$ <> "" Then
        CalcType$ = CalcType$ + "Markup"
        ValueCount = ValueCount + 1
    end if

    if Cost$ <> "" Then
        CalcType$ = CalcType$ + "Cost"
        ValueCount = ValueCount + 1
    end if

    if ValueCount < 2 Then
        Notice "Value Input Error" + Chr$(13) + "You must input at least 2 known values" + Chr$(13) + "in order to properly determine the other unkown values!"
    end if

    if ValueCount > 2 Then
        Notice "Value Input Error" + Chr$(13) + "You must input no more or less than 2 known values" + Chr$(13) + "in order to properly determine the other unkown values!"
    end if

    if ValueCount = 2 Then
       Select Case CalcType$
        Case "PriceMargin"
            gosub [PriceMargin]
        Case "PriceProfit"
            gosub [PriceProfit]
        Case "PriceMarkup"
            gosub [PriceMarkup]
        Case "PriceCost"
            gosub [PriceCost]
        Case "MarginProfit"
            gosub [MarginProfit]
        Case "MarginMarkup"
            gosub [MarginMarkup]
        Case "MarginCost"
            gosub [MarginCost]
        Case "ProfitMarkup"
            gosub [ProfitMarkup]
        Case "ProfitCost"
            gosub [ProfitCost]
        Case "MarkupCost"
            gosub [MarkupCost]
        end Select
    end if

    goto [main.inputLoop]


[Clear]   'Perform action for menu &File, item &Reset

    'Clears all textboxes for another calculation

    print #main.txtPrice, ""
    print #main.txtMargin, ""
    print #main.txtProfit, ""
    print #main.txtMarkup, ""
    print #main.txtCost, ""

    goto [main.inputLoop]


[Help]  'Perfrom action for menu &Help, item How It Works

    notice "How It Works" + Chr$(13) + "Enter any two known values and click on the CALCULATE button" + Chr$(13) + "to determine the remaining unknown values."

    goto [main.inputLoop]


[PriceMargin]   'Calculates Profit, Markup, Cost using Price and Margin

    Price = Val(Price$)
    Margin = Val(Margin$) / 100

    Profit = Price * Margin
    Cost = Price - Profit
    Markup = (Profit / Cost) * 100

    Profit$ = Str$(Profit)
    Cost$ = Str$(Cost)
    Markup$ = Str$(Markup)

    print #main.txtProfit, Profit$
    print #main.txtMarkup, Markup$
    print #main.txtCost, Cost$

    return


[PriceProfit]   'Calculates Margin, Markup, Cost using Price and Profit

    Price = Val(Price$)
    Profit = Val(Profit$)

    Cost = Price - Profit
    Markup = (Profit / Cost) * 100
    Margin = (Profit / Price) * 100

    Cost$ = Str$(Cost)
    Markup$ = Str$(Markup)
    Margin$ = Str$(Margin)

    print #main.txtMargin, Margin$
    print #main.txtMarkup, Markup$
    print #main.txtCost, Cost$

    return


[PriceMarkup]   'Calculates Margin, Profit, Cost using Price and Markup

    Price = Val(Price$)
    Markup = Val(Markup$) / 100

    Cost = Price / (1 + Markup)
    Profit = Cost * Markup
    Margin = (Profit / Price) * 100

    Cost$ = Str$(Cost)
    Profit$ = Str$(Profit)
    Margin$ = Str$(Margin)

    print #main.txtMargin, Margin$
    print #main.txtProfit, Profit$
    print #main.txtCost, Cost$

    return


[PriceCost] 'Calculates Margin, Profit, Markup using Price and Cost

    Price = Val(Price$)
    Cost = Val(Cost$)

    Profit = Price - Cost
    Margin = (Profit / Price) * 100
    Markup = (Profit / Cost) * 100

    Markup$ = Str$(Markup)
    Profit$ = Str$(Profit)
    Margin$ = Str$(Margin)

    print #main.txtMargin, Margin$
    print #main.txtProfit, Profit$
    print #main.txtMarkup, Markup$

    return


[MarginProfit]  'Calculates Price, Markup, Cost using Margin and Profit

    Margin = Val(Margin$) / 100
    Profit = Val(Profit$)

    Price = Profit / Margin
    Cost = Price - Profit
    Markup = (Profit / Cost) * 100

    Price$ = Str$(Price)
    Markup$ = Str$(Markup)
    Cost$ = Str$(Cost)

    print #main.txtPrice, Price$
    print #main.txtMarkup, Markup$
    print #main.txtCost, Cost$

    return


[MarginMarkup]  'Displays warning that this calculation cannot be completed.

    Notice "This calculation is not possible. Please enter Markup OR Margin and any other value."

    return


[MarginCost]    'Calculates Price, Profit, Markup using Margin and Cost

    Margin = Val(Margin$) / 100
    Cost = Val(Cost$)

    Profit = Cost * (Margin / (1 - Margin))
    Price = Cost + Profit
    Markup = (Profit / Cost) * 100

    Price$ = Str$(Price)
    Profit$ = Str$(Profit)
    Markup$ = Str$(Markup)

    print #main.txtPrice, Price$
    print #main.txtProfit, Profit$
    print #main.txtMarkup, Markup$

    return


[ProfitMarkup]  'Calculates Price, Margin, Cost using Profit and Markup

    Profit = Val(Profit$)
    Markup = Val(Markup$) / 100

    Cost = Profit / Markup
    Price = Cost + Profit
    Margin = (Profit / Price) * 100

    Price$ = Str$(Price)
    Margin$ = Str$(Margin)
    Cost$ = Str$(Cost)

    print #main.txtPrice, Price$
    print #main.txtMargin, Margin$
    print #main.txtCost, Cost$

    return


[ProfitCost]    'Calculates Price, Margin, Markup using Profit and Cost

    Profit = Val(Profit$)
    Cost = Val(Cost$)

    Price = Cost + Profit
    Margin = (Profit / Price) * 100
    Markup = (Profit / Cost) * 100

    Price$ = Str$(Price)
    Margin$ = Str$(Margin)
    Markup$ = Str$(Markup)

    print #main.txtPrice, Price$
    print #main.txtMargin, Margin$
    print #main.txtMarkup, Markup$

    return


[MarkupCost]    'Calculates Price, Margin, Profit using Markup and Cost

    Markup = Val(Markup$) / 100
    Cost = Val(Cost$)

    Price = Cost + (Cost * Markup)
    Profit = Price - Cost
    Margin = (Profit / Price) * 100

    Price$ = Str$(Price)
    Margin$ = Str$(Margin)
    Profit$ = Str$(Profit)

    print #main.txtPrice, Price$
    print #main.txtMargin, Margin$
    print #main.txtProfit, Profit$

    return


[quit.main] 'end the program
    close #main
    end



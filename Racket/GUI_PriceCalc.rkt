#lang racket/gui

;;Program: Racket Price Calculator
;;Author: Chuck Finch - ChuckSoft
;;Last Edited: 10/11/19
;;Purpose: Accept 2 of 5 pricing values (Price[$], Margin[%], Profit[$], Markup[%], and Cost[$]) then calculate and display the remainign 3 values
;;Exceptions: Margin and Markup cannot be the only 2 values supplied becasue both are [%}. A valid calulation requires 2 [$] or 1[%] and 1[$]

;;Create main window
(define toplevel
  (new frame% [label "Price Calculator"] [width 300] [height 350]))
(send toplevel show #t)

;;Create panels
(define values-panel
  (new group-box-panel% [label "Values"] [parent toplevel]))
(define actions-panel
  (new group-box-panel% [label "Actions"][parent toplevel] [alignment '(center center)]))
(send actions-panel set-orientation #t)

;;Create debug Message Pane
(define debug-pane (new horizontal-pane% [parent toplevel]))
(define msg
  (new message% [parent debug-pane][label "Last Action: No actions taken yet..."]))

;;Add controls to Values Panel
(define font
  (send the-font-list find-or-create-font 16 'modern 'normal 'normal))
(define price
  (new text-field% [parent values-panel] [label "PRICE($):"] [init-value ""] [font font]))
(define margin
  (new text-field% [parent values-panel] [label "MARGIN(%):"] [init-value ""] [font font]))
(define profit
  (new text-field% [parent values-panel] [label "PROFIT($):"] [init-value ""] [font font]))
(define markup
  (new text-field% [parent values-panel] [label "MARKUP(%):"] [init-value ""] [font font]))
(define cost
  (new text-field% [parent values-panel] [label "COST($):"] [init-value ""] [font font]))

;;Program Functions used by event handlers (callbacks)
(define (reset-values control event)
  (send price set-value "")
  (send margin set-value "")
  (send profit set-value "")
  (send markup set-value "")
  (send cost set-value "")
  (send msg set-label "Last Action: Reset."))

(define (calculate-values control event)
  (define prc(send price get-value))
  (define mrg(send margin get-value))
  (define pft(send profit get-value))
  (define mku(send markup get-value))
  (define cst(send cost get-value))

  ;; Write case routine that selects calulation by values given
  ;; Write calculation routines for every case possible
  ;; Return calculated values to unpopulated fields
  ;; Trap error for margin/markup only entry
  
  (send msg set-label "Last Action: Calculation."))

;;Add buttons with event handlers (callbacks) to Actions panel
(define reset
  (new button% [parent actions-panel][stretchable-width 0][label "RESET"][callback reset-values]))     

(define calculate
  (new button% [parent actions-panel][stretchable-width 0][label "CALCULATE"][callback calculate-values]))

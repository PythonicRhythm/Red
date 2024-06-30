Red []



letter: charset [#"A" - #"Z" #"a" - #"z"]
digit: charset [#"0" - #"9"]
digits: [some digit]
letters: [some letter]
whitespace: [some " "]

; allTokens: []

; LEXER
; lang-file:  trim read %lang-test.txt
; print lang-file
; lines: split lang-file "^/"
; probe lines

; probe allTokens


; GRAMMAR

redify: function [string] [
    replace/all string "*" " * "
    replace/all string "+" " + "
    replace/all string "-" " - "
]

action: [
    action-keyword
    whitespace
    expression
]

assignment: [
    identifier
    change [
        opt whitespace
        "<"
    ] ":"
    opt whitespace
    expression
]

action-keyword: [
    [change "show" "print"] |
    [change "unload" "probe"]
]

expression: [
    ; [term "+" expression] |
    ; [term "-" expression] |
    ; term

    term
    opt [ some [[opt whitespace "+" opt whitespace | opt whitespace"-" opt whitespace] term]]
]

term: [
    [factor opt whitespace "*" opt whitespace term] |
    [factor opt whitespace "/" opt whitespace term] |
    factor
]

factor: [
    identifier |
    integer |
    ["(" expression ")"] |
    [[change "-" "(negate "] [factor insert ")"]]
]

identifier: [
    letter
    opt [letters | digits | "_"]
]

integer: digits

; GRAB FILE AND USE LEXER
lang-file:  trim read %lang-test.txt
; print ["Read:" lang-file]
code-lines: split lang-file "^/"

probe parse lang-file [
    ; Make sure to check action first for
    ; keywords such as print and probe not
    ; being considered identifiers in assignment
    copy result some [[
        action |
        assignment |
        expression
        mark:
    ]
    #"^/"]
    ""
]

print ["Result:" result]
do redify result
; print f
; print f1


; LEXICAL ANALYSIS
; BEFORE PARSING WE NEED TO BREAK INPUT INTO A SEQUENCE OF TOKENS


; Homoiconic (same icon/symbol) paradigm

; x: 1

; print x: x + 1

; if x = 2 [
;     print "its true"
; ]

; print [
;     {There are two caves 
;     choose 1}
; ]
; choice: input

; either choice = "1" [
;     print "you die"
; ] [
;     print "you live"
; ]

; probe parse [1] [Integer!]

; probe parse [1 2 3] [Integer! Integer! Integer!]

; probe parse [1 2 3 4 5 6 7 8.0 9.0] [
;     some Integer!
;     integers:
;     float!
;     floats:
; ]

; print integers
; print floats

; add: function [x] [
;     x + x
; ]

; point: object [
;     x: 1
;     y: 2
; ]

; next-point: make point [
;     i-do-something: add 5
; ]

; print point/x
; print next-point/i-do-something

; access-modifiers: [
;     "public" |
;     "private" |
;     "default" |
;     "protected"
; ]

; static: [
;     "static"
; ]

; type: [
;     letters
;     opt [some "[]"]
; ]

; return-type: type

; method-name: letters

; argument: [
;     type
;     whitespace
;     letters
; ]

; arguments: [
;     some [
;         argument 
;         opt whitespace 
;         ","
;         opt whitespace
;     ]
;     argument
; ]

; open-paren: "("
; close-paren: ")"

; expression: [
;     opt type
;     whitespace
;     letters
;     whitespace
;     "="
;     whitespace
;     digits
;     ";"
; ]

; inner-code: [
;     opt whitespace
;     opt expression
;     opt whitespace
; ]

; open-brack: "open-bracket "
; close-brack: "close-bracket"

; java-method: [
;     opt [access-modifiers whitespace]
;     opt [static whitespace]
;     return-type
;     whitespace
;     method-name
;     opt whitespace
;     open-paren
;     [argument | arguments]
;     opt whitespace
;     close-paren
;     opt whitespace
;     open-brack
;     opt whitespace
;     inner-code
;     opt whitespace
;     close-brack
;     opt whitespace
; ]

; java-file:  (replace/all (replace/all (trim read %java-test.txt) "{" "open-bracket ") "}" "close-bracket")
; probe java-file

; probe parse java-file [
;     java-method
;     mark:
; ]

; probe mark

; Helps replace text in string
; parse some-string [to "{" change "lawl"]

; probe parse "770-402-8830" [
;     copy area-code digits
;     "-"
;     copy prefix digits
;     "-"
;     copy postfix digits
; ]

; probe parse "Hello there how are you?" [
;     to "are" jumps to "are" and stops behind it
;     thru "are" jumps to "are" and stops ahead of it
;     mark:
; ]

; print mark
; probe read https://www.red-lang.org/p/download.html

; Reduce executes the code. If you just probed
; it would return the array of variable names instead
; of values.
; probe reduce [area-code prefix postfix]

; probe load request-file

; probe parse "aasdfFFdfGasf" [
;     letters
; ]

; code: [1 + 1]
; code/3: 5
; probe do code
; if-code: [print "what in the facker" if-code/1: ]
; if 1 = 1 if-code
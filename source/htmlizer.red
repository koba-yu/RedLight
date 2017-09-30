Red [
	Title:	"html generation main logic"
	File:	%htmlizer.red
	Author:	"Koba-yu"
	Tabs:	4
]

lines: split what/buffer lf
keywords: make map! collect [foreach line lines [
		trim/head line
		keep take/part line (index? find line " ") - 1
		trim/head line
		keep trim/with take/part line (index? find line " ") - 1 "!"
	]
]
put keywords "Red" "Red"

space-tab: charset reduce [space tab]
spaces: [some space-tab]
cr-lf: charset reduce [cr lf]
word-breaker: [spaces | cr-lf]

num: charset ["0123456789"]
integer: [some num]
float: [some num "." some num]
numbers: ["-" float | "-" integer | float | integer]
percent: [numbers "%"]
pair: [integer "x" integer]
date-separator: charset [#"-" #"/"]
time-separator: charset ":"
date: [some num date-separator some num date-separator some num]
time-pattern: [some num ":" some num ":" some num]
time: ["T" time-pattern | time-pattern]

char: [{#"^^""} | {#"} thru {"}]
issue: ["#" to word-breaker]
file: ["%" to word-breaker | {%"} thru {"} ]
quote-string: [{"} thru {"}]
curly-string: ["{" thru "}"]
string: [quote-string | curly-string]

word-letter: charset ["0123456789" #"a" - #"z" #"A" - #"Z" "-" "." "_" "=" "<" ">" "+" "-" "|" "*"]
word-letters: [some word-letter]
word: [word-letters "?" | word-letters]
set-word: [word-letters ":"]
get-word: [":" to word-breaker]
lit-word: ["'" to word-breaker]
setters: ["/" set-word | set-word]

email: [word-letters "@" word-letters]

refine-or-path: ["/" get-word | "/" to word-breaker]
datatype: [word-letters "!"]
brackets: ["#(" | "(" | ")" | "[" | "]"]

comment: [";" to cr-lf | ";" to end]

esc-chars: make hash! [#"^"" "&quot;" #"&" "&amp;" #"<" "&lt;" #">" "&gt;"]
get-tag: function [val type] [
	type: either keyword-type: select keywords val [keyword-type] [type]
	val: rejoin collect [foreach c val [keep either esc: select esc-chars c [esc][c]]]
	rejoin [{<span class="} type {">} val {</span>}]
]

to-html: function ["Create syntax highlighted html from Red code"
	code [string! file! url!] "Red code or source file"
	/header "Make html with header"
		css [string! word!] "Css file name set into the html"
	return: [string!] "Converted html string"
] [
	unless equal? type? code string! [code: read code]

	ret: parse code [collect [any [
				copy val comment keep (get-tag val 'comment)
				| keep spaces
				| keep cr-lf
				| copy val brackets keep (get-tag val 'others)
				| copy val char keep (get-tag val 'char)
				| copy val string keep (get-tag val 'string)
				| copy val issue keep (get-tag val 'issue)
				| copy val file keep (get-tag val 'file)
				| copy val ["true" | "false"] keep (get-tag val 'logic)
				| copy val date keep (get-tag val 'date)
				| copy val time keep (get-tag val 'time)
				| copy val email keep (get-tag val 'email)
				| copy val setters keep (get-tag val 'setters)
				| copy val refine-or-path keep (get-tag val 'refinement)
				| copy val ["//" | "/"] keep (get-tag val 'op)
				| copy val pair keep (get-tag val 'pair)
				| copy val percent keep (get-tag val 'percent)
				| copy val numbers keep (get-tag val 'numbers)
				| copy val datatype keep (get-tag val 'datatype)
				| copy val get-word keep (get-tag val 'get-word)
				| copy val lit-word keep (get-tag val 'lit-word)
				| copy val word keep (get-tag val 'others)
			]
		]
	]

	pre-section: rejoin ["<pre><code>" rejoin ret "</code></pre>"]

	either header [
		rejoin [
			{<head><link href="./}
			to string! css
			{.css" rel="stylesheet" type="text/css" media="all" /></head>}
			pre-section
		]
	] [pre-section]
]
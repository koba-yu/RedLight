Red [
	Title: "html generation main logic"
	File: %htmlizer.red
	Author: "Koba-yu"
	Tabs:	 4
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
numbers: [float | integer]
pair: [integer "x" integer]

char: [{#"} thru {"}]
issue: ["#" to word-breaker]
file: ["%" to word-breaker | {%"} thru {"} ]
quote-string: [{"} thru {"}]
curly-string: ["{" thru "}"]
string: [quote-string | curly-string]

word-letter: charset ["0123456789" #"a" - #"z" #"A" - #"Z" "-" "." "_" "=" "<" ">" "+" "-" "|"]
word-letters: [some word-letter "?" | some word-letter]
set-word: [word-letters ":"]
get-word: [":" to word-breaker]
lit-word: ["'" to word-breaker]
setters: ["/" set-word | set-word]

refine-or-path: ["/" get-word | "/" to word-breaker]
datatype: [some not word-breaker "!"]
brackets: ["#(" | "(" | ")" | "[" | "]"]

comment: [";" thru cr-lf]

get-tag: function [val type] [
	keyword-type: select keywords val
	rejoin [{<span class="} either keyword-type [keyword-type] [type] {">} val {</span>}]
]

to-html: function ["Create syntax highlighted html from Red code"
	code [string! file! url!] "Red code or source file"
	/header "Make html with header"
		css [string! word!] "Css file name set into the html"
	return: [string!] "Converted html string"
] [
	data: either (type? code) = string! [code] [read code]
	ret: parse data [collect [any [
				copy val comment keep (get-tag val 'comment)
				| keep spaces
				| keep cr-lf
				| copy val char keep (get-tag val 'char)
				| copy val string keep (get-tag val 'string)
				| copy val issue keep (get-tag val 'issue)
				| copy val file keep (get-tag val 'file)
				| copy val setters keep (get-tag val 'setters)
				| copy val refine-or-path keep (get-tag val 'refinement)
				| copy val brackets keep (get-tag val 'others)
				| copy val pair keep (get-tag val 'pair)
				| copy val numbers keep (get-tag val 'numbers)
				| copy val datatype keep (get-tag val 'datatype)
				| copy val get-word keep (get-tag val 'get-word)
				| copy val lit-word keep (get-tag val 'lit-word)
				| copy val word-letters  keep (get-tag val 'others)
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
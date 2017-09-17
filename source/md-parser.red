Red [
	Title:	"markdown code block parser"
	File:	%md-parser.red
	Author:	"Koba-yu"
	Tabs:	4
]

convert-md: function ["Replace markdown file's Red code block to html"
	markdown [string! file! url!] "Red code or source file"
	return: [string!] "Converted string"
] [
	unless equal? type? markdown string! [markdown: read markdown]
	cr-lf: charset reduce [cr lf]
	rejoin parse markdown [collect [any [
				"```red" cr-lf copy code-block thru "```" keep (to-html code-block)
				| keep to "```red"
			]
		]
	]
]
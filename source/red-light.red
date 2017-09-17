Red [
	Title:	"Red's syntax highlighted html generator"
	File:	%red-light.red
	Author:	"Koba-yu"
	Tabs:	4
]

to-html: get in context [to-html: do %htmlizer.red] 'to-html
convert-md: get in context [convert-md: do %md-parser.red] 'convert-md
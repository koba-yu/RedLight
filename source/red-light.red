Red [
	Title:	"Red's syntax highlighted html generator"
	File:	%red-light.red
	Author:	"Koba-yu"
	Tabs:	4
]

_red-light: context [
	to-html: do %htmlizer.red
	convert-md: do %md-parser.red
]
to-html: get in _red-light 'to-html
convert-md: get in _red-light 'convert-md
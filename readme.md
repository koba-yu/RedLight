# RedLight
Simple syntax highlighted html generator for Red.  
Highlighting is done by css, and sample css files in the 'css' folder.

## Example
![example image](./images/example.JPG)

## Usage

The code below introduces `to-html` function.

```red
do %red-light.red
```

`to-html` generates string of `pre` and `code` tag data include the argument code.

```red
to-html {test: 1
print test
; console shows 1}
```

without `/header` refinement, you need to set css reference on the html manually.

Also source file and url can be used.

```red
to-html %check-folder-or-file.red
to-html https://raw.githubusercontent.com/koba-yu/RedStudy/master/Samples/check-folder-or-file.red
```

With `/header` refinement, the html would contain header tag and css reference that was specified by `css` word.  
(Currently it expects the css file exists on the same folder of the html.)

```red
to-html/header {test: 1
print test
; console shows 1} 'monokai_extended ; css name to be used.
```
# RedLight
Simple syntax highlighted html generator for Red.  
Highlighting is done by css, and sample css files in the 'css' folder.

## Example
![example image](./images/example.JPG)

## Usage

The code below introduces `htmlize` function.

```red
do %red-light.red
```

`htmlize` generates string of `pre` and `code` tag data include the argument code.

```red
htmlize {test: 1
print test
; console shows 1}
```

without `/header` refinement, you need to set css on the html manually.

Also source file and url can be used.

```red
htmlize %check-folder-or-file.red
htmlize https://raw.githubusercontent.com/koba-yu/RedStudy/master/Samples/check-folder-or-file.red
```

With `/header` refinement, the html would contain header tag and css reference that was specified by `css` word.

```red
htmlize/header {test: 1
print test
; console shows 1} "monokai_extended" ; css name to be used.
```
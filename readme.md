<link href="./css/monokai_extended.css" rel="stylesheet" type="text/css" media="all" />

# RedLight
Simple syntax highlighted html generator for Red.
Highlighted by css, sample css files in the 'css' folder.

## Example

<pre><code><span class="Red">Red</span> <span class="others">[</span>
	<span class="setters">Title:</span> <span class="string">"Show files and folders."</span>
	<span class="setters">Author:</span> <span class="string">"koba-yu"</span>
	<span class="setters">File:</span> <span class="file">%get-kanji-number.red</span>
<span class="others">]</span>

<span class="setters">dir:</span> <span class="function">request-dir</span>
<span class="setters">files:</span> <span class="action">read</span> <span class="function">dir</span>

<span class="setters">show-file-or-folder:</span> <span class="native">func</span> <span class="others">[</span> <span class="others">files</span> <span class="others">[</span><span class="datatype">block!</span><span class="others">]</span> <span class="others">]</span> <span class="others">[</span>
	<span class="native">foreach</span> <span class="others">file</span> <span class="others">files</span> <span class="others">[</span>
		<span class="native">print</span> <span class="others">[</span><span class="action">form</span> <span class="others">file</span> <span class="string">"is"</span> <span class="native">either</span> <span class="function">dir?</span> <span class="others">file</span> <span class="others">[</span><span class="string">"folder"</span><span class="others">]</span> <span class="others">[</span><span class="string">"file"</span><span class="others">]</span> <span class="others">]</span>
	<span class="others">]</span>
<span class="others">]</span>

<span class="others">show-file-or-folder</span> <span class="others">files</span></code></pre>


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
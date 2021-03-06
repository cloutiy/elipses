Red [
	author: 	{Yves Cloutier}
	email:		yves.cloutier@gmail.com
	version:	0.1
	date:			9/11/2018
]

comment {
  =====TODO=====
  - implement all of mom's typesetting macros as red functions
  - when document elements take a string, simply append
  - when document elements take a series, which are series of typesetting functions, "do" them.
  - implement introduction, preface, foreword, acknowlegments as mom "covers"
  - inside strings, use @ to denote inline commands, like @i[italic text], @footnote, @href, @index[word] etc
  - inside strings, @ also perform var subsitution, like @author, @today etc...
  - incorporate the red graphviz to generate diagrams and insert them as eps
  - use red to import from CSV, XML etc... for typesetting in doc
}




; To append MOM commands sequentially, and to perform preprocessing if needed before saving to file.
mom-doc: copy []

; For all the document setup and styling options for a MOM document. 
mom-prelude: [
{\# ===========Book Info============}
'doctitle 
'subtitle
'author  
{\# ===========Document Type============}
'doctype 
{.PRINTSTYLE TYPESET
.COPYSTYLE  COPY
\# ===========Body Fonts=========
.FAMILY T 
.PT_SIZE 12
\# .LS 14 \"Line spacing. Use Autolead.
.AUTOLEAD 1.20 FACTOR
\#============Book Cover=========}
'book-title
{.DOC_COVER_TITLE_FAMILY T
.DOC_COVER_TITLE_FONT CAPS
.DOC_COVER COVERTITLE SUBTITLE
\# ============Copyright Page============
\#.COVER_COLOR   blue
\#.COVER_LEAD    +2
\#.COVER_QUAD    L
.COVER_ADVANCE 1i \" or .DOC_COVER_START_POS 3i
\#.COVER_TITLE_FONT B
\#.COVER_TITLE_SIZE +4
\#.COVER_SUBTITLE_FONT I
\#.COVER_AUTHOR_FONT R
\#.COVER_AUTHOR_SPACE_BEFORE 6p
\#.COVER_DOCTYPE_COLOR red
\#.COVER_MISC_SIZE -1
\#.COVER_MISC_LEAD 12
\#.COVER_COPYRIGHT_SIZE -2
\#.COVER_COPYRIGHT_QUAD L
\#.COVER_MISC_QUAD R
.COVERTITLE "Copyright" \" Frontispiece, title page, etc
.COVERTEXT
All rights reserved. No part of this document can be reproduced without consent from the author. 
.COVERTEXT OFF
.COPYRIGHT "2018 Yves cloutier"
\# Now generate the copyright page
.COVER COVERTITLE COVERTEXT PDF_OUTLINE_LABEL "Copyright"
\# ===========Headers============
.HEADER_PLAIN
.HEADER_FAMILY T
.HEADER_LEFT "\E*[$CHAPTER_TITLE]"
.HEADER_RIGHT "\E*[$AUTHOR]"
.HEADER_CENTER "\E*[$TITLE]"
.HEADER_LEFT_FONT I
.HEADER_RIGHT_FONT I
.HEADER_CENTER_FONT I
\# ============Pagination============
.PAGENUM_HYPHENS OFF
\# ============Blockquotes============}
'blockquote-style
{\# ============Epigraphs============}
'epigraph-style
{\# ============Table of Contents============
.TOC_HEADER_STRING "Contents"
.TOC_HEADER_FONT R
.TOC_HEADER_QUAD "CENTER"
.TOC_LEAD 15p
.TOC_PN_FONT I
.TOC_ENTRY_STYLE 1 COLOR black
.TOC_ENTRY_STYLE 2 COLOR black
.TOC_ENTRY_STYLE 2 FONT I
.PAGINATE_TOC OFF
.AUTO_RELOCATE_TOC AFTER_COVER
\# ============Chapters============
\#.TITLE_FONT I
\#.CHAPTER_FONT I  					\"Chapter x
\#.CHAPTER_TITLE_FAMILY H
.CHAPTER_TITLE_FONT I
\#.CHAPTER_STRING "Chapter"
\#.PDF_LINK_COLOR black
\# ============Heading 1 Options============
\#.HEADING_STYLE 2 FONT I QUAD C SPACE_AFTER 2p}
'h1-style
{\# ============Heading 2 Options============}
'h2-style
{\# ============Heading 3 Options============}
'h3-style
{\# ============Code Options============}
'code-size
{\# ============Other Options============}
{.HY 
.SMARTQUOTES
.KERN
.RECTO_VERSO}
]


.page: func [] []

filename: none
mom-filename: none
pdf-filename: none
docinfo: func [options] [
	if find options 'author [
		replace mom-prelude 'author rejoin [ 
			{.AUTHOR "} trim (select options 'author) {"} ]
	]

	if find options 'title [
		replace mom-prelude 'doctitle rejoin [ 
			{.DOCTITLE "} trim (select options 'title)	{"} 
			{ \"Use .TITLE when not a book} ]
		replace mom-prelude 'book-title rejoin [ 
			{.DOC_COVERTITLE "} trim (select options 'title)	{"} 
			{ \" Book cover, collated document cover, etc} ]
	]

	if find options 'subtitle [
		replace mom-prelude 'subtitle rejoin [ 
			{.SUBTITLE "} trim (select options 'subtitle) {"} ]
	]

	; If filename {target_filename} was specified in docinfo [...]
	either find options 'filename [ filename: (select options 'filename) ] [
		; Otherwise elipses will generate a filename by combining the title and author name.
		filename: rejoin [ (select options 'title) { - } (select options 'author) ] ]

		; Add some file suffixes needed for generating the MOM document and resulting PDF.
		mom-filename: to-file rejoin [ filename ".mom" ]
		pdf-filename: to-file rejoin [ filename ".pdf" ]
]

typography: func [] []
defaults: func [options /local arg] [
  ; Page Dimensions
  if find options 'dimensions [
      arg: select options 'dimensions
      replace arg "inches" "i"
      replace arg "in" "i"
      replace arg "centimeters" "c"
      replace arg "cm" "c"
      width:  first arg 
      height: third arg
      unit:   fourth arg

      ;env/defaults/pl: rejoin [height "" unit]
      ;print env/defaults/pl
      ]
  ; Left Margin (page offset)
  if find options 'left-margin [
      arg: select options 'left-margin
      replace arg "inches" "i"
      replace arg "in" "i"
      replace arg "centimeters" "c"
      replace arg "cm" "c"
      width:  first arg 
      unit:   second arg

      ;env/defaults/po: rejoin [width "" unit]
     ; print env/defaults/po
      ]
]

copyright: func [][]
toc: func [] []
.footer: func [] []





.blockquote: func [options /local args][
	args: copy []
	if find options 'font-family [
		append args rejoin [ 
			{   FAMILY } (select options 'font-family) { \}]]

	if find options 'font-size [
		append args rejoin [ 
			{   SIZE } (select options 'font-size) { \}]]
	
	if find options 'font-style [
		append args rejoin [ 
			{   FONT } (select options 'font-style) { \}]]
	
	if find options 'quad [
		append args rejoin [ 
			{   QUAD } (select options 'quad) { \}]]
	
	if find options 'color [
		append args rejoin [ 
			{   COLOR } (select options 'color) { \}]]
	
	if find options 'auto-lead [
		append args rejoin [ 
			{   AUTOLEAD } (select options 'auto-lead) { \}]]
	
	if find options 'indent [
		append args rejoin [ 
			{   INDENT } (select options 'indent) { \}]]
	
	;if find options 'force-space [
	;	append args rejoin [ 
	;		{   .ALWAYS_FULLSPACE_QUOTES } (select options 'full-space) { \}]]
	
	;last-arg: last arg 
	replace last args " \" ""

	insert args {.BLOCKQUOTE_STYLE \} 
	replace mom-prelude 'blockquote-style args
	;print mom-prelude
]




.epigraph: func [options /local args][
	args: copy []
	if find options 'font-family [
		append args rejoin [ 
			{   FAMILY } (select options 'font-family) { \}]]

	if find options 'font-size [
		append args rejoin [ 
			{   SIZE } (select options 'font-size) { \}]]
	
	if find options 'font-style [
		append args rejoin [ 
			{   FONT } (select options 'font-style) { \}]]
	
	if find options 'quad [
		append args rejoin [ 
			{   QUAD } (select options 'quad) { \}]]
	
	if find options 'color [
		append args rejoin [ 
			{   COLOR } (select options 'color) { \}]]
	
	if find options 'auto-lead [
		append args rejoin [ 
			{   AUTOLEAD } (select options 'auto-lead) { \}]]
	
	if find options 'indent [
		append args rejoin [ 
			{   INDENT } (select options 'indent) { \}]]
	
	; Only add t prelude if options were specified. Use MOM defaults otherwise.
	if not empty? args [ 
		replace last args " \" "" 
		insert args {.EPIGRAPH_STYLE \} 
		replace mom-prelude 'epigraph-style args ]
	;print mom-prelude
]




.p: func [] []
.chapter: func [] []

.h1: func [options /local args][
	args: copy []
	if find options 'font-family [
		append args rejoin [ 
			{   FAMILY } (select options 'font-family) { \}]]

	if find options 'font-size [
		append args rejoin [ 
			{   SIZE } (select options 'font-size) { \}]]
	
	if find options 'font-style [
		append args rejoin [ 
			{   FONT } (select options 'font-style) { \}]]
	
	if find options 'quad [
		append args rejoin [ 
			{   QUAD } (select options 'quad) { \}]]
	
	if find options 'color [
		append args rejoin [ 
			{   COLOR } (select options 'color) { \}]]
	
	if find options 'capitalize? [
		if (select options 'capitalize?) = "yes" [	
			append args {   CAPS \} ]
			
		if (select options 'capitalize?) = "no" [	
			append args {   NO_CAPS \} ] 
	]
	
	if find options 'smallcaps [
		if (select options 'smallcaps) = "yes" [	
			append args {   SMALLCAPS \} ]
		
		if (select options 'smallcaps) = "no" [	
			append args {   NO_SMALLCAPS \}]
		]

	if find options 'needs [
		append args rejoin [ 
			{   NEEDS } (select options 'needs) { \} ]
	]

	if find options 'space-after [
		if (select options 'space-after) = "yes" [	
			append args {   SPACE_AFTER \} ]
		
		if (select options 'space-after) = "no" [	
			append args {   NO_SPACE_AFTER \}]
	]

	if find options 'auto-number? [
		if (select options 'autonumber) = "yes" [	append args {   NUMBER \} ]
		if (select options 'autonumber) = "no" [ append args {   NO_NUMBER \} ]
	]
	
	if find options 'prefix-chapter-numbers? []

	replace last args " \" ""

	insert args {.HEADING_STYLE 1 \} 
	replace mom-prelude 'h1-style args
	;print mom-prelude
]

.h2: func [options /local args][
	args: copy []
	if find options 'font-family [
		append args rejoin [ 
			{   FAMILY } (select options 'font-family) { \}]]

	if find options 'font-size [
		append args rejoin [ 
			{   SIZE } (select options 'font-size) { \}]]
	
	if find options 'font-style [
		append args rejoin [ 
			{   FONT } (select options 'font-style) { \}]]
	
	if find options 'quad [
		append args rejoin [ 
			{   QUAD } (select options 'quad) { \}]]
	
	if find options 'color [
		append args rejoin [ 
			{   COLOR } (select options 'color) { \}]]
	
	if find options 'capitalize? [
		if (select options 'capitalize?) = "yes" [	
			append args {   CAPS \} ]
			
		if (select options 'capitalize?) = "no" [	
			append args {   NO_CAPS \} ] 
	]
	
	if find options 'smallcaps [
		if (select options 'smallcaps) = "yes" [	
			append args {   SMALLCAPS \} ]
		
		if (select options 'smallcaps) = "no" [	
			append args {   NO_SMALLCAPS \}]
		]

	if find options 'needs [
		append args rejoin [ 
			{   NEEDS } (select options 'needs) { \} ]
	]

	if find options 'space-after [
		if (select options 'space-after) = "yes" [	
			append args {   SPACE_AFTER \} ]
		
		if (select options 'space-after) = "no" [	
			append args {   NO_SPACE_AFTER \}]
	]

	if find options 'auto-number? [
		if (select options 'autonumber) = "yes" [	append args {   NUMBER \} ]
		if (select options 'autonumber) = "no" [ append args {   NO_NUMBER \} ]
	]
	
	if find options 'prefix-chapter-numbers? []

	;last-arg: last arg 
	replace last args " \" ""

	insert args {.HEADING_STYLE 2 \} 
	replace mom-prelude 'h2-style args 
]

.image: func [] []

.code: func [options] [
	if find options 'font-size [ 
		replace mom-prelude 'code-size rejoin [ 
			{.CODE_SIZE } (select options 'font-size) ]]
]

code: func[body] [
	append mom-doc [ {.QUOTE} {.CODE} ]
	append mom-doc body 
	append mom-doc [ {.CODE OFF} {.QUOTE OFF} ]
]

language: func [selected-language] [
  if selected-language any ["spanish" "espanol" "espagnol"] [ replace mom-prelude/language {.hy es} ]
]

first-chapter: true ; .COLLATE only applies to chapters other than the first.
chapter: func [number title][
	; Tell MOM this is a book by specifying DOCTYPE CHAPTER 
	replace mom-prelude 'doctype {.DOCTYPE CHAPTER}

	; If the chapter number is a word, wrap it in quotes.
  if string? number [number: rejoin [ {"} number {"}] ]
  if word? number [number: rejoin [ {"} number {"}] ]

  ; If this is the first chapter, don't add .COLLATE
  either first-chapter [
    append mom-doc  rejoin [{.CHAPTER } number ]
    append mom-doc  rejoin [{.CHAPTER_TITLE "} title {"} ]
    append mom-doc  {.FORCE_RECTO}
    append mom-doc  {.START}
    first-chapter: false
  ] [
    append mom-doc  {.COLLATE}
    append mom-doc  rejoin [{.CHAPTER } number ]
    append mom-doc  rejoin [{.CHAPTER_TITLE "} title {"} ]
    append mom-doc  {.FORCE_RECTO}
    append mom-doc  {.START}
  ]
]

book: copy []
p: func [body] [
  append mom-doc  {.PP}
  append mom-doc  trim body
]

epigraph: func [body] [
  append mom-doc  {.EPIGRAPH}
  append mom-doc  trim body
  append mom-doc  {.EPIGRAPH OFF}
]

blockquote: func [body] [
  append mom-doc  {.BLOCKQUOTE}
  append mom-doc  trim body
  append mom-doc  {.BLOCKQUOTE OFF}
]

h1: func [body] [
  append mom-doc  rejoin [ {.HEADING 1 "} trim body {"} ]
]

h2: func [body] [
  append mom-doc  rejoin [ {.HEADING 2 "} trim body {"} ]
]

h3: func [body] [
  append mom-doc  rejoin [ {.HEADING 3 "} trim body {"} ]
]

list: func [items] [
  append mom-doc  {.LIST DIGIT}
  if find items 'indent [
    indent-value: select items 'indent
    append mom-doc  rejoin [ {.SHIFT_LIST } indent-value ]
    ]
  do items
  append mom-doc  {.LIST OFF}
]

li: func [item] [
  append mom-doc  {.ITEM}
  append mom-doc  trim item
]



publish: func [] [
	; Clear the screen
	call/console "clear"

	; If chapter {...} was used, the MOM DOCTYPE has been set to DOCTYPE CHAPTER.  If it hasn't been used, assume DOCTYPE DEFAULT
	replace mom-prelude 'doctype {.DOCTYPE DEFAULT}
	remove-each item mom-prelude [ lit-word? item ]
	
	; Insert the prelude required by MOM. The prelude includes document-wide options and styling options.
  insert mom-doc  mom-prelude

  ; If the target file already exists, overwrite it.
  if exists? mom-filename [ write mom-filename "" ]

  ; Go through each item in the document stack, append it to the target file, including a newline at the end.
  print rejoin [ {Generating intermediate file '} mom-filename {' ...} ]
  foreach item mom-doc  [ write/append mom-filename rejoin [ item "^/" ] ]

  ; Add .TOC at the end of the file. Should make this conditional on whether include-toc was specified.
  write/append mom-filename {.TOC}

  ; Generate the PDF
  print rejoin [ {Generating PDF document '} pdf-filename {' ...}]
  call/shell rejoin [ {pdfmom } {'} mom-filename {' > '} pdf-filename {'} ]
  ;call/console "git push origin master"
]
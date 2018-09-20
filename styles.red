Red []

typography [
  kerning     {on}
  hyphenation {english}
]

.page [
  height  {}
  width   {}
  two-sided?    {}
  margin-top    {}
  margin-bottom {}
  margin-left   {}
  margin-right  {}
]

defaults [
  dimensions      {6x9in}
  orientation     {portrait}
  left-margin     {1in}
  right-margin    {1i}
  top-margin      {1i}
  bottom-margin   {1i}
  font-family     {Times}
  font-style      {roman}
  font-size       {}
  line-spacing    {}
  need            {1}
]

toc [
  ;Level 1
  h1 [
      font-family {}
      font-size   {}
      ]
]

.footer [
  page-number {on}
  footnotes   {arabic}
]

.blockquote [
  quad        {JUSTIFY}
  ;font-family{Aragon}
  font-size   {-1}
  font-style  {R}
  ;color       {}
  ;indent      {}
  auto-lead   {1.20 FACTOR}
  ;force-space 
]

.epigraph [
  ;quad        {JUSTIFY}
  ;font-family {Aragon}
  ;font-size   {-1}
  font-style  {I}
  ;color       {}
  ;indent      {}
  ;auto-lead   {1.20 FACTOR} 
]

.p [
  quad        {justify}
  fill-text   {yes}
  indent-left {0}
  indent-right{0}
  font-size   {10p}
  font-style  {roman}
  first-line  {1.5cm}
  space-before{12p}
  space-after {12p}
]

.chapter [
  quad        {center}
  auto-number {yes}
  fill-text   {no}
  indent-left {0}
  indent-right{0}
  font-size   {10p}
  font-style  {roman}
]

.h1 [
  quad        {LEFT}
  ;auto-number {yes}
  font-family {T}
  font-size   {+4}
  font-style  {R}
  space-after {no}
]

.h2 [
  quad        {CENTER}
  ;auto-number {yes}
  font-family {T}
  font-size   {+2}
  font-style  {I}
  ;smallcaps		{yes}
  space-after {yes}
]

.image [
  align   {center}
  borders {1px}
]

.code [
	font-size {90}
]

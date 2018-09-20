# Ellipses Typesetter

> Better than Office, easier than `LaTex`

This is my attempt to learn the red programming language by implementing a document typesetter.

`Ellipses` is an attempt to create an easy to use typesetting solution which can be used both for general purpose and professional typesetting needs. 

It is essentially a "code generator", generating an input file for `groff`. It uses `mom` macros to create a layer of abstraction over `groff's` low-level commands.

# Files
* `typography.red` does all the work.
* `styles.red` is where you set the various document styling options.
* `secret-buddhism.red` is a book. It's pretty self-explanatory. Calling `red secret-buddhism.red` will generate a file secret-buddhism.mom then generates a PDF by calling pdfmom to process the .mom file using groff and turn it into a PDF.

# Dependencies
* groff
* Peter Schaffter's `mom` macros.

# Warning
I'm still in very early stages of development and experimentation so use at your own risk. Proper documentation on how to use and extend `ellipses` will be created using `ellipses` itself once things are a little less in a state of flux. 


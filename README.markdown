# Sephirothic
Configuration 4 your applications

## Usage

### Common
``` common-lisp
CL-USER> (in-package :sephirothic)
#<PACKAGE "SEPHIROTHIC">
STREE> (fruit :node1 :node2 :node3)
NIL
STREE> (setf (fruit :node1 :node2 :node3) "hanage")
#<FRUIT {1004E78D23}>
STREE> (fruit :node1 :node2 :node3)
"hanage"
```

### Core
``` common-lisp
CL-USER> (in-package :sephirothic)
#<PACKAGE "SEPHIROTHIC">

STREE> (defparameter *tree* (make-tree "/your/tree/data/stor/directory/"))
*TREE*

STREE> (make-application *tree* :appl)
#<APPLICATION {1006394CE3}>

STREE> (add-environment *tree* (application-at *tree* :code :appl) :env)
#<ENVIRONMENT {10037D5723}>

STREE> (fruit* *tree* :appl :env '(:node1 :node2 :node3))
NIL

STREE> (setf (fruit* *tree* :appl :env '(:node1 :node2 :node3)) "hanage")
#<FRUIT {100494F3A3}>

STREE> (fruit* *tree* :appl :env '(:node1 :node2 :node3))
"hanage"
```

## Installation
``` common-lisp
(ql:quickload :sephirothic)
```

## Origin of a name
[Tree of Life](https://en.wikipedia.org/wiki/Tree_of_life)

## Author

* Satoshi Iwasaki (yanqirenshi@gmail.com)

## Copyright

Copyright (c) 2015 Satoshi Iwasaki (yanqirenshi@gmail.com)

## License

Licensed under the LLGPL License.

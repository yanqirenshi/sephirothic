# Sephirothic
あなたのアプリケーションのための設定を管理します。

## 使い方
使い方には二種類あります。

| 種類               | 概要                                        |
|--------------------|---------------------------------------------|
| 共通の使い方       | slime立ちあげた時に全アプリで共通で使う場合 |
| コアな部分の使い方 | 特定のアプリ個別にカスタマイズしたい場合    |

### 共通の使い方
``` common-lisp
CL-USER> (in-package :sephirothic)
#<PACKAGE "SEPHIROTHIC">
SEPH> (fruit :node1 :node2 :node3)
NIL
SEPH> (setf (fruit :node1 :node2 :node3) "hanage")
#<FRUIT {1004E78D23}>
SEPH> (fruit :node1 :node2 :node3)
"hanage"
```

### コアな部分の使い方
``` common-lisp
CL-USER> (in-package :sephirothic)
#<PACKAGE "SEPHIROTHIC">

SEPH> (defparameter *tree* (make-tree "/your/tree/data/stor/directory/"))
*TREE*

SEPH> (make-application *tree* :appl)
#<APPLICATION {1006394CE3}>

SEPH> (add-environment *tree* (application-at *tree* :code :appl) :env)
#<ENVIRONMENT {10037D5723}>

SEPH> (fruit* *tree* :appl :env '(:node1 :node2 :node3))
NIL

SEPH> (setf (fruit* *tree* :appl :env '(:node1 :node2 :node3)) "hanage")
#<FRUIT {100494F3A3}>

SEPH> (fruit* *tree* :appl :env '(:node1 :node2 :node3))
"hanage"
```

## インストール
``` common-lisp
(ql:quickload :sephirothic)
```

## 名前の由来
[Tree of Life](https://en.wikipedia.org/wiki/Tree_of_life)

## 著者

* Satoshi Iwasaki (yanqirenshi@gmail.com)

## 著作権

Copyright (c) 2015 Satoshi Iwasaki (yanqirenshi@gmail.com)

## ライセンス

Licensed under the LLGPL License.

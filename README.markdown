# Sephirothic
Configuration 4 your applications

## Usage
```
> (fruit :app :env :node1 :node2 :node3)
nil

> (set (fruit :app :env :node1 :node2 :node3) "hanage")
hanage

> (fruit :app :env :node1 :node2 :node3)
hanage
```

## Installation
```
(ql:quickload :Sephirothic)
```

## Author

* Satoshi Iwasaki (yanqirenshi@gmail.com)

## Copyright

Copyright (c) 2015 Satoshi Iwasaki (yanqirenshi@gmail.com)

## License

Licensed under the LLGPL License.

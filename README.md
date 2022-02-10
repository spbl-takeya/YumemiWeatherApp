# YumemiWeatherApp

## 概要
こちらの研修課題を利用させてもらっています。
https://qiita.com/watanave/items/1cefa5aae18f5141c426

## メモ
- SwiftPackageManagerの利用方法
    - https://qiita.com/goofmint/items/ebad6d1499ae032da6ac

## エラーハンドリング
参考: https://qiita.com/koher/items/a7a12e7e18d2bb7d8c77

エラー発生時プログラマに『どのように対応させたいか』によって、エラーを4種類に分類する。

- Simple domain error
    - 前提条件が明確
        - エラーが起こったことさえわかればいい
    - ex. 整数→文字列の変換エラー
    - 戻り値を Optional にして nil でエラーを表現する
- Recoverable error
    - 原因ごとに対応
    - ex. ファイル入出力やネットワークのエラー
    - 関数側に `throws` をつけ、呼び出し側に `do-try-catch` をつける
- Universal error
    - 回復不能
        - プログラムが停止すればいい、エラー処理をする必要はない
    - ex. メモリ不足やスタックオーバーフローなどのエラー
    - `fatalError()` を呼ぶ
- Logic failure
    - コードの誤り
        - 不正な引数を渡していること自体がバグだ、コードを修正する必要がある
    - ex. Array のインデックスがはみ出てしまった場合や、 nil が入っている Optional に対して Forced unwrapping を実行してしまった場合
    - 満たすべき前提条件を `precondition()` で表す
    - `precondition` は `-Ounchecked` でビルドすると無視され、実行時のオーバーヘッドをなくすことができる

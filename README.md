# YumemiWeatherApp

## 概要
こちらの研修課題を利用させてもらっています。
https://qiita.com/watanave/items/1cefa5aae18f5141c426

## メモ
- SwiftPackageManagerの利用方法
    - https://qiita.com/goofmint/items/ebad6d1499ae032da6ac
- IBActionのリネームのやり方
    - コードの右クリック => Refactor => Rename でできそうな記事があったが、Storyboard内の参照はリネームされなかった。
    - 結局Assistant Editorで option + D&D でリネームした関数に再接続して(この時点で接続が2個になる)、 Connections Inspector で古い方の接続を削除した。

## エラーハンドリング
参考: https://qiita.com/koher/items/a7a12e7e18d2bb7d8c77

エラー発生時プログラマに『どのように対応させたいか』によって、エラーを4種類に分類する。

- Simple domain error
    - 前提条件が明確
        - エラーが起こったことさえわかればいい
    - ex. 整数→文字列の変換エラー
    - 戻り値を Optional にして nil でエラーを表現する
- Recoverable error
    - 発生条件が明確でなく、原因ごとに対応
        - Simple domain error と違ってエラーの種類を分ける
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

## UIViewControllerのライフサイクル
- https://qiita.com/motokiee/items/0ca628b4cc74c8c5599d
- 画面遷移のパターン、画面に引数の渡し方
    - 今後使えそう
    - https://www.fuwamaki.com/article/154
- フルスクリーン
    - https://qiita.com/akatsuki174/items/fd74cb1e08b70da5e4fd

## アプリのライフサイクル
- [公式](https://developer.apple.com/documentation/uikit/app_and_environment/managing_your_app_s_life_cycle)
    - iOS 13+: `UISceneDelegate`
    - iOS 12-: `UIApplicationDelegate`
- [iOSアプリのライフサイクル](https://qiita.com/KenNagami/items/766d5f95940c76a8c3cd)
    - AppDelegateとUniversalLink, 通知についても書いてある。 `SceneDelegate` は書いてない。
- [iOS 13 から導入されるSceneDelegateとは](https://tech.yappli.io/entry/scenedelegate)
    - `SceneDelegate` と `AppDelegate` の違いについて書いてある

### Scene
iPad OS 13から同じアプリを同時に複数分割表示できるようになった
プロセスは1つだが、Sceneが複数生成されている状態らしい
- [iOS13のScene-Basedライフサイクル(UISceneDelegate)](https://qiita.com/KenNagami/items/cbbe98b736fbdb24fef8)

## Observerパターン
- 通常 `NotificationCenter` を使うか、Observerパターンのライブラリがあるらしい
    - 参考: `AppDelegate` と `NotificationCenter` の使い分けが書いてあるが、通常ViewContollerそれぞれに監視させたいし疎結合にしたいので、 `NotificationCenter` を使う
        - https://neos21.net/blog/2018/07/13-01.html
- [Swift 3 以降の NotificationCenter の正しい使い方](https://qiita.com/mono0926/items/754c5d2dbe431542c75e)

### TODO
- 以下の記事がライフサイクルとObserverパターンやジェネリクスなどを併用してて、後で取り組んでみるとSwiftらしい書き方の理解が深まるかも
    - [アプリ全体のライフサイクルをViewControllerで観測する](https://qiita.com/to4iki/items/9e0dcd9403eb02259367)
- 比較用にこれもいいかも
    - [NotificationCenterを用いたライフサイクルイベントの検知](https://qiita.com/maebaru/items/2c4d5804f5979ecdd59d)

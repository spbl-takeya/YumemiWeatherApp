//
//  ViewController.swift
//  YumemiWeatherApp
//
//  Created by Takeya Shimizu on 2022/01/31.
//

import UIKit
import YumemiWeather

class ViewController: UIViewController {

    // MARK: Properties
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var minTemperature: UILabel!
    @IBOutlet weak var maxTemperature: UILabel!

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // MARK: IBAction
    @IBAction func reloadButton(_ sender: Any) {
        do {
            //Request: encode
            let params = FetchWeatherParam(area: "tokyo", date: "2020-04-01T12:00:00+09:00")
            let jsonData = try! JSONEncoder().encode(params)
            let jsonString = String(bytes: jsonData, encoding: .utf8)!

            let jsonResponseString = try YumemiWeather.fetchWeather(jsonString)
            print(jsonResponseString)

            //Response: decode
            let data: Data? = jsonResponseString.data(using: .utf8)
            let weatherReport = try JSONDecoder().decode(WeatherReport.self, from: data!)

            //Render
            renderWeatherReport(weatherReport)
        } catch let weatherError as YumemiWeatherError {
            //Recoverable error
            let errorMessage = getErrorMessage(from: weatherError)
            showErrorAlert(errorMessage: errorMessage)
        } catch is EncodingError {
            //Recoverable error?
            //本アプリはリクエストパラメーターをアプリ内で生成しているので、エンコードエラーは Logic failure になると思うので、このルートを作るべきでないと思う
            //※もしリクエストパラメーターの元データが外部サービスから取得しているのなら、アプリを終了させるのはおかしいと思うので Recoverable error にする
            //今回は練習がてらルートを作ってみた
            let errorMessage = "データをエンコードできませんでした。"
            showErrorAlert(errorMessage: errorMessage)
        } catch is DecodingError {
            //Recoverable error
            //外部サービスのせいでアプリを終了させるのもおかしいと思うので Recoverable error とする
            //もしAPI側で enum の case が先行して追加された場合はこのルートでエラーを処理する
            let errorMessage = "データをデコードできませんでした。"
            showErrorAlert(errorMessage: errorMessage)
        } catch {
            // TODO: 例外は2種類のみなのでこのルートは書かなくていいと思ったが、書かないとエラーになる
            //Recoverable error
            print("\(error)")
        }
    }

    // MARK: Methods

    /// 天気予報を描画する
    /// - Parameter json: 天気予報データ
    /// - Returns: なし
    func renderWeatherReport(_ weatherReport: WeatherReport) {
        weatherImage.image = getImage(weather: weatherReport.weather)
        minTemperature.text = String(weatherReport.minTemp)
        maxTemperature.text = String(weatherReport.maxTemp)
    }

    // TODO: 画像名とレスポンスを合わせてしまった方が簡単そうだが、あえて変換処理を入れておく
    /// 天気の画像を返す
    /// - Parameter weather: 天気を示す文字列
    /// - Returns: UIImageオブジェクト
    func getImage(weather: Weather) -> UIImage? {
        switch weather {
        case Weather.sunny:
            var image = UIImage(named: "sun")
            image = image?.withTintColor(.red)
            return image
        case Weather.cloudy:
            var image = UIImage(named: "cloud")
            image = image?.withTintColor(.gray)
            return image
        case Weather.rainy:
            var image = UIImage(named: "umbrella")
            image = image?.withTintColor(.blue)
            return image
        }
    }

    
    /// YumemiのAPIから返されたエラーからエラーメッセージを取得する
    /// - Parameter error: エラー
    /// - Returns: エラーメッセージ
    func getErrorMessage(from error: YumemiWeatherError) -> String {
        switch(error) {
        case .invalidParameterError:
            //YumemiWeatherの実装をみると、JSON版APIでないと返されない
            return "パラメーターが不正です。"
        case .unknownError:
            return "不明なエラーです。"
        }
    }

    
    /// エラーメッセージをアラート表示する
    /// - Parameter errorMessage: エラーメッセージ
    /// - Returns: なし
    func showErrorAlert(errorMessage: String) {
        let alertController: UIAlertController =
                    UIAlertController(title: "天気情報の取得に失敗しました",
                              message: errorMessage,
                              preferredStyle: .alert)

        // Default のaction
        let defaultAction: UIAlertAction =
                    UIAlertAction(title: "閉じる",
                          style: .default
//                          handler:{
//                            (action:UIAlertAction!) -> Void in
//                            // 処理
//                          }
                    )

        // actionを追加
        alertController.addAction(defaultAction)

        // UIAlertControllerの起動
        present(alertController, animated: true, completion: nil)
    }
}

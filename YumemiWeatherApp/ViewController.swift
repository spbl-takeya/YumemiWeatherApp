//
//  ViewController.swift
//  YumemiWeatherApp
//
//  Created by Takeya Shimizu on 2022/01/31.
//

import UIKit
import YumemiWeather

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var minTemperature: UILabel!
    @IBOutlet weak var maxTemperature: UILabel!

    @IBAction func reloadButton(_ sender: Any) {
        do {
            //Request: params
            let params = [
                "area": "tokyo",
                "date": "2020-04-01T12:00:00+09:00"
            ]
            let jsonData = try! JSONSerialization.data(withJSONObject: params, options: [])
            let jsonString = String(bytes: jsonData, encoding: .utf8)!

            let jsonResponseString = try YumemiWeather.fetchWeather(jsonString)
            print(jsonResponseString)

            //Response: decode
            let data: Data? = jsonResponseString.data(using: .utf8)
            let weatherReport = try JSONDecoder().decode(WeatherReport.self, from: data!)

            //Render
            weatherImage.image = getImage(weather: weatherReport.weather.rawValue)
            minTemperature.text = String(weatherReport.minTemp)
            maxTemperature.text = String(weatherReport.maxTemp)
        } catch let weatherError as YumemiWeatherError {
            //Recoverable error
            let errorMessage = getErrorMessage(from: weatherError)
            showErrorAlert(errorMessage: errorMessage)
        } catch is DecodingError {
            //Recoverable error
            //外部サービスのせいでアプリを終了させるのもおかしいと思うので Recoverable error とする
            let errorMessage = "データをデコードできませんでした。"
            showErrorAlert(errorMessage: errorMessage)
        } catch {
            // TODO: 例外は2種類のみなのでこのルートは書かなくていいと思ったが、書かないとエラーになる
            //Recoverable error
            print("\(error)")
        }
    }

    // TODO: 画像名とレスポンスを合わせてしまった方が簡単そうだが、あえて変換処理を入れておく
    /// 天気の画像を返す
    /// - Parameter weather: 天気を示す文字列
    /// - Returns: UIImageオブジェクト
    func getImage(weather: String) -> UIImage? {
        switch weather {
        // TODO: enumを導入してみたが、結局rawValueとの比較になっていてdefaultを削除できない
        // (Codableの導入で直接enumに変換できるようになればenumで比較できてdefaultを削除できる?)
        case Weather.sunny.rawValue:
            var image = UIImage(named: "sun")
            image = image?.withTintColor(.red)
            return image
        case Weather.cloudy.rawValue:
            var image = UIImage(named: "cloud")
            image = image?.withTintColor(.gray)
            return image
        case Weather.rainy.rawValue:
            var image = UIImage(named: "umbrella")
            image = image?.withTintColor(.blue)
            return image
        default:
            // TODO: Optionalとか勉強した方がよさそう
            return nil
        }
    }

    
    /// YumemiのAPIから返されたエラーからエラーメッセージを取得する
    /// - Parameter error: エラー
    /// - Returns: エラーメッセージ
    func getErrorMessage(from error: YumemiWeatherError) -> String {
        switch(error) {
        case .invalidParameterError:
            //YumemiWeatherの実装をみると、JSON版APIでないと返されないっぽい
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

// TODO: enumは単独のファイルなどに切り出した方がいいのか?
/// 天気
enum Weather: String, Codable {
    case sunny = "sunny"
    case cloudy = "cloudy"
    case rainy = "rainy"
}

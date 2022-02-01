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

    @IBAction func reloadButton(_ sender: Any) {
        let weatherString = YumemiWeather.fetchWeather()
        // print(weatherString)
        weatherImage.image = getImage(weather: weatherString)
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
}

// TODO: enumは単独のファイルなどに切り出した方がいいのか?
/// 天気
enum Weather: String {
    case sunny = "sunny"
    case cloudy = "cloudy"
    case rainy = "rainy"
}

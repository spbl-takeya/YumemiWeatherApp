//
//  ViewController.swift
//  YumemiWeatherApp
//
//  Created by Takeya Shimizu on 2022/01/31.
//

import UIKit
import YumemiWeather

class ViewController: UIViewController {

    let kSunny = "sunny"
    let kCloudy = "cloudy"
    let kRainy = "rainy"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBOutlet weak var weatherImage: UIImageView!

    @IBAction func reloadButton(_ sender: Any) {
        let weatherString = YumemiWeather.fetchWeather()
        print(weatherString)
        weatherImage.image = getImage(weather: weatherString)
    }

    // TODO: 画像名とレスポンスを合わせてしまった方が簡単そうだが、あえて変換処理を入れておく
    /// 天気の画像を返す
    /// - Parameter weather: 天気を示す文字列
    /// - Returns: UIImageオブジェクト
    func getImage(weather: String) -> UIImage? {
        switch weather {
        case kSunny:
            var image = UIImage(named: "sun")
            image = image?.withTintColor(.red)
            return image!
        case kCloudy:
            var image = UIImage(named: "cloud")
            image = image?.withTintColor(.gray)
            return image!
        case kRainy:
            var image = UIImage(named: "umbrella")
            image = image?.withTintColor(.blue)
            return image!
        default:
            // TODO: Optionalとか勉強した方がよさそう
            return nil
        }
    }
}

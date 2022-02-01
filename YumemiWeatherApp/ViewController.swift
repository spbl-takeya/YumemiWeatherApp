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
        weatherImage.image = UIImage(named: convertToImageName(weatherString: weatherString))
    }

    // TODO: 画像名とレスポンスを合わせてしまった方が簡単そうだが、あえて変換処理を入れておく
    func convertToImageName(weatherString: String) -> String {
        switch weatherString {
        case kSunny:
            return "sun"
        case kCloudy:
            return "cloud"
        case kRainy:
            return "umbrella"
        default:
            // TODO: Optionalとか勉強した方がよさそう
            return ""
        }
    }
}


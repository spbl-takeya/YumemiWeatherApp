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
        print(weatherString)
    }
}


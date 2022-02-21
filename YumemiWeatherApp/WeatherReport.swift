//
//  WeatherReport.swift
//  YumemiWeatherApp
//
//  Created by Takeya Shimizu on 2022/02/12.
//

import Foundation

/// 天気
enum Weather: String, Decodable {
    case sunny = "sunny"
    case cloudy = "cloudy"
    case rainy = "rainy"
}

/// 天気情報取得のためのリクエストパラメーター
struct FetchWeatherParam: Encodable {
    let area: String
    let date: String
}

/// 天気予報データ
struct WeatherReport: Decodable {
    let weather: Weather
    let maxTemp: Int
    let minTemp: Int

    enum CodingKeys: String, CodingKey {
        case weather
        case maxTemp = "max_temp"
        case minTemp = "min_temp"
    }
}

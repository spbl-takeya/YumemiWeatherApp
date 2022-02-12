//
//  FetchWeatherParam.swift
//  YumemiWeatherApp
//
//  Created by Takeya Shimizu on 2022/02/12.
//

import Foundation

/// 天気情報取得のためのリクエストパラメーター
struct FetchWeatherParam: Encodable {
    let area: String
    let date: String
}

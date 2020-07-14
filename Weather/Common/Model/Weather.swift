//
//  Weather.swift
//  Weather
//
//  Created by Kudzaiishe Mhou on 2020/07/07.
//  Copyright © 2020 Kudzaiishe Mhou. All rights reserved.
//

import Foundation

// MARK: - Weather
struct Weather: Codable {
  let id: Int
  let main, description: String
}

extension Weather {
  var icon: String? {
    switch id {
    case 200..<300: return "🌩"
    case 300..<400: return "🌧"
    case 500..<600: return "🌧"
    case 600..<700: return "🌨"
    case 700..<800: return "🌫"
    case 800: return "☀️"
    case 801..<810: return "☁️"
    default: return nil
    }
  }
}

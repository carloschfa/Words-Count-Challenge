//
//  String.swift
//  AT_Java_Keywords
//
//  Created by Carlos Henrique on 09/08/19.
//  Copyright © 2019 Carlos Henrique. All rights reserved.
//

import Foundation

extension Int {
    var formattedTime: String {
        let seconds: Int = self % 60
        let minutes: Int = (self / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

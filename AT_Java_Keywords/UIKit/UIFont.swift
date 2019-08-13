//
//  Fonts.swift
//  AT_Java_Keywords
//
//  Created by Carlos Henrique on 07/08/19.
//  Copyright © 2019 Carlos Henrique. All rights reserved.
//

import UIKit

extension UIFont {
    
    public enum words: CaseIterable {
        case largeTitle
        case body
        case button
        
        var font: UIFont {
            switch self {
            case .largeTitle: return UIFont.systemFont(ofSize: 34, weight: .bold)
            case .body: return UIFont.systemFont(ofSize: 17, weight: .regular)
            case .button: return UIFont.systemFont(ofSize: 17, weight: .semibold)
            }
        }
    }
    
}

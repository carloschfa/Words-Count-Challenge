//
//  Colors.swift
//  AT_Java_Keywords
//
//  Created by Carlos Henrique on 07/08/19.
//  Copyright © 2019 Carlos Henrique. All rights reserved.
//

import UIKit

extension UIColor {
    
    public enum words: CaseIterable {
        case darkGray
        case gray
        case orange
        
        var color: UIColor {
            switch self {
            case .darkGray: return UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
            case .gray: return UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
            case .orange: return UIColor(red: 255/255, green: 131/255, blue: 0/255, alpha: 1)
            }
        }
    }
    
}

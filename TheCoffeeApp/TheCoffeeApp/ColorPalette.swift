//
//  ColorPalette.swift
//  TheCoffeeApp
//
//  Created by Tiago Pereira on 08/05/2018.
//  Copyright © 2018 Apple Developer Academy. All rights reserved.
//

import UIKit

struct ColorPallete {
    static let darkPrimary: UIColor = color(r: 164, g: 108, b: 47)
    static let lightPrimary: UIColor = color(r: 230, g: 199, b: 148)
    static let lightBackground: UIColor = color(r: 211, g: 223, b: 227)
    static let mediumBackground: UIColor = color(r: 60, g: 86, b: 90)
    static let darkBackground: UIColor = color(r: 43, g: 8, b: 2)
    
    private static func color(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}

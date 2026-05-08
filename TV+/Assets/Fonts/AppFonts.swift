//
//  AppFonts.swift
//  TV+
//
//  Created by neo on 5/8/26.
//
import UIKit
import SwiftUI

enum AppFonts {
    
    static func regular(size: CGFloat) -> Font {
        .custom("DMSerifDisplay-Italic", size: size)
    }
    
    static func bold(_ size: CGFloat) -> Font {
        .custom("Poppins-Bold", size: size)
    }
    
    static func semiBold(_ size: CGFloat) -> Font {
        .custom("Poppins-SemiBold", size: size)
    }

}

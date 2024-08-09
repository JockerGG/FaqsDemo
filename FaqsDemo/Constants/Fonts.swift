//
//  Fonts.swift
//  FaqsDemo
//
//  Created by Eduardo Garcia Gonzalez on 08/08/24.
//

import Foundation
import UIKit

enum Fonts: String {
    case RedHatDisplayBlack = "RedHatDisplay-Black"
    case RedHatDisplayBlackItalic = "RedHatDisplay-BlackItalic"
    case RedHatDisplayBold = "RedHatDisplay-Bold"
    case RedHatDisplayBoldItalic = "RedHatDisplay-BoldItalic"
    case RedHatDisplayExtraBold = "RedHatDisplay-ExtraBold"
    case RedHatDisplayExtraBoldItalic = "RedHatDisplay-ExtraBoldItalic"
    case RedHatDisplayItalic = "RedHatDisplay-Italic"
    case RedHatDisplayLight = "RedHatDisplay-Light"
    case RedHatDisplayLightItalic = "RedHatDisplay-LightItalic"
    case RedHatDisplayMedium = "RedHatDisplay-Medium"
    case RedHatDisplayMediumItalic = "RedHatDisplay-MediumItalic"
    case RedHatDisplayRegular = "RedHatDisplay-Regular"
    case RedHatDisplaySemiBold = "RedHatDisplay-SemiBold"
    case RedHatDisplaySemiBoldItalic = "RedHatDisplay-SemiBoldItalic"
    case RobotoBlack = "Roboto-Black"
    case RobotoBlackItalic = "Roboto-BlackItalic"
    case RobotoBold = "Roboto-Bold"
    case RobotoBoldItalic = "Roboto-BoldItalic"
    case RobotoItalic = "Roboto-Italic"
    case RobotoLight = "Roboto-Light"
    case RobotoLightItalic = "Roboto-LightItalic"
    case RobotoMedium = "Roboto-Medium"
    case RobotoMediumItalic = "Roboto-MediumItalic"
    case RobotoRegular = "Roboto-Regular"
    case RobotoThin = "Roboto-Thin"
    case RobotoThinItalic = "Roboto-ThinItalic"
    case PoppinsBlack = "Poppins-Black"
    case PoppinsBlackItalic = "Poppins-BlackItalic"
    case PoppinsBold = "Poppins-Bold"
    case PoppinsBoldItalic = "Poppins-BoldItalic"
    case PoppinsExtraBold = "Poppins-ExtraBold"
    case PoppinsExtraBoldItalic = "Poppins-ExtraBoldItalic"
    case PoppinsExtraLight = "Poppins-ExtraLight"
    case PoppinsExtraLightItalic = "Poppins-ExtraLightItalic"
    case PoppinsItalic = "Poppins-Italic"
    case PoppinsLight = "Poppins-Light"
    case PoppinsLightItalic = "Poppins-LightItalic"
    case PoppinsMedium = "Poppins-Medium"
    case PoppinsMediumItalic = "Poppins-MediumItalic"
    case PoppinsRegular = "Poppins-Regular"
    case PoppinsSemiBold = "Poppins-SemiBold"
    case PoppinsSemiBoldItalic = "Poppins-SemiBoldItalic"
    case PoppinsThin = "Poppins-Thin"
    case PoppinsThinItalic = "Poppins-ThinItalic"
    case systemFont = "System"
    
    func getFont(withSize size: CGFloat) -> UIFont {
        if case .systemFont = self {
            return UIFont.systemFont(ofSize: size)
        }
        
        return UIFont(name: self.rawValue, size: size) ?? .systemFont(ofSize: size)
    }
}

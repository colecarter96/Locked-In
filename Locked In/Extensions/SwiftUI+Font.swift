//
//  SwiftUI+Font.swift
//  Locked In
//
//  Created by Cole Carter on 8/3/25.
//

import SwiftUI

extension Font{
    static func geist(fontStyle: Font.TextStyle = .body, fontWeight: Weight = .regular) -> Font {
        return Font.custom(CustomFont(weight: fontWeight).rawValue, size: fontStyle.size)
    }
    
    static func pretendard(fontStyle: Font.TextStyle = .body, fontWeight: Weight = .regular) -> Font {
        return Font.custom(PretendardFont(weight: fontWeight).rawValue, size: fontStyle.size)
    }
    
    static func pretendard(size: CGFloat, weight: PretendardFont) -> Font {
            return .custom(weight.rawValue, size: size)
    }
}

extension Font.TextStyle{
    var size: CGFloat{
        switch self{
        case .largeTitle: return 34
        case .title: return 30
        case .title2: return 22
        case .title3: return 20
        case .headline: return 18
        case .body: return 16
        case .callout: return 15
        case .subheadline: return 14
        case .footnote: return 13
        case .caption: return 12
        case .caption2: return 11
        @unknown default: return 8
        }
    }
}


enum CustomFont: String{
    case regular = "Geist-Regular"
    case medium = "Geist-Medium"
    case semibold = "Geist-SemiBold"
    case bold = "Geist-Bold"
    case black = "Geist-Black"
    
    init(weight: Font.Weight){
        switch weight{
        case .regular:
            self = .regular
        case .medium:
            self = .medium
        case .semibold:
            self = .semibold
        case .bold:
            self = .bold
        case .black:
            self = .black
        default:
            self = .regular
        }
        
    }
}

enum PretendardFont: String {
    case regular = "Pretendard-Regular"
    case medium = "Pretendard-Medium"
    case semibold = "Pretendard-SemiBold"
    case bold = "Pretendard-Bold"
    case black = "Pretendard-Black"
    
    init(weight: Font.Weight){
        switch weight{
        case .regular:
            self = .regular
        case .medium:
            self = .medium
        case .semibold:
            self = .semibold
        case .bold:
            self = .bold
        case .black:
            self = .black
        default:
            self = .regular
        }
        
    }
}

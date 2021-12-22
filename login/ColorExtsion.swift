//
//  ColorExtsion.swift
//  login
//
//  Created by Binay Kumar Sharma on 22/12/21.
//

import SwiftUI



extension Color {
    
    static let theme = ColorTheme()
    
    
}
struct ColorTheme {
    let primary = Color("primary")
    let primary200 = Color("primary200")
    let background = Color("background")
    let border = Color("border")
    let textPrimary = Color("textPrimary")
    let textFooter = Color("textFooter")
    let inputIcon = Color("inputIcon")
    let inputText = Color("inputText")
    let inputFloat = Color("inputFloat")
}

struct CustomFont{
    static let InterMedium500 = "Inter-Medium"
    static let InterSemiBold600 = "Inter-SemiBold"
    static let InterRegular = "Inter-Regular"
    static let InterThin = "Inter-Thin"
    struct Size{
        static let size20 = 20.0
        static let size17 = 17.0
        static let size15 = 15.0
        static let size12 = 12.0
    }
}

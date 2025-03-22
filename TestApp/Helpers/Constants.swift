//
//  Constants.swift
//  TestApp
//
//  Created by Ivona Ilic on 3/22/25.
//

import SwiftUI

enum Constants {
    enum Strings {
        static let appTitle = "Test App"
        static let userName = "octocat"
    }
    
    enum Images {
        static let folderIcon = "folder"
        static let appIcon = "AppIcon"
    }
    
    enum Layout {
        static let padding: CGFloat = 16
        static let rowPadding: CGFloat = 2
        static let listSpacing: CGFloat = 3
        static let folderWidth: CGFloat = 40
        static let tagsPadding: CGFloat = 30
        static let imageSize: CGFloat = 140
        static let placeholderOpacity: CGFloat = 0.3
    }
    
    enum Colors {
        static let accent = Color("AccentColor")
        static let background = Color("BackgroundColor")
    }
}

//
//  AppConfig.swift
//  TestApp
//
//  Created by Ivona Ilic on 3/21/25.
//

import SwiftUI

extension Bundle {
    
    // MARK: - Properties
    
    class var config: NSDictionary {
        return Bundle.main.object(forInfoDictionaryKey: "Config") as! NSDictionary
    }
    
    @objc class var baseURL: String {
        guard let baseURL = config["BaseURL"] as? String else {
            return ""
        }
        return baseURL
    }
}

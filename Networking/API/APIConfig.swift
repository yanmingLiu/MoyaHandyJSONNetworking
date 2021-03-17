//
//  APIConfig.swift
//  Networking
//
//  Created by lym on 2021/3/16.
//

import Foundation
import HandyJSON
import Moya

struct APIConfig {
    static let environment: AppEnvironment = .test

    static let apiLogEnable: Bool = true

    enum AppEnvironment {
        case dev
        case test
        case product
        case appStore
    }
    
    static var headers: [String: String]? {
        let uuid = UIDevice.current.identifierForVendor?.uuidString ?? ""
        return ["content-type": "application/json",
                "accept": "application/json,text/plain",
                "deviceId": uuid]
    }
    
    static var host: String {
        switch environment {
        case .dev:
            return "http://dev-ewow.ewow.epal.cloud"

        case .test:
            return "https://test-ewow-ewow.gamesegirl.com"

        case .product, .appStore:
            return "http://dev-ewow.ewow.epal.cloud"
        }
    }
}

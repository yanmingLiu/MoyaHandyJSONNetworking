//
//  ExampleAPI.swift
//  Networking
//
//  Created by lym on 2022/10/31.
//

import Foundation
import Moya

// https://ditu.amap.com/service/regeo?longitude=121.04925573429551&latitude=31.315590522490712

let ExampleProvider = MoyaProvider<ExampleAPI>(requestClosure: myRequestClosure, plugins:myPlugins)

enum ExampleAPI {
    case jsonOnline(long: Double, lat: Double)
}

extension ExampleAPI: TargetType {
    var baseURL: URL {
        switch self {
        case let .jsonOnline(long, lat):
            return URL(string: "https://ditu.amap.com" + "?longitude=\(long)&latitude=\(lat))")!
        }
    }

    var path: String {
        switch self {
        case .jsonOnline:
            return "/service/regeo"
        }
    }

    var method: Moya.Method {
        .get
    }

    var task: Task {
        .requestPlain
    }

    var headers: [String: String]? {
        nil
    }
}

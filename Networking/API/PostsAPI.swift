//
//  TopicAPI.swift
//  Networking
//
//  Created by lym on 2021/1/18.
//

import Foundation
import Moya

let PostsProvider = MoyaProvider<PostsAPI>(requestClosure: myRequestClosure)

enum PostsAPI {
    case recommendList(size: Int)
}

extension PostsAPI: TargetType {
    var baseURL: URL {
        URL(string: APIConfig.host)!
    }

    var path: String {
        switch self {
        case .recommendList:
            return "/topic/recommendList"
        }
    }

    var method: Moya.Method {
        .post
    }

    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }

    var task: Task {
        var params = [String: Any]()

        switch self {

        case .recommendList(size: let size):
            params = ["size": size]
        }
        
        return .requestParameters(parameters: params, encoding: JSONEncoding.default)
    }

    var headers: [String: String]? {
        return APIConfig.headers
    }
}

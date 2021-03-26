//
//  APIProvider.swift
//  Networking
//
//  Created by lym on 2021/3/16.
//

import Foundation
import HandyJSON
import Moya

let myEndpointClosure = { (target: TargetType) -> Endpoint in
    let url = target.baseURL.absoluteString + target.path
    var task = target.task

    var endpoint = Endpoint(
        url: url,
        sampleResponseClosure: { .networkResponse(200, target.sampleData) },
        method: target.method,
        task: task,
        httpHeaderFields: target.headers
    )
    return endpoint
}

let myRequestClosure = { (endpoint: Endpoint, done: MoyaProvider.RequestResultClosure) in
    do {
        var request = try endpoint.urlRequest()
        request.timeoutInterval = 30
        done(.success(request))
    } catch {
        done(.failure(MoyaError.underlying(error, nil)))
    }
}

let myNetworkPlugin = NetworkActivityPlugin.init { changeType, _ in
    switch changeType {
    case .began: print("开始请求网络")
    case .ended: print("结束请求网络")
    }
}

extension MoyaProvider {
     public typealias Completion = (_ result: Result<Moya.Response, MoyaError>) -> Void

    @discardableResult
    open func request<T: HandyJSON>(_ target: Target,
                                    progress: ProgressBlock? = .none,
                                    modelType: T.Type,
                                    completion: @escaping (Result<T?, ResponseError>) -> Void) -> Cancellable {
        return request(target, completion: { result in
            if APIConfig.apiLogEnable {
                dlog("🗣\(target.method)\nheaders: \(target.headers ?? ["": ""])\npath: \(target.path)")
            }

            switch result {
            case let .success(response):
                do {
                    let jsonObject = try JSONSerialization.jsonObject(with: response.data)
                    let jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
                    let jsonString = String(data: jsonData, encoding: .utf8) ?? String(data: response.data, encoding: .utf8) ?? ""
                    
                    if APIConfig.apiLogEnable {
                        dlog("👉 response:\n\(jsonString)")
                    }

                    let data = ResponseData<T>.deserialize(from: jsonString)
                    let status = data?.status
                    let code = data?.errorCode ?? 0
                    let msg = data?.errorMsg

                    if (status ?? "") == "OK" {
                        let model = data?.content
                        completion(.success(model))
                    } else {
                        if code == 501 {
                            dlog("未登录")
                        }
                        dlog("erro: code = \(code), msg = \(data?.errorMsg ?? "业务状态失败")")
                        completion(.failure(.serviceError(code: code, msg: msg)))
                    }
                } catch {
                    dlog("解析失败")
                    completion(.failure(.deserializeError))
                }
            case let .failure(error):
                dlog("⛔️ \(target.path) 网络连接失败\(error)")
                completion(.failure(.networkError))
            }
        })
    }
}

/// 打印
func dlog<T>(_ message: T, file: StaticString = #file, method: String = #function, line: Int = #line) {
    #if DEBUG
        let fileName = (file.description as NSString).lastPathComponent
        print("\n\(fileName) \(method)[\(line)]:\n\(message)\n")
    #endif
}

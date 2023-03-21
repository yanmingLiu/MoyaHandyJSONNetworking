//
//  APIProvider.swift
//  Networking
//
//  Created by lym on 2021/3/16.
//

import Foundation
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
        // 加密
        /*
         if isEncryption {
         let body = request.httpBody ?? Data()
         let str = String(data:body, encoding: .utf8)
         if APIConfig.apiLogEnable {
         dLog("⚠️ request加密前参数：\(str ?? "")")
         }
         let key = "xxxx".md5().uppercased()
         let aes = try AES(key: key, iv: "xxxxx")
         let encrypted = try aes.encrypt(str!.bytes)
         let result = encrypted.toBase64()
         if APIConfig.apiLogEnable {
         dLog("⚠️ request加密结果：\(result)")
         }
         let dic = ["key": result]
         let httpBody = try JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted)
         request.httpBody = httpBody
         }
         */
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

let myPlugins: [PluginType] = [myNetworkPlugin]

extension MoyaProvider {
    @discardableResult
    public func request<T: Codable>(_ target: Target,
                                  progress _: ProgressBlock? = .none,
                                  modelType _: T.Type,
                                  completion: @escaping (Result<T?, ResponseError>) -> Void) -> Cancellable
    {
        return request(target, completion: { result in
            if APIConfig.apiLogEnable {
                dLog("🗣\(target.method)\n headers: \(target.headers ?? ["": ""])\n path: \(target.path)\n params:\(target.task)")
            }

            switch result {
            case let .success(response):
                do {
                    let jsonObject = try JSONSerialization.jsonObject(with: response.data)
                    let jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
                    let jsonString = String(data: jsonData, encoding: .utf8) ?? String(data: response.data, encoding: .utf8) ?? ""

                    if APIConfig.apiLogEnable {
                        dLog("👉 response:\n\(jsonString)")
                    }
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let data = try decoder.decode(ResponseData<T>.self, from: response.data)
                    let status = data.status
                    if status == 1 {
                        let model = data.data
                        completion(.success(model))
                    } else {
                        if status == 501 {
                            dLog("未登录")
                        }
                        dLog("erro: code = \(status), msg = \(data.errorMsg ?? "业务状态失败")")
                        completion(.failure(.serviceError(code: status, msg: data.errorMsg)))
                    }
                } catch {
                    dLog("解析失败:\(error)")
                    completion(.failure(.deserializeError))
                }

            case let .failure(error):
                dLog("⛔️ \(target.baseURL.absoluteString + target.path) 网络连接失败\(error)")
                completion(.failure(.networkError))
            }
        })
    }
}

/// 打印
func dLog<T>(_ message: T, file: StaticString = #file, method: String = #function, line: Int = #line) {
    #if DEBUG
        let fileName = (file.description as NSString).lastPathComponent
        print("\n\(fileName) \(method)[\(line)]:\n\(message)\n")
    #endif
}

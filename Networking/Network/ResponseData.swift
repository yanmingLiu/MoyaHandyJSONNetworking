//
//  ResponseData.swift
//  Networking
//
//  Created by lym on 2021/1/3.
//

import BetterCodable
import Foundation

public enum ResponseError: Error {
    case serviceError(code: Int, msg: String?)
    case deserializeError
    case networkError
}

struct ResponseData<T: Codable>: Codable {
    var errorMsg: String?
    @LosslessValue var status: Int
    var data: T?
}

struct ResponsePageData<T: Codable>: Codable {
    var datas: [T]?
    var tc: Int?
    var pn: Int?
    var ps: Int?
    var sortType: String?
}

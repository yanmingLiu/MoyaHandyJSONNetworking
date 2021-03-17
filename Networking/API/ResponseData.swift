//
//  ResponseData.swift
//  Networking
//
//  Created by lym on 2021/1/3.
//

import Foundation
import HandyJSON

struct ResponseData<T: HandyJSON>: HandyJSON {
    var errorMsg: String?
    var errorCode: Int?
    var status: String!
    var content: T?
}

struct ResponsePageData<T: HandyJSON>: HandyJSON {
    var datas: [T]?
    var tc: Int?
    var pn: Int?
    var ps: Int?
    var sortType: String?
}

extension Array: HandyJSON {}

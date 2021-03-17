//
//  Posts.swift
//  Networking
//
//  Created by lym on 2021/1/18.
//

import Foundation
import HandyJSON

public enum PostsType: String, HandyJSONEnum {
    case SHOW
    case QA
}

struct Posts: HandyJSON {
    var comments: [Comment]?
    var content: String?
    var gameName: String?
    var headImg: String?
    var id: Int!
    var nickname: String?
    var oneLabelName: String?
    var pictures: [Picture]?
    var publishTime: Int?
    var secondLabelName: String?
    var title: String?
    var userId: Int?
    var wow: Bool = false
    var wowCount: Int! = 0
    var favorite: Bool!
    var favoriteCount: Int! = 0
    var followed: Bool!
    var totalComments: Int?
    var publish: Bool = false
    var firstPublish: Bool?
    var browseCount: Int! = 0
    var deviceName: String?
    var isDelete: Bool = false

}

struct Picture: HandyJSON {
    var width: CGFloat! = 0
    var height: CGFloat! = 0
    var url: String! = ""
}

//
//  Comment.swift
//  Networking
//
//  Created by lym on 2021/1/18.
//

import Foundation
import HandyJSON

struct Comment: HandyJSON {
    var content: String?
    var createTime: Int?
    var headImg: String?
    var id: Int?
    var nickname: String?
    var replyList: [CommentReply]?
    var topicId: Int?
    var userId: Int?
    var wow: Bool = false
    var wowCount: Int = 0
    var pictures: [Picture]?
    var authorWow: Bool? = false
    var topicAuthorId: Int?
    var totalReplys: Int = 0
}

struct CommentReply: HandyJSON {
    var atUserHeadImg: String?
    var atUserId: Int?
    var atUserNickname: String?
    var commentId: Int?
    var content: String?
    var createTime: Int?
    var replyId: Int?
    var topicId: Int?
    var userHeadImg: String?
    var userId: Int?
    var userNickname: String?
    var wow: Bool = false
    var wowCount: Int = 0
    var pictures: [Picture]?
    var topicAuthorId: Int?
    var authorWow: Bool? = false
}

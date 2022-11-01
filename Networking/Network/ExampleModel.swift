//
//  ExampleModel.swift
//  Networking
//
//  Created by lym on 2022/10/31.
//

import Foundation

// MARK: - DataClass
struct ExampleModel: Codable {
    var code: String?
    var message: String?
    var result: String?
    var timestamp: String?
    var version: String?
    var country: String?
    var countrycode: String?
    var province: String?
    var provinceadcode: String?
    var city: String?
    var cityadcode: String?
    var tel: String?
    var areacode: String?
    var district: String?
    var districtadcode: String?
    var adcode: String?
    var desc: String?
    var poiList: [PoiList]?
    var roadList: [List]?
    var crossList: [List]?
    var hn: String?
    var seaArea: SeaArea?
    var pos: String?
}

// MARK: - List
struct List: Codable {
    var crossid: String?
    var direction: String?
    var distance: String?
    var latitude: String?
    var level: String?
    var longitude: String?
    var name: String?
    var weight: String?
    var width: String?
    var roadid: String?
}

// MARK: - PoiList
struct PoiList: Codable {
    var address: String?
    var childtype: String?
    var direction: String?
    var distance: String?
    var endPoiExtension: String?
    var entrances: [Entrance]?
    var latitude: String?
    var longitude: String?
    var name: String?
    var poiid: String?
    var tel: String?
    var towardsAngle: String?
    var type: String?
    var typecode: String?
    var weight: String?
}

// MARK: - Entrance
struct Entrance: Codable {
    var latitude: String?
    var longitude: String?
}

// MARK: - SeaArea
struct SeaArea: Codable {
    var adcode: String?
    var name: String?
}

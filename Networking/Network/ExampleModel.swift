//
//  ExampleModel.swift
//  Networking
//
//  Created by lym on 2022/10/31.
//

import BetterCodable
import Foundation

// MARK: - DataClass

struct ExampleModel: Codable {
    @LosslessValue var code: String
    @LosslessValue var message: String
    @DefaultFalse var result: Bool
    @LosslessValue var timestamp: String
    @LosslessValue var version: String
    @LosslessValue var country: String
    @LosslessValue var countrycode: String
    @LosslessValue var province: String
    @LosslessValue var provinceadcode: String
    @LosslessValue var city: String
    @LosslessValue var cityadcode: String
    @LosslessValue var tel: String
    @LosslessValue var areacode: String
    @LosslessValue var district: String
    @LosslessValue var districtadcode: String
    @LosslessValue var adcode: String
    @LosslessValue var desc: String
    @DefaultEmptyArray var poiList: [PoiList]
    @DefaultEmptyArray var roadList: [List]
    @DefaultEmptyArray var crossList: [List]
    @LosslessValue var hn: String
    @DefaultCodable<SeaArea> var seaArea: SeaArea
    @LosslessValue var pos: String
}

// MARK: - List

struct List: Codable {
    @LosslessValue var crossid: String
    @LosslessValue var direction: String
    @LosslessValue var distance: String
    @LosslessValue var latitude: String
    @LosslessValue var level: String
    @LosslessValue var longitude: String
    @LosslessValue var name: String
    @LosslessValue var weight: String
    @LosslessValue var width: String
    @LosslessValue var roadid: String
}

// MARK: - PoiList

struct PoiList: Codable {
    @LosslessValue var address: String
    @LosslessValue var childtype: String
    @LosslessValue var direction: String
    @LosslessValue var distance: String
    @LosslessValue var endPoiExtension: String
    @DefaultEmptyArray var entrances: [Entrance]
    @LosslessValue var latitude: String
    @LosslessValue var longitude: String
    @LosslessValue var name: String
    @LosslessValue var poiid: String
    @LosslessValue var tel: String
    @LosslessValue var towardsAngle: String
    @LosslessValue var type: String
    @LosslessValue var typecode: String
    @LosslessValue var weight: String
}

// MARK: - Entrance

struct Entrance: Codable {
    @LosslessValue var latitude: String
    @LosslessValue var longitude: String
}

// MARK: - SeaArea

struct SeaArea: Codable, DefaultCodableStrategy {
    static var defaultValue: SeaArea { return SeaArea(adcode: "", name: "") }

    @LosslessValue var adcode: String
    @LosslessValue var name: String
}

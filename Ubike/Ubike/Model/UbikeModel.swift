//
//  UbikeModel.swift
//  Ubike
//
//  Created by kidnapper on 2019/11/24.
//  Copyright © 2019 kidnapper. All rights reserved.
//

import Foundation
import CoreLocation

struct UbikeModel: Codable {
    let retCode: Int
    let stationDataDic: [String: StationData]
    
    private enum CodingKeys: String, CodingKey {
        case retCode
        case stationDataDic = "retVal"
    }
}

struct StationData: Codable {
    let stationId: String
    let stationName: String
    let englishStationName: String
    let totalSpot: Int
    let bikeAvailable: Int
    let spotAvailable: Int
    let areaName: District
    let englishAreaName: EnglishDistrict
    let updateTime: Date
    let address: String
    let englishAdress: String
    let active: Bool
    let location: CLLocation
    
    private enum CodingKeys: String, CodingKey {
        case stationId = "sno"
        case stationName = "sna"
        case englishStationName = "snaen"
        case totalSpot = "tot"
        case bikeAvailable = "sbi"
        case spotAvailable = "bemp"
        case areaName = "sarea"
        case englishAreaName = "sareaen"
        case updateTime = "mday"
        case address = "ar"
        case englishAdress = "aren"
        case active = "act"
        case lat, lng
    }
    
    init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer = try decoder.container(keyedBy: CodingKeys.self)
        self.stationId = try container.decode(String.self, forKey: .stationId)
        self.stationName = try container.decode(String.self, forKey: .stationName)
        self.englishStationName = try container.decode(String.self, forKey: .englishStationName)
        self.totalSpot = try container.decodeToInt(forKey: .totalSpot)
        self.bikeAvailable = try container.decodeToInt(forKey: .bikeAvailable)
        self.spotAvailable = try container.decodeToInt(forKey: .spotAvailable)
        self.areaName = try container.decode(District.self, forKey: .areaName)
        self.englishAreaName = try container.decode(EnglishDistrict.self, forKey: .englishAreaName)
        self.updateTime = try container.decodeToDate(forKey: .updateTime)
        self.address = try container.decode(String.self, forKey: .address)
        self.englishAdress = try container.decode(String.self, forKey: .englishAdress)
        self.active = try container.decodeToBool(forKey: .active)
        self.location = try container.decodeToLocation(latKey: .lat, logKey: .lng)
    }
    
    func encode(to encoder: Encoder) throws {
        fatalError("not implement yet.")
    }
    
}

enum District: String, Codable {
    case 中山區, 中正區, 信義區, 內湖區, 北投區, 南港區, 士林區, 大同區, 大安區, 文山區, 松山區, 萬華區
}

enum EnglishDistrict: String, Codable {
    case beitouDist = "Beitou Dist."
    case daanDist = "Daan Dist."
    case datongDist = "Datong Dist."
    case nangangDist = "Nangang Dist."
    case neihuDist = "Neihu Dist."
    case shilinDist = "Shilin Dist."
    case songshanDist = "Songshan Dist."
    case wanhuaDist = "Wanhua Dist."
    case wenshanDist = "Wenshan Dist."
    case xinyiDist = "Xinyi Dist."
    case zhongshanDist = "Zhongshan Dist."
    case zhongzhengDist = "Zhongzheng Dist."
}

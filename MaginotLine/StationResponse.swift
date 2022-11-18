//
//  StationResponse.swift
//  MaginotLine
//
//  Created by Eunchan Kim on 2022/11/18.
//

import Foundation
struct StationRespose: Decodable {
    private let searchInfo: SearchInfoBySubwayNameService

    //간단하게 쓸 수 있도록 연산프로퍼티 사용
    var stations: [Station] {searchInfo.row}

    enum CodingKeys: String, CodingKey {
        case searchInfo = "SearchInfoBySubwayNameService"
    }

}

struct SearchInfoBySubwayNameService: Decodable{
    var row: [Station] = []
}

struct Station: Decodable {
    let stationName:String
    let lineNumber:String
    
    enum CodingKeys: String, CodingKey{
        case stationName = "STATION_NM"
        case lineNumber = "LINE_NUM"
        
    }
}

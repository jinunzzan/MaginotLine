//
//  StationResponse.swift
//  MaginotLine
//
//  Created by Eunchan Kim on 2022/11/18.
//

import Foundation

struct Time:Codable{
    var line_num: String //호선!
    var fr_code: String//외부코드!
    var station_cd: String //전철역코드!
    var station_nm: String//전철역명!
    var train_no: String//열차번호
    var arriveTime: String//도착시간
    var leftTime: String//출발시간
    var originStation: String //출발지하철역코드
    var destStation: String //도착지하철역코드
    var subwaySName: String//출발지하철역명
    var subwayEName: String//도착지하철역명
    var week_tag: String//요일
    var inout_tag: String//상/하행선
    var fl_flag: String//플러그
    var destStation2: String//도착역 코드2
    var express_yn: String//급행선
    var branch_line: String //지선
    
    enum CodingKeys: String, CodingKey {
        case line_num = "LINE_NUM"
        case fr_code = "FR_CODE"
        case station_cd = "STATION_CD"
        case station_nm = "STATION_NM"
        case train_no = "TRAIN_NO"
        case arriveTime = "ARRIVETIME"
        case leftTime = "LEFTTIME"
        case originStation = "ORIGINSTATION"
        case destStation = "DESTSTATION"
        case subwaySName = "SUBWAYSNAME"
        case subwayEName = "SUBWAYENAME"
        case week_tag = "WEEK_TAG"
        case inout_tag = "INOUT_TAG"
        case fl_flag = "FL_FLAG"
        case destStation2 = "DESTSTATION2"
        case express_yn = "EXPRESS_YN"
        case branch_line = "BRANCH_LINE"
    }
}

struct TimeTable: Codable {
    var row: [Time]
}

struct TimeResult: Codable {
    var SearchSTNTimeTableByIDService: TimeTable
}

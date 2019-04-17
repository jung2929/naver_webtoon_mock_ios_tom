//
//  ComicDay.swift
//  MyNaverWebtoon3
//
//  Created by penta on 17/04/2019.
//  Copyright © 2019 TestOrganization. All rights reserved.
//

import UIKit
import ObjectMapper

class ComicContents: Mappable {
    var contentNo:Int?
    var comicNo:Int?
    var contentImg:String?
    var contentName:String?
    var contentContent:String?
    var contentDate:String?
    var contentHeart:Int?
    var contentType:Int?
    var contentRating:Int?
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        contentNo <- map["Content_No"]
        comicNo <- map["Comic_No"]
        contentImg <- map["Content_Img"]
        contentName <- map["Content_Name"]
        contentContent <- map["Content_Content"]
        contentDate <- map["Content_Date"]
        contentHeart <- map["Content_Heart"]
        contentType <- map["Content_Type"]
        contentRating <- map["Content_Rating"]
    }
}
/*
 {
 "Content_No": 6,
 "Comic_No": 2,
 "Content_Img": "",
 "Content_Name": "소녀의 세계 1화",
 "Content_Content": "소녀들의 이야기 1화를 시작합니다.",
 "Content_Date": "2019-03-25 13:46:50",
 "Content_Heart": 1,
 "Content_Type": 0,
 "Content_Rating": 10
 }
 */

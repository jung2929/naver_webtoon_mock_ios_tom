//
//  ComicContentFirstDTO.swift
//  MyNaverWebtoon3
//
//  Created by penta on 23/04/2019.
//  Copyright © 2019 TestOrganization. All rights reserved.
//

import UIKit
import ObjectMapper

class ComicContentFirstDTO: BaseDTO {
    var resultComicContentFirst = [ComicContentFirst]()
    class ComicContentFirst: Mappable {
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
    override func mapping(map: Map) {
        resultComicContentFirst <- map["list"]
    }
}
/*
"list": {
    "Content_No": 1,
    "Comic_No": 1,
    "Content_Img": "/var/www/html/img/신의탑/신의탑1썸네일.JPG",
    "Content_Name": "신의탑 1화",
    "Content_Content": "/var/www/html/img/신의탑/신의탑1내용.JPG",
    "Content_Date": "2019-03-25 13:46:48",
    "Content_Heart": 1,
    "Content_Type": 0,
    "Content_Rating": 10
}
*/

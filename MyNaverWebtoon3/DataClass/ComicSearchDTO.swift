//
//  ComicContentsDTO.swift
//  MyNaverWebtoon3
//
//  Created by penta on 07/04/2019.
//  Copyright © 2019 TestOrganization. All rights reserved.
//

import UIKit
import ObjectMapper

class ComicSearchDTO: BaseDTO {
    var resultComicSearch = [ComicSearch]()
    class ComicSearch: Mappable {
        var comicNo:Int?
        var comicName:String?
        var comicStory:String?
        var comicPainting:String?
        var comicImg:String?
        var comicText:String?
        var comicDay:String?
        var comicHeart:Int?
        var comicRating:Int?
        var comicDate:String?
        required init?(map: Map){
            
        }
        func mapping(map: Map) {
            comicNo <- map["Comic_No"]
            comicName <- map["Comic_Name"]
            comicStory <- map["Comic_Story"]
            comicPainting <- map["Comic_Painting"]
            comicImg <- map["Comic_Img"]
            comicText <- map["Comic_Text"]
            comicDay <- map["Comic_Day"]
            comicHeart <- map["Comic_Heart"]
            comicRating <- map["Comic_Rating"]
            comicDate <- map["Comic_Date"]
        }
    }
    override func mapping(map: Map) {
        resultComicSearch <- map["data"]
    }
}

/*
"data": [
{
"Comic_No": 2,
"Comic_Name": "소녀의 세계",
"Comic_Story": "모랑지",
"Comic_Painting": null,
"Comic_Img": "/var/www/html/img/소녀의세계/소녀의세계메인.JPG",
"Comic_Text": "소녀들의 이야기",
"Comic_Day": "Monday",
"Comic_Heart": 1,
"Comic_Rating": 9.1666666666667,
"Comic_Date": "2019-03-31 11:09:14"
},
*/

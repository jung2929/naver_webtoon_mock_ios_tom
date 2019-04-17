//
//  ComicDay.swift
//  MyNaverWebtoon3
//
//  Created by penta on 17/04/2019.
//  Copyright © 2019 TestOrganization. All rights reserved.
//

import UIKit
import ObjectMapper

class ComicDay: Mappable {
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

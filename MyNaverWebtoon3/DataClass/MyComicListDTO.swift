//
//  MyComicListDTO.swift
//  MyNaverWebtoon3
//
//  Created by penta on 11/04/2019.
//  Copyright © 2019 TestOrganization. All rights reserved.
//

import UIKit
import ObjectMapper

class MyComicListDTO: BaseDTO {

    var list = [myComic]()
    var data = [userData]()
    class myComic: Mappable {
        var userNo:Int?
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
            userNo <- map["User_No"]
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
    class userData: Mappable{
        var date:String?
        var userId:String?
        var userPw:String?
        var userType:Int?
        required init?(map: Map){
            
        }
        func mapping(map: Map) {
            date <- map["date"]
            userId <- map["userId"]
            userPw <- map["userPw"]
            userType <- map["userType"]
        }
    }
    
    override func mapping(map: Map) {
        list <- map["list"]
        data <- map["date"]
    }
}
/*
 "date": "2019-04-12 01:21:34",
 "userId": "tom1",
 "userPw": "Tom1234.",
 "userType": 1
 
 "User_No": 24,
 "Comic_No": 1,
 "Comic_Name": "신의탑 ",
 "Comic_Story": "SIU",
 "Comic_Painting": null,
 "Comic_Img": null,
 "Comic_Text": "탑을오르는 비선별인원",
 "Comic_Day": "Monday",
 "Comic_Heart": 3,
 "Comic_Rating": 6.4,
 "Comic_Date": "2019-03-31 11:09:14"
 */

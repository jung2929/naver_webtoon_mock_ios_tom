//
//  ComicContentsDTO.swift
//  MyNaverWebtoon3
//
//  Created by penta on 07/04/2019.
//  Copyright © 2019 TestOrganization. All rights reserved.
//

import UIKit
import ObjectMapper

class ComicContentsDTO: Mappable {
    var code : Int?
    var message : String?
    var resultComicDay = [[ String : AnyObject ]]()
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        code <- map["code"]
        message <- map["message"]
        resultComicDay <- map["result"]
    }
    //    class Result :Mappable{
    //        var comic_No : Int?
    //        var comic_Name : String?
    //        var comic_Story : String?
    //        var comic_Painting : String?
    //        var comic_Img : String?
    //        var comic_Text : String?
    //        var comic_Day : String?
    //        var comic_Heart : Int?
    //        var comic_Rating : Int?
    //        required init?(map: Map) {
    //        }
    //        func mapping(map: Map) {
    //            comic_No <- map["Comic_No"]
    //            comic_Name <- map["Comic_Name"]
    //            comic_Story <- map["Comic_Story"]
    //            comic_Painting <- map["Comic_Painting"]
    //            comic_Img <- map["Comic_Img"]
    //            comic_Text <- map["Comic_Text"]
    //            comic_Day <- map["Comic_Day"]
    //            comic_Heart <- map["Comic_Heart"]
    //            comic_Rating <- map["Comic_Rating"]
    //        }
    //    }
    
}

/*
{
    "result": [
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
    },
    {
    "Content_No": 7,
    "Comic_No": 2,
    "Content_Img": "",
    "Content_Name": "소녀의 세계 2화",
    "Content_Content": "소녀들의 전후 사정",
    "Content_Date": "2019-03-25 13:46:50",
    "Content_Heart": 0,
    "Content_Type": 0,
    "Content_Rating": 10
    }]
 }
*/

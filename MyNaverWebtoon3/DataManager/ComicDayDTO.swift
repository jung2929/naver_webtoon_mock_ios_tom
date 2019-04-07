//
//  comicDayDTO.swift
//  MyNaverWebtoon3
//
//  Created by penta on 05/04/2019.
//  Copyright © 2019 TestOrganization. All rights reserved.
//

import UIKit
import ObjectMapper

class ComicDayDTO: Mappable {
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
 "Comic_No": 1,
 "Comic_Name": "신의탑 ",
 "Comic_Story": "SIU",
 "Comic_Painting": null,
 "Comic_Img": null,
 "Comic_Text": "탑을오르는 비선별인원",
 "Comic_Day": "Monday",
 "Comic_Heart": 1,
 "Comic_Rating": 7.4
 },
 {
 "Comic_No": 2,
 "Comic_Name": "소녀의 세계",
 "Comic_Story": "모랑지",
 "Comic_Painting": null,
 "Comic_Img": null,
 "Comic_Text": "소녀들의 이야기",
 "Comic_Day": "Monday",
 "Comic_Heart": 0,
 "Comic_Rating": 10
 }
 ],
 "code": 100,
 "message": "테스트 성공"
 }
 */

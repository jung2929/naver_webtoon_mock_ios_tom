//
//  ComicDay.swift
//  MyNaverWebtoon3
//
//  Created by penta on 17/04/2019.
//  Copyright © 2019 TestOrganization. All rights reserved.
//

import UIKit
import ObjectMapper

class Comments: Mappable {
    var userId:String?
    var commentNo:Int?
    var commentContent:String?
    var commentLike:Int?
    var commentDislike:Int?
    var commentDate:String?
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        userId <- map["User_Id"]
        commentNo <- map["Comment_No"]
        commentContent <- map["Comment_Content"]
        commentLike <- map["Comment_Like"]
        commentDislike <- map["Comment_DisLike"]
        commentDate <- map["Comment_Date"]
    }
}
/*
 "{
 ""data"": [
 {
 ""User_Id"": ""yha"",
 ""Comment_No"": 6,
 ""Comment_Content"": ""20sfasfasfSFSAFSD1니다."",
 ""Comment_Like"": 0,
 ""Comment_DisLike"": 0,
 ""Comment_Date"": ""2019-04-01 06:09:27""
 },
 {
 ""User_Id"": ""yha"",
 ""Comment_No"": 5,
 ""Comment_Content"": ""20sfasfasfSFSAFSD1니다."",
 ""Comment_Like"": 0,
 ""Comment_DisLike"": 0,
 ""Comment_Date"": ""2019-04-01 06:08:42""
 }
 ],
 ""code"": 100,
 ""message"": ""테스트 성공""
 }"
 
 
 
 */

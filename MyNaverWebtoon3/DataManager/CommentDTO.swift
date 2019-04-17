//
//  AllCommentDTO.swift
//  MyNaverWebtoon3
//
//  Created by penta on 12/04/2019.
//  Copyright © 2019 TestOrganization. All rights reserved.
//

import UIKit
import ObjectMapper

class CommentDTO: Mappable {
    var data = [Comments]()
    var code : Int?
    var message : String?
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        data <- map["data"]
        code <- map["code"]
        message <- map["message"]
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

//
//  userDTO.swift
//  MyNaverWebtoon3
//
//  Created by penta on 09/04/2019.
//  Copyright © 2019 TestOrganization. All rights reserved.
//

import UIKit
import ObjectMapper

class userDTO: Mappable {
    var id : String?
    var code : Int?
    var message : String?
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        id <- map["id"]
        code <- map["code"]
        message <- map["message"]
    }
}
/*
"id": "theis1",
"code": 100,
"message": "아이디 생성됨"
*/

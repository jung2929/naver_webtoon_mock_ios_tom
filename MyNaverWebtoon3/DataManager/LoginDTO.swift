//
//  LoginDTO.swift
//  MyNaverWebtoon3
//
//  Created by penta on 10/04/2019.
//  Copyright © 2019 TestOrganization. All rights reserved.
//

import UIKit
import ObjectMapper

class LoginDTO: Mappable {
    var result : String?
    var code : Int?
    var message : String?
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        result <- map["id"]
        code <- map["code"]
        message <- map["message"]
    }
}

//
//  LoginDTO.swift
//  MyNaverWebtoon3
//
//  Created by penta on 10/04/2019.
//  Copyright © 2019 TestOrganization. All rights reserved.
//

import UIKit
import ObjectMapper

class LoginDTO: BaseDTO {
    var result:[String:String]=[:]
    override func mapping(map: Map) {
        code <- map["code"]
        message <- map["message"]
        result <- map["result"]
    }
}

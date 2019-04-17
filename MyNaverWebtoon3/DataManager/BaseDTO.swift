//
//  BaseDTO.swift
//  MyNaverWebtoon3
//
//  Created by penta on 13/04/2019.
//  Copyright © 2019 TestOrganization. All rights reserved.
//

import Foundation
import ObjectMapper

class BaseDTO: Mappable {
    var data = [[ String : AnyObject ]]()
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

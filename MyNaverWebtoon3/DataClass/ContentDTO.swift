//
//  ContentDTO.swift
//  MyNaverWebtoon3
//
//  Created by penta on 25/04/2019.
//  Copyright © 2019 TestOrganization. All rights reserved.
//

import UIKit
import ObjectMapper

class ContentDTO: BaseDTO {
    var result = [Contents]()
    var check:Int?
    class Contents: Mappable {
        var contentContent:Int?
        required init?(map: Map){
            
        }
        func mapping(map: Map) {
            contentContent <- map["Content_Content"]
        }
    }
    override func mapping(map: Map) {
        result <- map["result"]
        code <- map["code"]
        message <- map["message"]
        check <- map["check"]
    }
}

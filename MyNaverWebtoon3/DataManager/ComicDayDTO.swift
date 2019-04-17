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
    var result = [ComicDay]()
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        code <- map["code"]
        message <- map["message"]
        result <- map["result"]
    }
}

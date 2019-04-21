

import UIKit
import ObjectMapper

class BaseDTO: Mappable {
    var code : Int?
    var message : String?
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        code <- map["code"]
        message <- map["message"]
    }
}

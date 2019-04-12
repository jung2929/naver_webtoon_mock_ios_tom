

import UIKit
import ObjectMapper

class SimpleResponseDTO: Mappable {
    var code : Int?
    var message : String?
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        code <- map["code"]
        message <- map["message"]
    }
}

//
//  MyComicListDTO.swift
//  MyNaverWebtoon3
//
//  Created by penta on 11/04/2019.
//  Copyright © 2019 TestOrganization. All rights reserved.
//

import UIKit
import ObjectMapper

class MyComicListDTO: Mappable {
    var data = [ String : AnyObject ]()
    var code : Int?
    var list = [[ String : AnyObject ]]()
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        data <- map["data"]
        code <- map["code"]
        list <- map["list"]
    }
}
/*
 {
 "data": {
 "date": "2019-03-27 20:03:17",
 "userId": "roy",
 "userPw": 1234,
 "userType": ""
 },
 "code": 100,
 "list": [
 {
 "User_No": 4,
 "Comic_No": 6,
 "Comic_Name": "복학왕",
 "Comic_Story": "기안84",
 "Comic_Painting": null,
 "Comic_Img": null,
 "Comic_Text": "우기명의 복학왕",
 "Comic_Day": "Wednesday",
 "Comic_Heart": 0,
 "Comic_Rating": 0
 },
 {
 "User_No": 4,
 "Comic_No": 1,
 "Comic_Name": "신의탑 ",
 "Comic_Story": "SIU",
 "Comic_Painting": null,
 "Comic_Img": null,
 "Comic_Text": "탑을오르는 비선별인원",
 "Comic_Day": "Monday",
 "Comic_Heart": 1,
 "Comic_Rating": 7.4
 }
 ]
 }
 */

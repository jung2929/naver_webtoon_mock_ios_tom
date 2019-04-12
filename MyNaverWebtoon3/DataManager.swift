//
//  DataManager.swift
//  MyNaverWebtoon3
//
//  Created by penta on 07/04/2019.
//  Copyright © 2019 TestOrganization. All rights reserved.
//

import UIKit

class DataManager: NSObject {
    static var resultComicDay = [[ String? : AnyObject? ]]()
    static var resultComicContents = [[ String? : AnyObject? ]]()
    static var resultMyComic = [[ String : AnyObject ]]()
    static var comments = [[ String : AnyObject ]]()
    static var loginFlag:Bool = false
    static var logintoken = ""
    static var mainCollectionViewImage = [UIImage]()
    static var topOfGodViewImage = [UIImage]()
    static var worldOfGirlsViewImage = [UIImage]()
}

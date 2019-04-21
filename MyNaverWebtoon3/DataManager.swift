//
//  DataManager.swift
//  MyNaverWebtoon3
//
//  Created by penta on 07/04/2019.
//  Copyright © 2019 TestOrganization. All rights reserved.
//

import UIKit

class DataManager: NSObject {
    static var resultComicDay = [ComicDayDTO.ComicDay]()
    static var resultComicContents = [ComicContentsDTO.ComicContents]()
    static var resultMyComic = [MyComicListDTO.myComic]()
    static var comments = [CommentDTO.Comments]()
    static var loginFlag:Bool = false
    static var logintoken = ""
    static var mainCollectionViewImage = [UIImage]()
    static var topOfGodViewImage = [UIImage]()
    static var worldOfGirlsViewImage = [UIImage]()
}

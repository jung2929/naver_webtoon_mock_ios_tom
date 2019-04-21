//
//  CollectionViewCell.swift
//  MyNaverWebtoon3
//
//  Created by penta on 03/04/2019.
//  Copyright © 2019 TestOrganization. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var sumnail: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var grade: UILabel!
    @IBOutlet weak var author: UILabel!
    var comicNumber:Int = 0
    var comicNumberOfHeart:Int = 0
}

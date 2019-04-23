//
//  TableViewCell.swift
//  MyNaverWebtoon3
//
//  Created by penta on 07/04/2019.
//  Copyright © 2019 TestOrganization. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var imageSumnailDetail: UIImageView!
    @IBOutlet weak var titleDetail: UILabel!
    @IBOutlet weak var gradeDetail: UILabel!
    @IBOutlet weak var dateDetail: UILabel!
    var conTentNo:Int = 0
    var contentLike:Int = 0
    var comicNo:Int = 0
}

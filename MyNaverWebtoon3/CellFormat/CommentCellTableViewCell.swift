//
//  CommentCellTableViewCell.swift
//  MyNaverWebtoon3
//
//  Created by penta on 12/04/2019.
//  Copyright © 2019 TestOrganization. All rights reserved.
//

import UIKit

class CommentCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var bestLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var goodButton: UIButton!
    @IBOutlet weak var badButton: UIButton!
    
    var contentNo:Int = 0

}

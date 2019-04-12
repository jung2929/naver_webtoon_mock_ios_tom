//
//  MyPageTVC.swift
//  MyNaverWebtoon3
//
//  Created by penta on 10/04/2019.
//  Copyright © 2019 TestOrganization. All rights reserved.
//
//다른 셀들도 이렇게 하는게 좋겠다. tableview 불러올때 셋팅하니 미친짓인듯.

import UIKit

class MyPageTVC: UITableViewCell {
        let sumnailImg = UIImageView()
        let alamImg = UIImageView()
        let titleLabel = UILabel()
        let dateLabel = UILabel()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            sumnailImg.backgroundColor = UIColor.blue
            //alamImg.backgroundColor = UIColor.gray
            
            sumnailImg.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            dateLabel.translatesAutoresizingMaskIntoConstraints = false
            alamImg.translatesAutoresizingMaskIntoConstraints = false
            dateLabel.font = dateLabel.font.withSize(12)
            dateLabel.textColor = UIColor.lightGray
            contentView.addSubview(sumnailImg)
            contentView.addSubview(titleLabel)
            contentView.addSubview(dateLabel)
            contentView.addSubview(alamImg)
            
            let viewsDict = [
                "sumnailImg" : sumnailImg,
                "titleLabel" : titleLabel,
                "dateLabel" : dateLabel,
                "alamImg" : alamImg,
                ] as [String : Any]
        
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(0)-[sumnailImg]-(0)-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(0)-[sumnailImg]", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[sumnailImg(60)]", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[sumnailImg(44)]", options: [], metrics: nil, views: viewsDict))
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(0)-[alamImg]-(0)-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[alamImg]-(0)-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[alamImg(44)]", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[alamImg(44)]", options: [], metrics: nil, views: viewsDict))
        
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[sumnailImg]-[titleLabel]-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(3)-[titleLabel]", options: [], metrics: nil, views: viewsDict))
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[sumnailImg]-(15)-[dateLabel]-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[dateLabel]-(3)-|", options: [], metrics: nil, views: viewsDict))
        
        
//
//            contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[sumnailImg(10)]", options: [], metrics: nil, views: viewsDict))
//            contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[dateLabel]-|", options: [], metrics: nil, views: viewsDict))
//            contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[alamImg(10)]-[dateLabel]-|", options: [], metrics: nil, views: viewsDict))
//            contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[alamImg(10)]-[sumnailImg(10)]-|", options: [], metrics: nil, views: viewsDict))
//            contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[dateLabel]-[dateLabel]-|", options: [], metrics: nil, views: viewsDict))
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    }




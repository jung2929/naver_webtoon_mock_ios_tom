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
    
    
    
    
//    override init(frame: CGRect) {
//        super.init(frame : frame)
//        setupViews()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    let nameLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    let sumnailOfWebtoon: UIImageView = {
//        let image = UIImageView()
//        image.translatesAutoresizingMaskIntoConstraints = false
//        return image
//    }()
//
//    func setupViews(){
//        addSubview(nameLabel)
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0":nameLabel]))
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0":nameLabel]))
//        addSubview(sumnailOfWebtoon)
//        //sumnailOfWebtoon.topAnchor.constraint(equalTo: CollectionViewCell.layoutMarginsGuide.topAnchor)
//    }
//
//    @IBOutlet var label: UILabel!
//    var textLabel: String!

}

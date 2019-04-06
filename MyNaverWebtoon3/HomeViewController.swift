//
//  HomeViewController.swift
//  MyNaverWebtoon3
//
//  Created by penta on 03/04/2019.
//  Copyright © 2019 TestOrganization. All rights reserved.
//

import UIKit
import SegementSlide

var collectionviewMon: UICollectionView!
var collectionviewTue: UICollectionView!
var cellId = "CollectionViewCell"


class HomeViewController: SegementSlideViewController,UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var tabView: UIView!
    
    let someImageView: UIImageView = {
        let theImageView = UIImageView()
        theImageView.image = UIImage(named: "tom.png")
        theImageView.translatesAutoresizingMaskIntoConstraints = false
        print(theImageView.frame.width)
        theImageView.contentMode = .scaleAspectFill
        return theImageView
    }()
    func someImageViewConstraints() {
//        someImageView.widthAnchor.constraint(equalToConstant: slideScrollView.bounds.width).isActive = true
//        someImageView.heightAnchor.constraint(equalToConstant:slideScrollView.bounds.height).isActive = true
//
//        let leftConstraint = someImageView.leftAnchor.constraint(equalTo: self.slideScrollView.leftAnchor)
//        let rightConstraint = someImageView.rightAnchor.constraint(equalTo: self.slideScrollView.rightAnchor)
//        let bottomConstraint = someImageView.bottomAnchor.constraint(equalTo: self.slideScrollView.bottomAnchor)
//        let topConstraint = someImageView.topAnchor.constraint(equalTo: self.slideScrollView.topAnchor)
        //let leadingConstraint = NSLayoutConstraint(item: someImageView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0)
        let bottomConstraint = someImageView.bottomAnchor.constraint(equalTo: self.slideScrollView.bottomAnchor)
        //let bottomConstraint = NSLayoutConstraint(item: someImageView, attribute: .bottom, relatedBy: .equal, toItem: slideScrollView, attribute: .bottom, multiplier: 0.2, constant: 0)
        let leftConstraint = someImageView.leftAnchor.constraint(equalTo: self.slideScrollView.leftAnchor)
        let rightConstraint = someImageView.rightAnchor.constraint(equalTo: self.slideScrollView.rightAnchor)
        //let widthConstraint = NSLayoutConstraint(item: someImageView, attribute: .width, relatedBy: .equal, toItem: slideScrollView, attribute: .width, multiplier: 1, constant: 0)
        let heightConstraint = NSLayoutConstraint(item: someImageView, attribute: .height, relatedBy: .equal, toItem: slideScrollView, attribute: .height, multiplier: 0.5, constant: 0)
        NSLayoutConstraint.activate([leftConstraint, bottomConstraint, rightConstraint, heightConstraint])
        
        
        
        //someImageView.topAnchor. .isActive = true
        //someImageView.centerYAnchor.constraint(equalTo: (headerView?.centerYAnchor)!, constant: 28).isActive = true
    }
    
    //var cellId = "CollectionViewCell"
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? ToDoCell else {print("error")
        //    return UITableViewCell() }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? CollectionViewCell else {print("error")
            return UICollectionViewCell()
        }
        cell.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        //cell.label.frame =
        //cell.label?.text = "\(indexPath.row + 1)"
        cell.nameLabel.text = "작가명"
        //cell.label?.textColor = UIColor(red: 0.45, green: 0.35, blue: 0.35, alpha: 1)
        //    print("label text : ", cell.label?.text)
        print(indexPath.row)
        //print(cell.textLabel)
        return cell
    }
 
    
    
    
    override var headerHeight: CGFloat? {
        return view.bounds.height/10
    }
    
    override var headerView: UIView? {
        
        print("headerView")
        return UIView()
    }
    
    override var titlesInSwitcher: [String] {
        return ["월","화","수","목","금","토","일","신작","완결"]
    }
    
    override func segementSlideContentViewController(at index: Int) -> SegementSlideContentScrollViewDelegate? {
        return ContentViewController()
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        scrollToSlide(at: 0, animated: false)
        print("dddd")
        
        
        reloadData()
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1;
        layout.minimumLineSpacing = 1;
        let cellSize = (CGFloat.minimum(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) - 2) / 3;
        layout.itemSize = CGSize(width: cellSize, height: cellSize)
        layout.scrollDirection = .vertical
        collectionviewMon?.collectionViewLayout = layout
        
        collectionviewMon = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionviewMon.delegate = self
        collectionviewMon.dataSource = self
        collectionviewMon.register(CollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionviewMon.backgroundColor = UIColor.white
        self.slideContentView.addSubview(collectionviewMon)
        //print(collectionviewMon)
        //tabView.addSubview(slideContentView)
        //self.slideContentView.addSubview(tabView)
        self.view.bringSubviewToFront(tabView)
        self.navigationController?.isToolbarHidden = true
        self.tabBarController?.delegate = (self as! UITabBarControllerDelegate)
        //print(tabView)
        
        //self.slideContentView.addSubview(someImageView)
        //self.slideContentView.bringSubviewToFront(someImageView)
//        self.headerView!.frame = CGRect.init(x: 0, y: 0, width: 100, height: 200)
//        self.headerView?.translatesAutoresizingMaskIntoConstraints = false
//        self.headerView?.backgroundColor = .black
//        print(headerView)
//        print(slideContentView)
        
        
        if ((self.slideScrollView.addSubview(someImageView)) != nil) {
            print("success")
        }
        slideScrollView.translatesAutoresizingMaskIntoConstraints = false
        someImageViewConstraints()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView){
        if scrollView.contentOffset.y == 0 {
            self.navigationController?.setNavigationBarHidden(true, animated:true)
        }
        else {
            self.navigationController?.setNavigationBarHidden(false, animated:true)
        }
    }
}




class ContentViewController: UITableViewController, SegementSlideContentScrollViewDelegate  {
    //var collectionviewMon: UICollectionView!
    @objc var scrollView: UIScrollView {
        //if touchesBegan(<#T##touches: Set<UITouch>##Set<UITouch>#>, with: <#T##UIEvent?#>)
        return collectionviewMon
    }
}


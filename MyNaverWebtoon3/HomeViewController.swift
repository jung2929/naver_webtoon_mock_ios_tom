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
        //self.headerView?.backgroundColor = .black
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
        print(tabView)
        
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


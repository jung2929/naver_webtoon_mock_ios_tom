//
//  HomeViewController.swift
//  MyNaverWebtoon3
//
//  Created by penta on 03/04/2019.
//  Copyright © 2019 TestOrganization. All rights reserved.
//

import UIKit
import SegementSlide

class HomeViewController: SegementSlideViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var collectionview: UICollectionView!
    var cellId = "CollectionViewCell"
    
 
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        cell.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        if let label = cell.contentView.subviews.first as? UILabel {
            label.text = "\(indexPath.row + 1)"
            label.textColor = UIColor(red: 0.45, green: 0.35, blue: 0.35, alpha: 1)
        }
        return cell
    }
    override var headerHeight: CGFloat? {
        return view.bounds.height/10
    }
    
    override var headerView: UIView? {
        return UIView()
    }
    
    override var titlesInSwitcher: [String] {
        return ["Swift", "Ruby", "Kotlin"]
    }
    
    override func segementSlideContentViewController(at index: Int) -> SegementSlideContentScrollViewDelegate? {
        return ContentViewController()
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        scrollToSlide(at: 0, animated: false)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 1;
        flowLayout.minimumLineSpacing = 1;
        let cellSize = (CGFloat.minimum(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) - 2) / 3;
        flowLayout.itemSize = CGSize(width: cellSize, height: cellSize)
        flowLayout.scrollDirection = .vertical
        collectionview?.collectionViewLayout = flowLayout
        
        
        
//        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        layout.itemSize = CGSize(width: view.frame.width, height: 700)
//
        collectionview = UICollectionView(frame: self.slideScrollView.frame, collectionViewLayout: flowLayout)
        collectionview.dataSource = self
        collectionview.delegate = self
        collectionview.register(CollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionview.showsVerticalScrollIndicator = false
        collectionview.backgroundColor = UIColor.white
        
        reloadData()

        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}



class ContentViewController: UICollectionViewController, SegementSlideContentScrollViewDelegate {
    var collectionview: UICollectionView!
    
    
    @objc var scrollView: UIScrollView {
        return collectionview
    }
}

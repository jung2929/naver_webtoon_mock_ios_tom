//
//  Test1ViewController.swift
//  MyNaverWebtoon3
//
//  Created by penta on 05/04/2019.
//  Copyright © 2019 TestOrganization. All rights reserved.
//

import UIKit

class Test1ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet var scrollColors: UIScrollView!
    @IBOutlet var colorDots: UIPageControl!
    
    var colors:[UIColor] = [UIColor.red, UIColor.blue, UIColor.green, UIColor.yellow]
    var pics = ["1", "2", "메인뷰광고2", "메인뷰광고3"]
    var pageIndex: Int = 0
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        self.colorDots.backgroundColor = UIColor.black
        self.colorDots.pageIndicatorTintColor = UIColor.lightGray
        self.colorDots.currentPageIndicatorTintColor = UIColor.red
        self.colorDots.tintAdjustmentMode = .dimmed
        self.colorDots.hidesForSinglePage = true
        self.colorDots.numberOfPages = self.colors.count
        
        self.scrollColors.backgroundColor = UIColor.white
        self.scrollColors.showsVerticalScrollIndicator = false
        self.scrollColors.showsHorizontalScrollIndicator = false
        self.scrollColors.isPagingEnabled = true
        self.scrollColors.delegate = self
        self.createColorsBook()
    }
    

    func createColorsBook() {
        
        var xOrigin:CGFloat = 0
        
        for i in 0..<self.colors.count {
            
            let imgView = UIImageView(frame: CGRect(origin: CGPoint(x: xOrigin, y: 0), size: CGSize(width: CGFloat(UIScreen.main.bounds.width), height: self.scrollColors.frame.size.height)))
            imgView.backgroundColor = UIColor.clear
            imgView.contentMode = .scaleAspectFill
            imgView.clipsToBounds = true
            imgView.image = UIImage(named: (pics[i] as String))!
            self.scrollColors.addSubview(imgView)
            xOrigin = xOrigin + self.scrollColors.frame.size.width
        }
        self.scrollColors.contentSize = CGSize(width: (CGFloat(self.colors.count)) * self.scrollColors.frame.size.width, height:0)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("scolled")
        let pageWidth: CGFloat = self.scrollColors.frame.size.width
        let fractionalPage: CGFloat = self.scrollColors.contentOffset.x / pageWidth
        pageIndex = lround(Double(fractionalPage))
        self.colorDots.currentPage = pageIndex
    }

}


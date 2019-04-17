//
//  ViewWebtoonVC.swift
//  MyNaverWebtoon3
//
//  Created by penta on 03/04/2019.
//  Copyright © 2019 TestOrganization. All rights reserved.
//

import UIKit
import AMScrollingNavbar

class ViewWebtoonViewController: ScrollingNavigationViewController, ScrollingNavigationControllerDelegate{
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var bottomView: UIView!
    
    
    @IBOutlet weak var viewInstantMessage: UIButton!

    var tmpCotentNo:Int = 0

    
    @IBAction func viewInstantMessageTapped(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "WebToon"
        
        // navigationItem.prompt = "Prompt"
        
//        navigationController?.navigationBar.barTintColor = UIColor(red:0.17, green:0.59, blue:0.87, alpha:1)
//        tabBarController?.tabBar.barTintColor = UIColor(red:0.17, green:0.59, blue:0.87, alpha:1)
//        tabBarController?.tabBar.tintColor = .white
//
        //scrollView.backgroundColor = UIColor(red:0.13, green:0.5, blue:0.73, alpha:1)
        
        
        
        let webtoonSample = UIImage(named: "1")
        
        let imgView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.scrollView.frame.size.width, height: webtoonSample!.size.height)))
        imgView.backgroundColor = UIColor.clear
        imgView.contentMode = .scaleToFill
        imgView.image = webtoonSample
        scrollView.contentSize = CGSize(width: self.scrollView.frame.size.width, height: webtoonSample!.size.height)
        scrollView.delegate = self
        
        print(scrollView.frame)
        
        
        //imgView.clipsToBounds = true
        
        scrollView.addSubview(imgView)
        //scrollView.bringSubviewToFront(imgView)
        self.view.bringSubviewToFront(bottomView)
    }
    

    func scrollingNavigationController(_ controller: ScrollingNavigationController, didChangeState state: NavigationBarState) {
        switch state {
        case .collapsed:
            print("navbar collapsed")
            self.view.sendSubviewToBack(bottomView)
        case .expanded:
            print("navbar expanded")
            self.view.bringSubviewToFront(bottomView)
        case .scrolling:
            print("navbar is moving")
            self.view.sendSubviewToBack(bottomView)
        }
    }
    
    // Enable the navbar scrolling
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //navigationController?.navigationBar.barTintColor = UIColor(red:0.17, green:0.59, blue:0.87, alpha:1)
        
        if let navigationController = self.navigationController as? ScrollingNavigationController {
            if let tabBarController = tabBarController {
                navigationController.followScrollView(scrollView, delay: 0, scrollSpeedFactor: 2, followers: [NavigationBarFollower(view: tabBarController.tabBar, direction: .scrollDown)])
            } else {
                navigationController.followScrollView(scrollView, delay: 0.0, scrollSpeedFactor: 2)
            }
            navigationController.scrollingNavbarDelegate = self
            navigationController.expandOnActive = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? CommentViewController else { return }
                destination.tmpCotentNo = tmpCotentNo
    }
}

//
//  ViewWebtoonVC.swift
//  MyNaverWebtoon3
//
//  Created by penta on 03/04/2019.
//  Copyright © 2019 TestOrganization. All rights reserved.
//

import UIKit
import AMScrollingNavbar

class ViewWebtoonViewController: UIViewController, UIScrollViewDelegate, UIGestureRecognizerDelegate{
//    class ViewWebtoonViewController: ScrollingNavigationViewController, ScrollingNavigationControllerDelegate{

    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var viewInstantMessage: UIButton!
    var tmpCotentNo:Int = 0

    
    @IBAction func viewInstantMessageTapped(_ sender: Any) {
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "WebToon"
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
        
        let webtoonSample = UIImage(named: "1")
        
        let imgView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.scrollView.frame.size.width, height: webtoonSample!.size.height)))
        imgView.backgroundColor = UIColor.clear
        imgView.contentMode = .scaleToFill
        imgView.image = webtoonSample
        scrollView.contentSize = CGSize(width: self.scrollView.frame.size.width, height: webtoonSample!.size.height)
        scrollView.delegate = self
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(scrollViewTapped(gestureRecognizer:)))
        scrollView.addGestureRecognizer(tapRecognizer)
        tapRecognizer.delegate = self
        scrollView.addSubview(imgView)
        
        self.view.bringSubviewToFront(bottomView)
    }
    
    @objc func scrollViewTapped(gestureRecognizer: UITapGestureRecognizer) {
        self.navigationController?.navigationBar.isHidden=false
        self.view.bringSubviewToFront(self.bottomView)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? CommentViewController else { return }
        destination.tmpCotentNo = tmpCotentNo
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        print("in")
        if segue.identifier == "unwind1" {
            let vc = segue.destination as! ListWebtoonTableViewContrller
            print("in")
            vc.navigationItem.title = "in"
            //vc.viewDidLoad()
            //vc.viewWillAppear(true)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.isEqual(scrollView) {
            switch scrollView.panGestureRecognizer.state {
            case .began:
                print("began")
            case .changed:
                self.navigationController?.navigationBar.isHidden = true
                self.view.sendSubviewToBack(bottomView)
                print("changed")
            case .possible:
                print("possible")
            default:
                break
            }
        }
    }
}

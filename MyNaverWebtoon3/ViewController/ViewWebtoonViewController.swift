//
//  ViewWebtoonVC.swift
//  MyNaverWebtoon3
//
//  Created by penta on 03/04/2019.
//  Copyright © 2019 TestOrganization. All rights reserved.
//

import UIKit
import AMScrollingNavbar
import Alamofire
import AlamofireObjectMapper

class ViewWebtoonViewController: UIViewController, UIScrollViewDelegate, UIGestureRecognizerDelegate{
//    class ViewWebtoonViewController: ScrollingNavigationViewController, ScrollingNavigationControllerDelegate{

    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var viewInstantMessage: UIButton!
    @IBOutlet weak var contentLike: UIButton!

    
    
    @IBAction func viewInstantMessageTapped(_ sender: Any) {
    }
    @IBAction func contentLikeTapped(_ sender: Any) {
        giveLikeContent()
    }
    
    
    var tmpCotentNo:Int = 0
    var tmpContentLike:Int = 0
    var tmpComicNo:Int = 0
    
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
        
        contentLike.setTitle("♡ "+String(tmpContentLike), for: .normal)
        
        self.view.bringSubviewToFront(bottomView)
    }
    
    func giveLikeContent(){
        print("giveLikein")
        print("타겟 contentno : ", tmpCotentNo)
        let url = "http://softcomics.co.kr/comic/content/like"
        let parameters: [String: Any] = [
            "contentno":tmpCotentNo
        ]
        let header = ["x-access-token":DataManager.logintoken]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers:header).responseObject{(response : DataResponse<BaseDTO>) in
            if let JSON = response.result.value {
                let status = response.result.value?.code
                print(status)
                switch status {
                case 100:
                    let alert = UIAlertController(title: "컨텐츠 좋아요", message: JSON.message, preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(okAction)
                    self.contentLike.setTitle("♥︎ "+"\(JSON.like!)", for: .normal)
                    self.present(alert, animated: true, completion: nil)
                    break
                default:
                    print(status)
                    print("로그인하세요.")
                    break
                }
            }
        }
    }
//
//    func setButtonCount(){
//        let url = "http://softcomics.co.kr/comic/contentAll/"+"\(tmpComicNo)"
//        print(url)
//        print("변경전 like : ",tmpContentLike)
//        Alamofire.request(url).responseObject{(response : DataResponse<ComicContentsDTO>) in
//            if let JSON = response.result.value {
//                DataManager.resultComicContents = JSON.resultComicContents
//            }
//        }
//        //아래 부분 수정 해야할듯..
//            for result in DataManager.resultComicContents{
//                if result.contentNo == self.tmpCotentNo{
//                    self.contentLike.setTitle("♥︎ "+"\(result.contentHeart!)", for: .normal)
//                    print(result.contentNo!)
//                    print(result.contentHeart!)
//                }
//            }
//    }
    
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

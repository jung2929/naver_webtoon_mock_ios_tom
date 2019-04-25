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
    
    @IBAction func viewInstantMessageTapped(_ sender: Any) {
    }
    @IBAction func contentLikeTapped(_ sender: Any) {
        
    }
    @IBAction func heartButtonTapped(_ sender: Any) {
        if isGivenHeart == false {
            giveHeartToContent(mode: "real")
            self.setGivenHeartButton()
            let alert = UIAlertController(title: "웹툰 좋아요!", message: "좋아요 누름!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        } else {
            giveHeartToContent(mode: "real")
            self.setNotGivenHeartButton()
            let alert = UIAlertController(title: "웹툰 좋아요!", message: "좋아요 취소!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var viewInstantMessage: UIButton!
    @IBOutlet weak var contentLike: UIButton!
    @IBOutlet weak var heartButton: UIButton!
    
    var tmpCotentNo:Int = 0
    var tmpContentLike:Int = 0
    var tmpComicNo:Int = 0
    var isGivenHeart:Bool = false

    
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
        
        contentLike.setTitle(String(tmpContentLike), for: .normal)
        self.getDatafromJson(mode: "real")
        self.view.bringSubviewToFront(bottomView)
    }
    
    func getDatafromJson(mode:String){
        if mode == "real" {
            print(mode)
            let header = ["x-access-token":DataManager.logintoken]
            let url = "http://softcomics.co.kr/comic/content/"+"\(tmpCotentNo)"
            Alamofire.request(url, method: .get, encoding: URLEncoding.default , headers: header ).responseObject{(response : DataResponse<ContentDTO>) in
                if let JSON = response.result.value {
                    DataManager.resultContent = JSON.result
                    switch JSON.check {
                    case 0:
                        self.setNotGivenHeartButton()
                        break
                    case 1:
                        self.setGivenHeartButton()
                        break
                    default :
                        self.setNotGivenHeartButton()
                        print("로그인하세요.")
                        break
                    }
                    //self.tableView.reloadData() --> 이거 이미지 불러오는걸로 변경해야함.
                }
            }
        }
    }
    
    func setGivenHeartButton(){
        self.isGivenHeart = true
        self.heartButton.setTitle("♥︎", for: .normal)
        self.heartButton.setTitleColor(.red, for: .normal)
    }
    func setNotGivenHeartButton(){
        self.isGivenHeart = false
        self.heartButton.setTitle("♡", for: .normal)
        self.heartButton.setTitleColor(.black, for: .normal)
    }
    
    func giveHeartToContent(mode:String){
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
                    self.contentLike.setTitle("\(JSON.like!)", for: .normal)
                    break
                default:
                    print(status)
                    print("로그인하세요.")
                    break
                }
            }
        }
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

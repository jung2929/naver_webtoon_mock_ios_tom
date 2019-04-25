//
//  CommentVC.swift
//  MyNaverWebtoon3
//
//  Created by penta on 12/04/2019.
//  Copyright © 2019 TestOrganization. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import BetterSegmentedControl

class CommentViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @objc func giveThemLike(_ sender: UIButton){
        print("giveThemLike")
        sender.layer.borderWidth = 1
        sender.layer.borderColor = UIColor.orange.cgColor
    }
    @objc func giveThemDisLike(_ sender: UIButton){
        print("giveThemDisLike")
        sender.layer.borderWidth = 1
        sender.layer.borderColor = UIColor.orange.cgColor
    }
    
    
    @IBAction func insertCommentRequest(_ sender: Any) {
        let comment:String = commentTextField.text!
        let url = "http://softcomics.co.kr/comic/content/comment"
        let parameters: [String: Any] = [
            "contentno":tmpCotentNo,
            "comment":comment
        ]
        let header = ["x-access-token":DataManager.logintoken]

        print(parameters)
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers:header).responseObject{(response : DataResponse<BaseDTO>) in
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
                let status = response.result.value?.code
                print(status)
                switch status {
                case 100:
                    print("comment ok")
                    let alert = UIAlertController(title: "댓글", message: "댓글이 달렸습니다.", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                    self.commentTextField.resignFirstResponder()
                    break
                default:
                    print(status)
                    print("로그인하세요.")
                    break
                }
            }
        }
        
    }
    
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func topSectionSegmentsChanged(_ sender: BetterSegmentedControl) {
        switch sender.index {
        case 0:
            print("0")
            getCommentsDatafromJson(mode: "real", url: "http://softcomics.co.kr/comic/content/bestcomment/", contentNo: String(tmpCotentNo))
        case 1:
            print("1")
            getCommentsDatafromJson(mode: "real", url: "http://softcomics.co.kr/comic/content/comment/", contentNo: String(tmpCotentNo))
        default:
            print("default")
        }
    }
    
    @IBOutlet weak var topSectionSegments: BetterSegmentedControl!
    @IBOutlet weak var insertCommentConstraint: NSLayoutConstraint!
    @IBOutlet weak var commentTextField: UITextField!
    
    var tmpCotentNo:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tabBarController?.tabBar.isHidden = true
        
        self.setupCommentSelectSegment()
        self.setupNavigationBar()
        getCommentsDatafromJson(mode: "real", url: "http://softcomics.co.kr/comic/content/bestcomment/", contentNo: String(tmpCotentNo))
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        self.view.bringSubviewToFront(bottomView)
    }
    
    func setupNavigationBar(){
        self.navigationController?.navigationBar.backItem?.title=" "
        self.title="댓글 ("+"1,696"+")"
        let refreshItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshComment))
        self.navigationItem.rightBarButtonItem = refreshItem
    }
    
    @objc func refreshComment(){
        print("refresh")
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        commentTextField.resignFirstResponder()
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        let keyboardSize = (notification.userInfo?  [UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        let keyboardHeight = keyboardSize?.height
        if #available(iOS 11.0, *){
            self.insertCommentConstraint.constant = keyboardHeight! - view.safeAreaInsets.bottom + 10
        }
        else {
            self.insertCommentConstraint.constant = view.safeAreaInsets.bottom
        }
        UIView.animate(withDuration: 0.5){
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(notification: Notification){
        self.insertCommentConstraint.constant =  0
        UIView.animate(withDuration: 0.5){
            self.view.layoutIfNeeded()
        }
    }
    
    func setupCommentSelectSegment(){
        self.topSectionSegments.segments = LabelSegment.segments(withTitles: ["BEST 댓글","전체 댓글"],normalFont: UIFont(name: "HelveticaNeue-Light", size: 14.0)!,
                                                               normalTextColor: .black,
                                                               selectedFont: UIFont(name: "HelveticaNeue-Bold", size: 14.0)!,         selectedTextColor: .white)
        topSectionSegments.setIndex(10, animated: true)
    }
    
    
    func getCommentsDatafromJson(mode:String, url:String, contentNo:String){
        if mode == "testBestComments" {
            print(mode)
            let path = Bundle.main.path(forResource: "TestCommentsTest", ofType: "json")
            if let path = Bundle.main.path(forResource: "TestCommentsTest", ofType: "json") {
                let url=URL(fileURLWithPath: path)
                Alamofire.request(url).responseObject {(response : DataResponse<CommentDTO>) in
                    if let JSON = response.result.value {
                        DataManager.comments = JSON.data
                        print("resultComicDay",DataManager.comments)
                        print(DataManager.comments.count)
                        self.tableView.reloadData()
                    }
                }
            }
        } else if mode == "testAllComments"{
            let path = Bundle.main.path(forResource: "AllCommentsTest", ofType: "json")
            if let path = Bundle.main.path(forResource: "AllCommentsTest", ofType: "json") {
                let url=URL(fileURLWithPath: path)
                Alamofire.request(url).responseObject {(response : DataResponse<CommentDTO>) in
                    if let JSON = response.result.value {
                        DataManager.comments = JSON.data
                        self.tableView.reloadData()
                    }
                }
            }
        } else if mode == "real" {
            print(mode)
            let url = url+contentNo
            print(url)
            Alamofire.request(url).responseObject{(response : DataResponse<CommentDTO>) in
                if let JSON = response.result.value {
                    DataManager.comments = JSON.data
                    self.tableView.reloadData()
                }
            }
        }
    }
}




extension CommentViewController{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as? CommentCellTableViewCell else {print("error")
            return UITableViewCell() }
        if topSectionSegments.index == 0{
            cell.bestLabel.text = " BEST "
        } else {
            cell.bestLabel.text = ""
        }
        cell.bestLabel.layer.masksToBounds = true
        cell.bestLabel.layer.backgroundColor = UIColor.red.cgColor
        cell.bestLabel.layer.cornerRadius=10
        cell.commentLabel.text = DataManager.comments[indexPath.row].commentContent
        cell.dateLabel.text = DataManager.comments[indexPath.row].commentDate
        cell.idLabel.text = DataManager.comments[indexPath.row].userId
        let tmpCommentLike:String = String(DataManager.comments[indexPath.row].commentLike!)
        cell.goodButton.layer.borderColor = UIColor.lightGray.cgColor
        cell.goodButton.layer.borderWidth = 0.5
        cell.goodButton.layer.backgroundColor = UIColor.white.cgColor
        cell.goodButton.setTitle("👍 "+tmpCommentLike, for: .normal)
        let tmpCommentDislike:String = String(DataManager.comments[indexPath.row].commentDislike!)
        cell.badButton.layer.borderColor = UIColor.lightGray.cgColor
        cell.badButton.layer.borderWidth = 0.5
        cell.badButton.layer.backgroundColor = UIColor.white.cgColor
        cell.badButton.setTitle("👎 "+tmpCommentDislike, for: .normal)
        
        cell.goodButton.addTarget(self, action: #selector(giveThemLike(_:)), for: .touchUpInside)
        cell.badButton.addTarget(self, action: #selector(giveThemDisLike(_:)), for: .touchUpInside)
        return cell
    }
}

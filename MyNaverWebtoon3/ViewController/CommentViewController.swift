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

let defaults = UserDefaults.standard

class CommentViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBAction func insertCommentRequest(_ sender: Any) {
        let comment:String = commentTextField.text!
        let url = "http://softcomics.co.kr/comic/content/comment"
        let parameters: [String: Any] = [
            "contentno":tmpCotentNo,
            "comment":comment
        ]
        let header = ["x-access-token":DataManager.logintoken]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers:header).responseObject{(response : DataResponse<BaseDTO>) in
            if let JSON = response.result.value {
                let status = response.result.value?.code
                print(status)
                switch status {
                case 100:
                    let alert = UIAlertController(title: "댓글", message: "댓글이 달렸습니다.", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                    self.commentTextField.resignFirstResponder()
                    self.getCommentsDatafromJson2(segmentIndex: Int(self.topSectionSegments!.index), contentNo: String(self.tmpCotentNo))
                    break
                default:
                    print(status)
                    print("로그인하세요.")
                    break
                }
            }
        }
    }
    
    @IBAction func topSectionSegmentsChanged(_ sender: BetterSegmentedControl) {
        switch sender.index {
        case 0:
            getCommentsDatafromJson(mode: "real", url: "http://softcomics.co.kr/comic/content/bestcomment/", contentNo: String(tmpCotentNo))
        case 1:
            getCommentsDatafromJson(mode: "real", url: "http://softcomics.co.kr/comic/content/comment/", contentNo: String(tmpCotentNo))
        default:
            print("default")
        }
    }
    
    @IBOutlet weak var topSectionSegments: BetterSegmentedControl!
    @IBOutlet weak var insertCommentConstraint: NSLayoutConstraint!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var tableView: UITableView!
    var tmpCotentNo:Int = 0
    var tmpCommentCount:Int = 0
    var tmpLikeCount:Int = 0
    var tmpDislikeCount:Int = 0
    let tmpMycomments = [Int]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tabBarController?.tabBar.isHidden = true
        
        self.setupCommentSelectSegment()
        self.setupNavigationBar()
        getCommentsDatafromJson(mode: "real", url: "http://softcomics.co.kr/comic/content/bestcomment/", contentNo: String(tmpCotentNo))
        getMyComments()
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        self.view.bringSubviewToFront(bottomView)
        
        print("Username : ", DataManager.resultMyInfo?.userId)
    }
    
    func setupNavigationBar(){
        self.navigationController?.navigationBar.backItem?.title=" "
        self.title="댓글 ("+"\(tmpCommentCount)"+")"
        let refreshItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshComment))
        self.navigationItem.rightBarButtonItem = refreshItem
    }
    
    @objc func refreshComment(){
        self.getCommentsDatafromJson2(segmentIndex: Int(self.topSectionSegments!.index), contentNo: String(self.tmpCotentNo))
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
    
    @objc func giveThemLike(_ sender: likeDislikeButton){
        commentLikeDislike(likeDislike: "like", commentno: sender.commentno!, sender)
    }
    @objc func giveThemDisLike(_ sender: likeDislikeButton){
        commentLikeDislike(likeDislike: "dislike", commentno: sender.commentno!, sender)
    }
    
    func deleteMyComment(commentno:Int){
        var url = "http://softcomics.co.kr/comic/content/comment"
        let parameters: [String: Any] = [
            "commentno":commentno
        ]
        let header = ["x-access-token":DataManager.logintoken]
        Alamofire.request(url, method: .delete, parameters: parameters, encoding: JSONEncoding.default, headers:header).responseObject{(response : DataResponse<BaseDTO>) in
            if let JSON = response.result.value {
                let status = JSON.code
                print(status)
                switch status {
                case 100:
                    let alert = UIAlertController(title: "댓글", message: "댓글이 삭제되었습니다..", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(okAction)
                    self.getCommentsDatafromJson2(segmentIndex: Int(self.topSectionSegments!.index), contentNo: String(self.tmpCotentNo))
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
    
    func getMyComments(){
        if let itemRaw = UserDefaults.standard.data(forKey: "myComments") {
            do {
                let item = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(itemRaw)
                DataManager.myComments = item as! [String]
            }catch{print(error)}
        }
    }
    
    func syncMyComments(likeDislike:String,commentno:Int){
        do{ let item = likeDislike + "\(commentno)"
            if let index = DataManager.myComments.index(of: item) {
                print("deleted")
                DataManager.myComments.remove(at: index)
            } else {
                print("inserted")
                DataManager.myComments.append(item)
            }
            let myComments = try NSKeyedArchiver.archivedData(withRootObject: DataManager.myComments, requiringSecureCoding: false)
            UserDefaults.standard.set(myComments, forKey: "myComments")
            defaults.synchronize()
            print("DataManager.myComments : ",DataManager.myComments)
        }catch{print(error)}
    }
    
    func checkMyComments(likeDislike:String,commentno:Int, button:likeDislikeButton){
        let item = likeDislike + "\(commentno)"
        if DataManager.myComments.index(of: item) != nil {
            button.layer.borderWidth = 2
            button.layer.borderColor = UIColor.orange.cgColor
            button.layer.backgroundColor = UIColor.white.cgColor
        } else {
            
            button.layer.borderColor = UIColor.lightGray.cgColor
            button.layer.borderWidth = 1
            button.layer.backgroundColor = UIColor.white.cgColor
        }
    }
    
    func setupCommentSelectSegment(){
        self.topSectionSegments.segments = LabelSegment.segments(withTitles: ["BEST 댓글","전체 댓글"],normalFont: UIFont(name: "HelveticaNeue-Light", size: 14.0)!,
                                                               normalTextColor: .black,
                                                               selectedFont: UIFont(name: "HelveticaNeue-Bold", size: 14.0)!,         selectedTextColor: .white)
        topSectionSegments.setIndex(10, animated: true)
    }
    
    func commentLikeDislike(likeDislike:String, commentno:Int, _ sender: likeDislikeButton){
        var url = "http://softcomics.co.kr/comic/content/comment/"
        url = url+likeDislike
        let parameters: [String: Any] = [
            "commentno":commentno
        ]
        let header = ["x-access-token":DataManager.logintoken]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers:header).responseObject{(response : DataResponse<BaseDTO>) in
            if let JSON = response.result.value {
                let status = JSON.code
                print(status)
                switch status {
                case 100:
                    if likeDislike == "like"{
                        print("JSON.like!:",JSON.like!)
                        self.tmpLikeCount = JSON.like!
                        sender.setTitle("👍 "+"\(self.tmpLikeCount)", for: .normal)
                        self.syncMyComments(likeDislike: likeDislike, commentno: commentno)
                        self.checkMyComments(likeDislike: likeDislike, commentno: commentno, button: sender)
                    } else {
                        print("JSON.dislike!:",JSON.dislike!)
                        self.tmpDislikeCount = JSON.dislike!
                        sender.setTitle("👎 "+"\(self.tmpDislikeCount)", for: .normal)
                        self.syncMyComments(likeDislike: likeDislike, commentno: commentno)
                        self.checkMyComments(likeDislike: likeDislike, commentno: commentno, button: sender)
                    }
                    break
                default:
                    print(status)
                    print("로그인하세요.")
                    break
                }
            }
        }
    }
    
    func getCommentsDatafromJson2(segmentIndex:Int, contentNo:String){
        switch segmentIndex {
        case 0:
            let url = "http://softcomics.co.kr/comic/content/"+"bestcomment/"+contentNo
            Alamofire.request(url).responseObject{(response : DataResponse<CommentDTO>) in
                if let JSON = response.result.value {
                    DataManager.comments = JSON.data
                    self.tableView.reloadData()
                }
            }
            break
        case 1:
            let url = "http://softcomics.co.kr/comic/content/"+"comment/"+contentNo
            Alamofire.request(url).responseObject{(response : DataResponse<CommentDTO>) in
                if let JSON = response.result.value {
                    DataManager.comments = JSON.data
                    self.tableView.reloadData()
                }
            }
            break
        default:
            break
        }
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
        checkMyComments(likeDislike: "like", commentno: DataManager.comments[indexPath.row].commentNo!, button:cell.goodButton)
        cell.goodButton.commentno = DataManager.comments[indexPath.row].commentNo
        cell.goodButton.setTitle("👍 "+tmpCommentLike, for: .normal)
        
        let tmpCommentDislike:String = String(DataManager.comments[indexPath.row].commentDislike!)
        checkMyComments(likeDislike: "dislike", commentno: DataManager.comments[indexPath.row].commentNo!, button:cell.badButton)
        cell.badButton.commentno = DataManager.comments[indexPath.row].commentNo
        cell.badButton.setTitle("👎 "+tmpCommentDislike, for: .normal)
        
        cell.goodButton.addTarget(self, action: #selector(giveThemLike(_:)), for: .touchUpInside)
        cell.badButton.addTarget(self, action: #selector(giveThemDisLike(_:)), for: .touchUpInside)
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        print(DataManager.comments[indexPath.row].commentNo!)
        if editingStyle == .delete {
            if DataManager.comments[indexPath.row].userId == DataManager.resultMyInfo?.userId{
                deleteMyComment(commentno: DataManager.comments[indexPath.row].commentNo!)
                print("deleted target")
                let like = "like" + "\(DataManager.comments[indexPath.row].commentNo!))"
                let dislike = "dislike" + "\(DataManager.comments[indexPath.row].commentNo!))"
                if let index = DataManager.myComments.index(of: like) {
                    print("deleted")
                    DataManager.myComments.remove(at: index)
                }
                if let index = DataManager.myComments.index(of: dislike) {
                    print("deleted")
                    DataManager.myComments.remove(at: index)
                }
            } else {
                let alert = UIAlertController(title: "댓글", message: "내 댓글이 아닙니다.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }
}

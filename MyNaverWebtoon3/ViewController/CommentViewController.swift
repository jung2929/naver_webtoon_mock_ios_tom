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

class CommentViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    //BEST Label 없애려면 TableView를 2개 써야할듯.
    
   
    
    
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
    
    @IBAction func bestCommentTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            
            print(sender.isSelected)
            bestComment.backgroundColor = UIColor.green
            bestComment.setTitleColor(UIColor.white, for: .normal)
            allComment.backgroundColor = UIColor.lightGray
            allComment.setTitleColor(UIColor.black, for: .normal)
            //bestComment.setTitle("ON", for: .normal)
            getCommentsDatafromJson(mode: "real", url: "http://softcomics.co.kr/comic/content/bestcomment/", contentNo: String(tmpCotentNo))
            sender.isSelected = false
            self.tableView.reloadData()
        }
            
        else {
            bestComment.backgroundColor = UIColor.lightGray
            bestComment.setTitleColor(UIColor.black, for: .normal)
            allComment.backgroundColor = UIColor.green
            allComment.setTitleColor(UIColor.white, for: .normal)
            print(sender.isSelected)
            //sender.isSelected = true
            //bestComment.setTitle("OFF", for: .normal)
        }
    }
    
    @IBAction func allCommentTapped(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            
            print(sender.isSelected)
            allComment.backgroundColor = UIColor.green
            allComment.setTitleColor(UIColor.white, for: .normal)
            bestComment.backgroundColor = UIColor.lightGray
            bestComment.setTitleColor(UIColor.black, for: .normal)
            //bestComment.setTitle("ON", for: .normal)
            getCommentsDatafromJson(mode: "real", url: "http://softcomics.co.kr/comic/content/comment/", contentNo: String(tmpCotentNo))
            sender.isSelected = false
            self.tableView.reloadData()
        }
            
        else {
            allComment.backgroundColor = UIColor.lightGray
            allComment.setTitleColor(UIColor.black, for: .normal)
            bestComment.backgroundColor = UIColor.green
            bestComment.setTitleColor(UIColor.white, for: .normal)
            print(sender.isSelected)
            //bestComment.setTitle("OFF", for: .normal)
        }
        
    }
    
    @IBAction func goodTapped(_ sender: Any) {
    }
    @IBAction func badTapped(_ sender: Any) {
    }
    
    @IBAction func insertCommentRequest(_ sender: Any) {
        let comment:String = commentTextField.text!
        let url = "http://softcomics.co.kr/comic/content/comment"
        let parameters: [String: Any] = [
            "contentno":1,
            "comment":comment
        ]
        let header = ["x-access-token":DataManager.logintoken]
        print(parameters)
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers:header).responseObject{(response : DataResponse<SimpleResponseDTO>) in
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
                print(response.result.value?.code)
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
    
    @IBOutlet weak var bestComment: UIButton!
    @IBOutlet weak var allComment: UIButton!
    
    @IBOutlet weak var insertCommentConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var commentTextField: UITextField!
    
    var tmpCotentNo:Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // Do any additional setup after loading the view.
        
        
        print("tmpContentNo",tmpCotentNo)
        tmpCotentNo = 1  /// 서버에 1밖에 없음.
        print("tmpContentNo",tmpCotentNo)
        getCommentsDatafromJson(mode: "real", url: "http://softcomics.co.kr/comic/content/bestcomment/", contentNo: String(tmpCotentNo))
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        self.view.bringSubviewToFront(bottomView)
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
    
    func getCommentsDatafromJson(mode:String, url:String, contentNo:String){
        if mode == "testBestComments" {
            print(mode)
            let path = Bundle.main.path(forResource: "TestCommentsTest", ofType: "json")
            print(path)
            if let path = Bundle.main.path(forResource: "TestCommentsTest", ofType: "json") {
                let url=URL(fileURLWithPath: path)
                Alamofire.request(url).responseObject {(response : DataResponse<CommentDTO>) in
                    if let JSON = response.result.value {
                        //print("JSON: \(JSON)")
                        //print(response.result.value?.resultComicDay)
                        DataManager.comments = JSON.data
                        print("resultComicDay",DataManager.comments)
                        print(DataManager.comments.count)
                        self.tableView.reloadData()
                    }
                }
            }
            //print("out:",DataManager.resultComicDay.count)
        } else if mode == "testAllComments"{
             print(mode)
            let path = Bundle.main.path(forResource: "AllCommentsTest", ofType: "json")
            print(path)
            if let path = Bundle.main.path(forResource: "AllCommentsTest", ofType: "json") {
                let url=URL(fileURLWithPath: path)
                Alamofire.request(url).responseObject {(response : DataResponse<CommentDTO>) in
                    if let JSON = response.result.value {
                        //print("JSON: \(JSON)")
                        //print(response.result.value?.resultComicDay)
                        DataManager.comments = JSON.data
                        print("resultComicDay",DataManager.comments)
                        print(DataManager.comments.count)
                        self.tableView.reloadData()
                    }
                }
            }
        } else if mode == "real" {
            print(mode)
            let url = url+contentNo
            // DispatchQueue.global(qos:.userInteractive).async {
            print(url)
            Alamofire.request(url).responseObject{(response : DataResponse<CommentDTO>) in
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                    print(response.result.value?.data)
                    DataManager.comments = JSON.data
                    print("resultComicDay",DataManager.comments)
                    print(DataManager.comments.count)
                    self.tableView.reloadData()
                }
            }
            //}
        }
//        DispatchQueue.main.async {
//            self.tableView.reloadData()
//            print("tableView reloaded")
//        }
    }
}


extension CommentViewController{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as? CommentCellTableViewCell else {print("error")
            return UITableViewCell() }
        //cell.bestLabel.text = "best"
        cell.bestLabel.layer.borderWidth=1
        cell.bestLabel.layer.borderColor = UIColor.white.cgColor
        cell.bestLabel.layer.cornerRadius=10
        cell.commentLabel.text = DataManager.comments[indexPath.row].commentContent
        cell.dateLabel.text = DataManager.comments[indexPath.row].commentDate
        cell.idLabel.text = DataManager.comments[indexPath.row].userId
        let tmpCommentLike:String = String(DataManager.comments[indexPath.row].commentLike!)
        cell.goodButton.layer.cornerRadius = 5
        cell.goodButton.layer.borderWidth = 1
        cell.goodButton.setTitle("👍 "+tmpCommentLike, for: .normal)
        let tmpCommentDislike:String = String(DataManager.comments[indexPath.row].commentDislike!)
        cell.badButton.layer.cornerRadius = 5
        cell.badButton.layer.borderWidth = 1
        cell.badButton.setTitle("👎 "+tmpCommentDislike, for: .normal)
        
        cell.goodButton.addTarget(self, action: #selector(giveThemLike(_:)), for: .touchUpInside)
        cell.badButton.addTarget(self, action: #selector(giveThemDisLike(_:)), for: .touchUpInside)
        return cell
    }
}

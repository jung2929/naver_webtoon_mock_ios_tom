//
//  ListWebtoonTVC.swift
//  MyNaverWebtoon3
//
//  Created by penta on 03/04/2019.
//  Copyright © 2019 TestOrganization. All rights reserved.
//

import UIKit
import AMScrollingNavbar
import Alamofire
import AlamofireObjectMapper

class ListWebtoonTableViewContrller: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBAction func registerButtonTapped(_ sender: registerButton) {
        registerMyComic()
    }
    
    @IBAction func comicContentFirstButtonTapped(_ sender: Any) {
        requestComicContentFirst()
    }
    
    @IBAction func giveToonHeart(_ sender: Any) {
        if isGivenHeart == false {
            giveHeartToComic(mode: "real")
            self.setGivenHeartButton()
            let alert = UIAlertController(title: "웹툰 좋아요!", message: "좋아요 누름!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        } else {
            giveHeartToComic(mode: "real")
            self.setNotGivenHeartButton()
            let alert = UIAlertController(title: "웹툰 좋아요!", message: "좋아요 취소!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    var isRegister:Bool = false
    var isGivenHeart:Bool = false
    @IBOutlet weak var comicHeart: UIButton!
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var registerButton: registerButton!
    @IBOutlet weak var tableView: UITableView!
    var tmpNaviBarTopItem:String?
    var tmpComicNumber:Int?
    var tmpComicNumberofHeart:Int?
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
        getDatafromJson(mode: "real")
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.topItem!.title = tmpNaviBarTopItem
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.comicHeart.setTitle("\(tmpComicNumberofHeart!)", for: .normal)
        
        getDatafromJson(mode: "real")
    }
    
    func registerMyComic(){
        let url = "http://softcomics.co.kr/my/comic"
        let parameters: [String: Any] = [
            "comicno":tmpComicNumber!
        ]
        let header = ["x-access-token":DataManager.logintoken]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers:header).responseObject{(response : DataResponse<BaseDTO>) in
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
                print(response.result.value?.code)
                let status = response.result.value?.code
                let msg = response.result.value?.message
                print(status)
                switch status {
                case 100:
                    print("register ok")
                    let alert = UIAlertController(title: "내 웹툰으로 등록", message: msg, preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(okAction)
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
    
    func getDatafromJson(mode:String){
        if mode == "test" {
            print(mode)
            if let path = Bundle.main.path(forResource: "ComicContentsDTOTest", ofType: "json") {
                let url=URL(fileURLWithPath: path)
                Alamofire.request(url).responseObject {(response : DataResponse<ComicContentsDTO>) in
                    if let JSON = response.result.value {
                        //print("JSON: \(JSON)")
                        //print(response.result.value?.resultComicDay)
                        DataManager.resultComicContents = JSON.resultComicContents
                        print("resultComicDay",DataManager.resultComicContents)
                        print(DataManager.resultComicContents.count)
                        self.tableView.reloadData()
                    }
                }
            }
            //print("out:",DataManager.resultComicDay.count)
        } else if mode == "real" {
            print(mode)
            let header = ["x-access-token":DataManager.logintoken]
            let url = "http://softcomics.co.kr/comic/contentAll/"+"\(tmpComicNumber!)"
            Alamofire.request(url, method: .get, encoding: URLEncoding.default , headers: header ).responseObject{(response : DataResponse<ComicContentsDTO>) in
                if let JSON = response.result.value {
                    DataManager.resultComicContents = JSON.resultComicContents
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
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func requestComicContentFirst(){
                let url = "http://softcomics.co.kr/comic/content/first/"+String(tmpComicNumber!)
                print(url)
                Alamofire.request(url).responseObject{(response : DataResponse<ComicContentFirstDTO>) in
                    let JSON = response.result.value
                    print(JSON!)
                    print(response.response?.statusCode)
                    print(response.result.value?.resultComicContentFirst)
                    print(JSON?.resultComicContentFirst)
                    print(response.result.value?.code)
                    print(response.result.value?.message)
                        //if let JSON = response.result.value {
                        //DataManager.resultComicContentFirst.removeAll()
                    DataManager.resultComicContentFirst = JSON!.resultComicContentFirst
                    //}
                
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
    
    func giveHeartToComic(mode:String){
        if mode == "real" {
            let url = "http://softcomics.co.kr/comic/like"
            let parameters: [String: Any] = [
                "comicno":tmpComicNumber!
            ]
            let header = ["x-access-token":DataManager.logintoken]

            Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers:header).responseObject{(response : DataResponse<BaseDTO>) in
                if let JSON = response.result.value {
                    switch response.result.value?.code {
                    case 100:
                        self.comicHeart.setTitle("\(JSON.like!)", for: .normal)
                    default:
                        print(response.result.value?.code)
                        print("실패")
                    }
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "contentView" {
            guard let destination = segue.destination as? ViewWebtoonViewController else { return }
            let indexPath = tableView.indexPath(for: sender as! TableViewCell)
            if indexPath != nil{
                let currentCell = tableView.cellForRow(at: indexPath!) as! TableViewCell
                if ((tableView?.indexPathsForSelectedRows) != nil){
                    destination.tmpCotentNo = currentCell.conTentNo
                    destination.tmpContentLike = currentCell.contentLike
                    destination.tmpComicNo = currentCell.comicNo
                    destination.tmpContentRating = currentCell.contentRating
                }
            }
        }
    }
}

extension ListWebtoonTableViewContrller {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("dataManager count : ",DataManager.resultComicContents.count)
        return DataManager.resultComicContents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? TableViewCell else {print("error")
            return UITableViewCell() }
        cell.titleDetail.text = DataManager.resultComicContents[indexPath.row].contentName
        cell.gradeDetail.text = "★ "+String(format:"%.1f", DataManager.resultComicContents[indexPath.row].contentRating!)
        cell.dateDetail.text = DataManager.resultComicContents[indexPath.row].contentDate
        cell.conTentNo = DataManager.resultComicContents[indexPath.row].contentNo!
        cell.imageSumnailDetail.image = DataManager.topOfGodViewImage[indexPath.row]
        cell.contentLike = DataManager.resultComicContents[indexPath.row].contentHeart!
        cell.comicNo = DataManager.resultComicContents[indexPath.row].comicNo!
        cell.contentRating = DataManager.resultComicContents[indexPath.row].contentRating!
        return cell
    }
}

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
    var isRegister:Bool = false
    var isGivenHeart:Bool = false
    @IBOutlet weak var comicHeart: UIButton!
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var registerButton: registerButton!
    
    @IBAction func registerButtonTapped(_ sender: registerButton) {
        print(registerButton.isOn)
        registerMyComic()
    }
    
    @IBAction func giveToonHeart(_ sender: Any) {
        if isGivenHeart == false {
            giveHeartToComic(mode: "real")
            heartButton.setTitle("♥︎", for: .normal)
            heartButton.setTitleColor(.red, for: .normal)
            tmpComicNumberofHeart = tmpComicNumberofHeart! + 1
            self.comicHeart.setTitle("\(tmpComicNumberofHeart!)", for: .normal)
            let alert = UIAlertController(title: "웹툰 좋아요!", message: "좋아요 누름!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }else {
            giveHeartToComic(mode: "real")
            heartButton.setTitle("♡", for: .normal)
            heartButton.setTitleColor(.black, for: .normal)
            tmpComicNumberofHeart = tmpComicNumberofHeart! - 1
            self.comicHeart.setTitle("\(tmpComicNumberofHeart!)", for: .normal)
            let alert = UIAlertController(title: "웹툰 좋아요!", message: "좋아요 취소!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
//    @IBAction func registerMyToon(_ sender: Any) {
//        if isRegister {
//            isRegister = false
//            registerButton.setTitle("☑︎ 관심", for: .normal)
//            registerButton.setTitleColor(.black, for: .normal)
//            registerMyComic()
//
//        }else{
//            isRegister = true
//            registerButton.setTitle("☑︎ 관심", for: .normal)
//            registerButton.setTitleColor(.green, for: .normal)
//            registerMyComic()
//        }
//    }
    
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
            print("fsdjflsdjfisldjfiosdfjidosfjodsifjidos", registerButton.isOn)
        //navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: nil, action: nil)
        self.navigationController?.navigationBar.topItem!.title = tmpNaviBarTopItem
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.comicHeart.setTitle("\(tmpComicNumberofHeart!)", for: .normal)
        print("tmpComicNumber ; ",tmpComicNumber)
        
        getDatafromJson(mode: "real")
        //registerButton.isOn = true
        
    }
    
    func registerMyComic(){
        //let comment:String = commentTextField.text!
        let url = "http://softcomics.co.kr/my/comic"
        let parameters: [String: Any] = [
            "comicno":tmpComicNumber!
        ]
        //let header = ["x-access-token":DataManager.logintoken]
        let header = ["x-access-token":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJkYXRlIjoiMjAxOS0wNC0xMiAwMToyMTozNCIsInVzZXJJZCI6InRvbTEiLCJ1c2VyUHciOiJUb20xMjM0LiIsInVzZXJUeXBlIjoiMSJ9.uMunfwEPzAkq85D1_4Wr-geVb9XnDSzdqQ3tiThuZ64"]
        print(parameters)
        
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
            let url = "http://softcomics.co.kr/comic/contentAll/"+"\(tmpComicNumber!)"
            print(url)
            print("aaaaaaaaa")
            Alamofire.request(url).responseObject{(response : DataResponse<ComicContentsDTO>) in
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                    print(response.result.value?.resultComicContents)
                    DataManager.resultComicContents = JSON.resultComicContents
                    print("resultComicDay",DataManager.resultComicDay)
                    print(DataManager.resultComicContents.count)
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    
    func giveHeartToComic(mode:String){
        //var isGiven:Bool = false
        if mode == "real" {
            let url = "http://softcomics.co.kr/comic/like"
            let parameters: [String: Any] = [
                "comicno":tmpComicNumber!
            ]
//            let header = ["x-access-token":DataManager.logintoken]
            //아래는 샘플테스트.
            let header = ["x-access-token":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJkYXRlIjoiMjAxOS0wNC0xMiAwMToyMTozNCIsInVzZXJJZCI6InRvbTEiLCJ1c2VyUHciOiJUb20xMjM0LiIsInVzZXJUeXBlIjoiMSJ9.uMunfwEPzAkq85D1_4Wr-geVb9XnDSzdqQ3tiThuZ64"]

            Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers:header).responseObject{(response : DataResponse<BaseDTO>) in
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                    print(response.result.value?.code)
                    print(response.result.value?.message)
                    response.result.value?.code
                    //self.viewDidLoad()
                    switch response.result.value?.message {
                    case "만화 좋아요 누름!":
                        print(response.result.value?.message)
                        self.isGivenHeart = true
                    case "만화에 좋아요 취소":
                        print("실패")
                        self.isGivenHeart = false
                    default:
                        print("실패")
                    }
                }
                print("isGivenHeart ? : ", self.isGivenHeart)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? ViewWebtoonViewController else { return }
        let indexPath = tableView.indexPath(for: sender as! TableViewCell)
        if indexPath != nil{
            let currentCell = tableView.cellForRow(at: indexPath!) as! TableViewCell
            if ((tableView?.indexPathsForSelectedRows) != nil){
                destination.tmpCotentNo = currentCell.conTentNo
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
        cell.gradeDetail.text = "★ "+String(describing: DataManager.resultComicContents[indexPath.row].contentRating!)
        cell.dateDetail.text = DataManager.resultComicContents[indexPath.row].contentDate
        cell.conTentNo = DataManager.resultComicContents[indexPath.row].contentNo!
        cell.imageSumnailDetail.image = DataManager.topOfGodViewImage[indexPath.row]
        return cell
    }
}

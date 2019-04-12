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

class ListWebtoonTVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var isRegister:Bool = false
    var isGivenHeart:Bool = false
    @IBOutlet weak var comicHeart: UIButton!
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    @IBAction func giveToonHeart(_ sender: Any) {
        if isGivenHeart {
            heartButton.setTitle("♡", for: .normal)
            heartButton.setTitleColor(.black, for: .normal)
            tmpComicNumberofHeart = tmpComicNumberofHeart! - 1
            self.comicHeart.setTitle("\(tmpComicNumberofHeart!)", for: .normal)
            isGivenHeart = false
            //request 수정해야함.
        }else {
            heartButton.setTitle("♥︎", for: .normal)
            heartButton.setTitleColor(.red, for: .normal)
            tmpComicNumberofHeart = tmpComicNumberofHeart! + 1
            self.comicHeart.setTitle("\(tmpComicNumberofHeart!)", for: .normal)
            isGivenHeart = true
            //request 수정해야함.
        }
    }
    
    @IBAction func registerMyToon(_ sender: Any) {
        if isRegister {
            isRegister = false
            registerButton.setTitle("☑︎ 관심", for: .normal)
            registerButton.setTitleColor(.black, for: .normal)
            //request 수정해야함.

        }else{
            isRegister = true
            registerButton.setTitle("☑︎ 관심", for: .normal)
            registerButton.setTitleColor(.green, for: .normal)
            //request 수정해야함.

        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    var tmpNaviBarTopItem:String?
    var tmpComicNumber:Int?
    var tmpComicNumberofHeart:Int?

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.resultComicContents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? TableViewCell else {print("error")
            return UITableViewCell() }
        cell.titleDetail.text = DataManager.resultComicContents[indexPath.row]["Content_Name"]!! as? String
        cell.gradeDetail.text = "★ "+String(describing: DataManager.resultComicContents[indexPath.row]["Content_Rating"]!!)
        cell.dateDetail.text = DataManager.resultComicContents[indexPath.row]["Content_Date"]!! as? String
        cell.conTentNo = DataManager.resultComicContents[indexPath.row]["Content_No"] as! Int
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: nil, action: nil)
        self.navigationController?.navigationBar.topItem!.title = tmpNaviBarTopItem
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.comicHeart.setTitle("\(tmpComicNumberofHeart!)", for: .normal)
        print("tmpComicNumber ; ",tmpComicNumber)
        
        getDatafromJson(mode: "test")
        
        self.tableView.reloadData()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        // Do any additional setup after loading the view.
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
                    }
                }
            }
            //print("out:",DataManager.resultComicDay.count)
        } else if mode == "real" {
            print(mode)
        }
        self.tableView.reloadData()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? ViewWebtoonVC else { return }
        let indexPath = tableView.indexPath(for: sender as! TableViewCell)
        if indexPath != nil{
            let currentCell = tableView.cellForRow(at: indexPath!) as! TableViewCell
            if ((tableView?.indexPathsForSelectedRows) != nil){
                destination.tmpCotentNo = currentCell.conTentNo
                /*
                 destination.tempOrgTiTleToDo = ToDoManager.toDoArray[(tableView.indexPathForSelectedRow?.row)!].title!
                 destination.tempTitleToDo = ToDoManager.toDoArray[(tableView.indexPathForSelectedRow?.row)!].title!
                 destination.tempNoteToDo = ToDoManager.toDoArray[(tableView.indexPathForSelectedRow?.row)!].note!
                 destination.tempDueDateToDo = ToDoManager.toDoArray[(tableView.indexPathForSelectedRow?.row)!].dueDate!
                 destination.tempTableViewSelectedRow = tableView.indexPathForSelectedRow?.row
                 */
            }
        }
        //print("text : ", currentCell.titleLabel.text)
        
        
    }


}

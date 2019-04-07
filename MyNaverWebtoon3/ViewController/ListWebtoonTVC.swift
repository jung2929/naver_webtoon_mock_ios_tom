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
    
    @IBOutlet weak var tableView: UITableView!
    var tmpNaviBarTopItem:String?
    var tmpComicNumber:Int?

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.resultComicDay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? TableViewCell else {print("error")
            return UITableViewCell() }
        cell.titleDetail.text = "Row \((indexPath as NSIndexPath).row + 1)"
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: nil, action: nil)
        self.navigationController?.navigationBar.topItem!.title = tmpNaviBarTopItem
        self.tableView.delegate = self
        self.tableView.dataSource = self
        print("tmpComicNumber ; ",tmpComicNumber)
        
        getDatafromJson(mode: "test")
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
                        DataManager.resultComicDay = JSON.resultComicDay
                        print("resultComicDay",DataManager.resultComicDay)
                        print(DataManager.resultComicDay.count)
                    }
                }
            }
            //print("out:",DataManager.resultComicDay.count)
        } else if mode == "real" {
            print(mode)
        }
        DispatchQueue.main.async {
            //self.collectionView.reloadData()
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

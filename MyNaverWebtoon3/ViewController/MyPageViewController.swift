//
//  MyPageVC.swift
//  MyNaverWebtoon3
//
//  Created by penta on 08/04/2019.
//  Copyright © 2019 TestOrganization. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper


class MyPageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var myPageTableView: UITableView = UITableView()
    //var isLogin:Bool = true
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var segments: UISegmentedControl!
    @IBOutlet weak var bottomView: UIView!
    @IBAction func unwindToMyPageVC(segue:UIStoryboardSegue){
        self.viewDidLoad()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getDataIfLogin(logintoken: DataManager.logintoken)
        navigationController?.navigationBar.topItem?.title = "MY"
        topView.layer.addBorder([.bottom], color: UIColor.lightGray, width: 1)
        self.myPageTableView.reloadData()
        
        
        
    }
    
    func getDataIfLogin(logintoken:String){
        print(logintoken)
        let header = ["x-access-token":logintoken]
        let url = "http://softcomics.co.kr/my/comic/list"
        Alamofire.request(url, method: .get, encoding: URLEncoding.default , headers: header ).responseObject{(response : DataResponse<MyComicListDTO>) in
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
                print(response.result.value?.data)
                print(response.result.value?.code)
                print(response.result.value?.list)
                //DataManager.resultComicDay = JSON.result
                let status = response.result.value?.code
                print(status)
                switch status {
                case 100:
                    print("login")
                    DataManager.resultMyComic = (response.result.value?.list)!
                    print("DataManager.resultMyComic",DataManager.resultMyComic)
                    self.tableViewSetup(myPageTableView: self.myPageTableView, superView: self.bottomView)
                    self.myPageTableView.reloadData()
                    break
                case 200:
                    print(status)
                    //perfrom LoginVC
                    break
                case 201:
                    print(status)
                    break
                default:
                    break
                }
                
            }
        }
    }
    
    func tableViewSetup(myPageTableView:UITableView, superView:UIView){
        //let frm:CGRect = superView.frame
        let tableView = myPageTableView
        //tableView.frame = CGRect(origin: frm.origin, size: frm.size)
        //print(frm)
        tableView.register(MyPageTVC.self, forCellReuseIdentifier: "Cell")
        tableView.dataSource = self
        tableView.delegate = self
        //tableView.backgroundColor = UIColor.black
        superView.addSubview(tableView)
        superView.bringSubviewToFront(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leftAnchor.constraint(equalTo: superView.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: superView.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(DataManager.resultMyComic.count)
        return DataManager.resultMyComic.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? MyPageTVC else {print("error")
            return UITableViewCell() }
        cell.titleLabel.text = DataManager.resultMyComic[indexPath.row]["Comic_Name"]! as? String
        cell.dateLabel.text = DataManager.resultMyComic[indexPath.row]["Comic_Text"]! as? String
        cell.sumnailImg.image = DataManager.worldOfGirlsViewImage[indexPath.row]
        cell.alamImg.image = UIImage(named: "following")
        //print("aaa")
        return cell
    }

}

extension CALayer {
    func addBorder(_ arr_edge: [UIRectEdge], color: UIColor, width: CGFloat) {
        for edge in arr_edge {
            let border = CALayer()
            switch edge {
            case UIRectEdge.top:
                border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: width)
                break
            case UIRectEdge.bottom:
                border.frame = CGRect.init(x: 0, y: frame.height - width, width: frame.width+100, height: width)
                break
            case UIRectEdge.left:
                border.frame = CGRect.init(x: 0, y: 0, width: width, height: frame.height)
                break
            case UIRectEdge.right:
                border.frame = CGRect.init(x: frame.width - width, y: 0, width: width, height: frame.height)
                break
            default:
                break
            }
            border.backgroundColor = color.cgColor;
            self.addSublayer(border)
        }
    }
}

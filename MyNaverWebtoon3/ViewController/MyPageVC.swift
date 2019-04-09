//
//  MyPageVC.swift
//  MyNaverWebtoon3
//
//  Created by penta on 08/04/2019.
//  Copyright © 2019 TestOrganization. All rights reserved.
//

import UIKit

class MyPageVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var myPageTableView: UITableView = UITableView()
    var isLogin:Bool = true
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var segments: UISegmentedControl!
    @IBOutlet weak var bottomView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.topItem?.title = "MY"
        topView.layer.addBorder([.bottom], color: UIColor.lightGray, width: 1)
        if isLogin {
            tableViewSetup(myPageTableView: myPageTableView, superView: bottomView)
        }
        self.myPageTableView.reloadData()
        
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
        print(DataManager.resultComicDay.count)
        return DataManager.resultComicDay.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? MyPageTVC else {print("error")
            return UITableViewCell() }
        cell.titleLabel.text = DataManager.resultComicDay[indexPath.row]["Comic_Name"]!! as? String
        cell.dateLabel.text = DataManager.resultComicDay[indexPath.row]["Comic_Date"]!! as? String
        print("aaa")
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

//
//  SearchViewController.swift
//  MyNaverWebtoon3
//
//  Created by penta on 23/04/2019.
//  Copyright © 2019 TestOrganization. All rights reserved.
//

import UIKit
import BetterSegmentedControl
import Alamofire
import AlamofireObjectMapper

class SearchViewController: UIViewController {

    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var SelectSegment: BetterSegmentedControl!
    @IBOutlet weak var webToonTableView: UITableView!
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var webToonCount: UILabel!
    @IBOutlet weak var webToonTableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var headerOfWebtoonTableView: UIView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var mainView: UIView!
    
    var searchTextField:TextField = TextField()
    var searchString:String = ""
    var isBlur = false
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        
    }
    
    @IBAction func SelectChanged(_ sender: BetterSegmentedControl) {
        print(sender.index)
        switch sender.index {
        case 0:
            webToonTableView.reloadData()
            print("datareloaded 0")
            break
        case 1:
            webToonTableView.reloadData()
            print("datareloaded 1")
            break
        case 2:
            break
        default:
            print("default")
        }
    }
    
    @IBAction func moreWebtoon(_ sender: UIButton) {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationController()
        setupSelectSegment()
        self.searchTextField.delegate = self
        self.webToonTableView.delegate = self
        self.webToonTableView.dataSource = self
        self.view.sendSubviewToBack(mainScrollView)
        //logoImageView.image = self.setBlurImage(usingImage: UIImage(named: "logoNaverWebtoon")!, blurAmount: 20)
        self.view.bringSubviewToFront(mainView)

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
            self.searchTextField.becomeFirstResponder()
        }
    }
    
    func setNavigationController(){
        let backButton = UIBarButtonItem(title: "", style: .plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.searchTextField = TextField(frame: CGRect(x: self.view.frame.origin.x-20, y: 0, width: (self.navigationController?.navigationBar.frame.size.width)! - cancelButton.width, height: 35.0))
        self.navigationItem.titleView = searchTextField
        setSearchTextField(textField: searchTextField)
    }
    
    func setSearchTextField(textField:UITextField){
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1.0
        textField.placeholder = "제목 또는 작가명 검색"
        textField.returnKeyType = .search
        textField.clearButtonMode = .always
    }
    
    func setupSelectSegment(){
        self.SelectSegment.segments = LabelSegment.segments(withTitles: ["전체","웹툰","베스트도전"],normalFont: UIFont(name: "HelveticaNeue-Light", size: 14.0)!,
                                                               normalTextColor: .black,
                                                               selectedFont: UIFont(name: "HelveticaNeue-Bold", size: 14.0)!,         selectedTextColor: .white)
        SelectSegment.setIndex(10, animated: true)
        //(red:0.20, green:0.68, blue:0.27, alpha:1.00)
    }
    
    func setHeightWebtoonTableView(){
        UIView.animate(withDuration: 0, animations: {
            self.webToonTableView.layoutIfNeeded()
        }) { (complete) in
            var heightOfTableView: CGFloat = 0.0
            let cells = self.webToonTableView.visibleCells
            for cell in cells {
                heightOfTableView += cell.frame.height
            }
            self.webToonTableViewHeightConstraint.constant = heightOfTableView + self.headerOfWebtoonTableView.frame.height
            
        }
    }
    
    
    func setBlurMainView(){
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.prominent)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = mainView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mainView.addSubview(blurEffectView)
    }
    
    func getDatafromJson(mode:String, searchString:String){
        if mode == "real" {
            print(mode)
            let url = "http://softcomics.co.kr/comics/"+searchString
            print(url)
            Alamofire.request(url).responseObject{(response : DataResponse<ComicSearchDTO>) in
                if let JSON = response.result.value {
                    DataManager.resultComicSearch = JSON.resultComicSearch
                    self.webToonTableView.reloadData()
                    self.webToonCount.text = String(DataManager.resultComicSearch.count)
                    self.setHeightWebtoonTableView()
                }
            }
        }
    }
}




extension SearchViewController:UITextFieldDelegate, UITextViewDelegate{

    func viewDidAppear(animated: Bool) {
        self.searchTextField.becomeFirstResponder()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField.isEqual(self.searchTextField)){
            searchString =  searchTextField.text!.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
            print("Encoded UTF8 searchString : ",searchString)
            getDatafromJson(mode: "real", searchString: searchString)
            if isBlur == false{
                setBlurMainView()
                isBlur = true
            }
            self.view.bringSubviewToFront(mainScrollView)
            self.searchTextField.resignFirstResponder()
        }
        return true
    }
    
}


extension SearchViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("count : ",DataManager.resultComicSearch.count)
        print("SelectSegment.index : ",SelectSegment.index)
        if DataManager.resultComicSearch.count > 5 && SelectSegment.index == 0{
            return 5
        } else if DataManager.resultComicSearch.count <= 5 && SelectSegment.index == 0{
            return DataManager.resultComicSearch.count
        } else if SelectSegment.index == 1{
            return DataManager.resultComicSearch.count
        } else {
            print("else")
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellWebToon", for: indexPath) as? SearchWebToonTableViewCell else {print("error")
            return UITableViewCell() }
        cell.title.text = DataManager.resultComicSearch[indexPath.row].comicName
        cell.author.text = DataManager.resultComicSearch[indexPath.row].comicStory
        cell.grade.text = "★ "+String(describing: DataManager.resultComicSearch[indexPath.row].comicRating!)
        cell.imageSumnail.image = DataManager.topOfGodViewImage[indexPath.row]
        return cell
    }
    
}



class TextField: UITextField {
    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 5)
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

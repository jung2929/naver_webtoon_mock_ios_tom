//
//  ViewController.swift
//  MyNaverWebtoon3
//
//  Created by penta on 03/04/2019.
//  Copyright © 2019 TestOrganization. All rights reserved.
//

import UIKit
import AMScrollingNavbar
import Alamofire
import AlamofireObjectMapper


class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataManager.resultComicDay.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell else {print("error")
            return UICollectionViewCell() }
        //cell.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        cell.layer.borderWidth = 0.1
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.title.text = DataManager.resultComicDay[indexPath.row]["Comic_Name"]!! as? String
        cell.author.text = DataManager.resultComicDay[indexPath.row]["Comic_Story"]!! as? String
        cell.grade.text = "★ "+String(describing: DataManager.resultComicDay[indexPath.row]["Comic_Rating"]!!)
        cell.grade.textColor = .red
        print("comicrating ",DataManager.resultComicDay[indexPath.row]["Comic_Rating"]!!)
        cell.sumnail.image = DataManager.mainCollectionViewImage[indexPath.row]
        cell.comicNumber = DataManager.resultComicDay[indexPath.row]["Comic_No"]! as! Int
        cell.comicNumberOfHeart = DataManager.resultComicDay[indexPath.row]["Comic_Heart"]! as! Int
        return cell
    }
    
    
    
    @IBOutlet weak var topScrollView: UIScrollView!
    @IBOutlet var collectionView: UICollectionView!
    var testImage = [UIImage]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //title = "title"
        //navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: nil, action: nil)
        //navigationController?.navigationBar.barTintColor = UIColor(red:0.91, green:0.3, blue:0.24, alpha:1)
        
        
        initArrays()
        setupDayScrollView()
        setupCollectionView()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        DispatchQueue.global(qos: .userInteractive).async {
            self.getComicDayDatafromJson(mode: "real")
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
        
    }
    
    func setupCollectionView(){
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        let cellSizeWidth = (CGFloat.minimum(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) - 2) / 3;
        let cellSizeHeight = (CGFloat.minimum(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) - 2) / 3;
        flowLayout.itemSize = CGSize(width: cellSizeWidth, height: cellSizeHeight)
        flowLayout.scrollDirection = .vertical
        collectionView?.collectionViewLayout = flowLayout
        collectionView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func setupDayScrollView(){
        testImage = [#imageLiteral(resourceName: "메인뷰광고2"),#imageLiteral(resourceName: "메인뷰광고3"),#imageLiteral(resourceName: "메인뷰광고1")]
        topScrollView.isPagingEnabled = true
        topScrollView.contentMode = .scaleAspectFit
        for i in 0..<testImage.count{
            let imgView = UIImageView()
            imgView.image = testImage[i]
            let xPosition = self.topScrollView.frame.width * CGFloat(i)
            imgView.frame = CGRect(x: xPosition, y: 0, width: self.topScrollView.frame.width, height: self.topScrollView.frame.height)
            topScrollView.contentSize.width = topScrollView.frame.width * (CGFloat(i) + 1)
            topScrollView.addSubview(imgView)
        }
    }
    
    
    func getComicDayDatafromJson(mode:String){
        if mode == "test" {
            print(mode)
            if let path = Bundle.main.path(forResource: "ComicDayDTOTest", ofType: "json") {
                let url=URL(fileURLWithPath: path)
                Alamofire.request(url).responseObject {(response : DataResponse<ComicDayDTO>) in
                    if let JSON = response.result.value {
                        //print("JSON: \(JSON)")
                        //print(response.result.value?.resultComicDay)
                        DataManager.resultComicDay = JSON.result
                        print("resultComicDay",DataManager.resultComicDay)
                        print(DataManager.resultComicDay.count)
                        self.collectionView.reloadData()
                    }
                }
            }
            //print("out:",DataManager.resultComicDay.count)
        } else if mode == "real" {
            print(mode)
            let url = "http://softcomics.co.kr/comic/day/Monday"
           // DispatchQueue.global(qos:.userInteractive).async {
            print(url)
                Alamofire.request(url).responseObject{(response : DataResponse<ComicDayDTO>) in
                    if let JSON = response.result.value {
                        print("JSON: \(JSON)")
                        print(response.result.value?.result)
                        DataManager.resultComicDay = JSON.result
                        print("resultComicDay",DataManager.resultComicDay)
                        print(DataManager.resultComicDay.count)
                        self.collectionView.reloadData()
                    }
                }
            //}
        }
//        DispatchQueue.main.async {
//            self.collectionView.reloadData()
//        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? ListWebtoonTVC else { return }
        let indexPath = collectionView.indexPath(for: sender as! CollectionViewCell)
        if indexPath != nil{
            let currentCell = collectionView.cellForItem(at: indexPath!) as! CollectionViewCell
            if ((collectionView?.indexPathsForSelectedItems) != nil){
                
                destination.tmpNaviBarTopItem = currentCell.title.text
                destination.tmpComicNumber = currentCell.comicNumber
                destination.tmpComicNumberofHeart = currentCell.comicNumberOfHeart
            }
        }
        
        
    }
    
    func initArrays(){
        DataManager.comments.removeAll()
        DataManager.resultComicContents.removeAll()
        DataManager.resultComicDay.removeAll()
        DataManager.resultMyComic.removeAll()
        DataManager.mainCollectionViewImage = [UIImage(named: "신의탑메인섬네일"), UIImage(named: "소녀의세계메인섬네일")] as! [UIImage]
        DataManager.topOfGodViewImage = [UIImage(named: "신의탑컨텐츠섬네일1"), UIImage(named: "신의탑컨텐츠섬네일2"),UIImage(named: "신의탑컨텐츠섬네일3"), UIImage(named: "신의탑컨텐츠섬네일4"),UIImage(named: "신의탑컨텐츠섬네일5"), UIImage(named: "신의탑컨텐츠섬네일6"),UIImage(named: "신의탑컨텐츠섬네일7"), UIImage(named: "신의탑컨텐츠섬네일8"),UIImage(named: "신의탑컨텐츠섬네일9") ] as! [UIImage]
        DataManager.worldOfGirlsViewImage = [ UIImage(named: "소녀의세계컨텐츠섬네일1"), UIImage(named: "소녀의세계컨텐츠섬네일2"),UIImage(named: "소녀의세계컨텐츠섬네일3"), UIImage(named: "소녀의세계컨텐츠섬네일4"),UIImage(named: "소녀의세계컨텐츠섬네일5"), UIImage(named: "소녀의세계컨텐츠섬네일6"),UIImage(named: "소녀의세계컨텐츠섬네일7"), UIImage(named: "소녀의세계컨텐츠섬네일8"),UIImage(named: "소녀의세계컨텐츠섬네일9")] as! [UIImage]
    }
    

    @objc func pushToNextVC() {
        let newVC = UIViewController()
        newVC.view.backgroundColor = UIColor.red
        self.navigationController?.pushViewController(newVC, animated:
            true)
    }
}


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
import BetterSegmentedControl

class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var topSlideCollectionView: UICollectionView!
    @IBOutlet weak var dayView: UIView!
    @IBOutlet weak var headerConnectConstraint: NSLayoutConstraint!
    @IBOutlet weak var adViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomAdView: UIImageView!
    @IBOutlet weak var pageView: UIPageControl!
    @IBOutlet weak var daySelectSegment: BetterSegmentedControl!
    @IBAction func daySelectChanged(_ sender: BetterSegmentedControl) {
        print(sender.index)
    }
    
    var testImage = [UIImage]()
    var timer = Timer()
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "조회순"
        self.navigationController?.navigationBar.isHidden = true
        
        initArrays()
        testImage = [#imageLiteral(resourceName: "메인뷰광고2"),#imageLiteral(resourceName: "메인뷰광고3"),#imageLiteral(resourceName: "메인뷰광고1")]
        
        pageView.currentPage = 0
        pageView.numberOfPages = testImage.count
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
        
        setupCollectionView()
        setupTopSlideCollectionView()
        setupDaySelectSegment()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.topSlideCollectionView.delegate = self
        self.topSlideCollectionView.dataSource = self
        self.getComicDayDatafromJson(mode: "test")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.title = "조회순"
        self.tabBarController?.title = "웹툰"
        self.navigationController?.navigationBar.isHidden = true
        super.viewWillAppear(animated)
    }
    
    func setupDaySelectSegment(){
        self.daySelectSegment.segments = LabelSegment.segments(withTitles: ["월","화","수","목","금","토","일","완결","신작"],normalFont: UIFont(name: "HelveticaNeue-Light", size: 14.0)!,
                                                               normalTextColor: .black,
                                                               selectedFont: UIFont(name: "HelveticaNeue-Bold", size: 14.0)!,         selectedTextColor: .white)
        daySelectSegment.setIndex(10, animated: true)
        //(red:0.20, green:0.68, blue:0.27, alpha:1.00)
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
    
    func setupTopSlideCollectionView(){
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        let cellSizeWidth = (CGFloat.minimum(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height));
        let cellSizeHeight = (CGFloat.minimum(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height));
        flowLayout.itemSize = CGSize(width: cellSizeWidth, height: cellSizeHeight)
        flowLayout.scrollDirection = .horizontal
        topSlideCollectionView?.collectionViewLayout = flowLayout
        topSlideCollectionView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    @objc func changeImage(){
        if counter < testImage.count {
            let index = IndexPath(item: counter, section: 0)
            self.topSlideCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageView.currentPage = counter
            counter += 1
        } else {
            counter = 0
            let index = IndexPath(item: counter, section: 0)
            self.topSlideCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageView.currentPage = counter
            counter = 1
        }
    }
    
    func getComicDayDatafromJson(mode:String){
        if mode == "test" {
            print(mode)
            if let path = Bundle.main.path(forResource: "ComicDayDTOTest", ofType: "json") {
                let url=URL(fileURLWithPath: path)
                Alamofire.request(url).responseObject {(response : DataResponse<ComicDayDTO>) in
                    if let JSON = response.result.value {
                        //print("JSON: \(JSON)")F
                        //print(response.result.value?.resultComicDay)
                        DataManager.resultComicDay = JSON.result
//                        print("resultComicDay",DataManager.resultComicDay)
//                        print(DataManager.resultComicDay.count)
                        self.collectionView.reloadData()
                    }
                }
            }
        } else if mode == "real" {
            print(mode)
            let url = "http://softcomics.co.kr/comic/day/Monday"
            print(url)
                Alamofire.request(url).responseObject{(response : DataResponse<ComicDayDTO>) in
                    if let JSON = response.result.value {
//                        print("JSON: \(JSON)")
//                        print(response.result.value?.result)
                        DataManager.resultComicDay = JSON.result
//                        print("resultComicDay",DataManager.resultComicDay)
//                        print(DataManager.resultComicDay.count)
                        self.collectionView.reloadData()
                    }
                }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? ListWebtoonTableViewContrller else { return }
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
        DataManager.mainCollectionViewImage = [UIImage(named: "신의탑메인섬네일"), UIImage(named: "소녀의세계메인섬네일"), UIImage(named: "소녀의세계메인섬네일"), UIImage(named: "소녀의세계메인섬네일"), UIImage(named: "소녀의세계메인섬네일"), UIImage(named: "소녀의세계메인섬네일"), UIImage(named: "소녀의세계메인섬네일"), UIImage(named: "소녀의세계메인섬네일"), UIImage(named: "소녀의세계메인섬네일"), UIImage(named: "소녀의세계메인섬네일"), UIImage(named: "소녀의세계메인섬네일"), UIImage(named: "소녀의세계메인섬네일"), UIImage(named: "소녀의세계메인섬네일"), UIImage(named: "소녀의세계메인섬네일"), UIImage(named: "소녀의세계메인섬네일"), UIImage(named: "소녀의세계메인섬네일"), UIImage(named: "소녀의세계메인섬네일"), UIImage(named: "소녀의세계메인섬네일"), UIImage(named: "소녀의세계메인섬네일"), UIImage(named: "소녀의세계메인섬네일"), UIImage(named: "소녀의세계메인섬네일"), UIImage(named: "소녀의세계메인섬네일"), UIImage(named: "소녀의세계메인섬네일"), UIImage(named: "소녀의세계메인섬네일")] as! [UIImage]
        DataManager.topOfGodViewImage = [UIImage(named: "신의탑컨텐츠섬네일1"), UIImage(named: "신의탑컨텐츠섬네일2"),UIImage(named: "신의탑컨텐츠섬네일3"), UIImage(named: "신의탑컨텐츠섬네일4"),UIImage(named: "신의탑컨텐츠섬네일5"), UIImage(named: "신의탑컨텐츠섬네일6"),UIImage(named: "신의탑컨텐츠섬네일7"), UIImage(named: "신의탑컨텐츠섬네일8"),UIImage(named: "신의탑컨텐츠섬네일9"), UIImage(named: "신의탑컨텐츠섬네일8"),UIImage(named: "신의탑컨텐츠섬네일9"), UIImage(named: "신의탑컨텐츠섬네일8"),UIImage(named: "신의탑컨텐츠섬네일9"), UIImage(named: "신의탑컨텐츠섬네일8"),UIImage(named: "신의탑컨텐츠섬네일9"), UIImage(named: "신의탑컨텐츠섬네일8"),UIImage(named: "신의탑컨텐츠섬네일9") ] as! [UIImage]
        DataManager.worldOfGirlsViewImage = [ UIImage(named: "소녀의세계컨텐츠섬네일1"), UIImage(named: "소녀의세계컨텐츠섬네일2"),UIImage(named: "소녀의세계컨텐츠섬네일3"), UIImage(named: "소녀의세계컨텐츠섬네일4"),UIImage(named: "소녀의세계컨텐츠섬네일5"), UIImage(named: "소녀의세계컨텐츠섬네일6"),UIImage(named: "소녀의세계컨텐츠섬네일7"), UIImage(named: "소녀의세계컨텐츠섬네일8"),UIImage(named: "소녀의세계컨텐츠섬네일9")] as! [UIImage]
    }
}

extension MainViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView {
            return DataManager.resultComicDay.count
        } else {
            return testImage.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell else {print("error")
                return UICollectionViewCell() }
            cell.layer.borderWidth = 0.1
            cell.layer.borderColor = UIColor.gray.cgColor
            cell.title.text = DataManager.resultComicDay[indexPath.row].comicName
            cell.author.text = DataManager.resultComicDay[indexPath.row].comicStory
            cell.grade.text = "★ "+String(describing: DataManager.resultComicDay[indexPath.row].comicRating!)
            cell.grade.textColor = .red
            cell.sumnail.image = DataManager.mainCollectionViewImage[indexPath.row]
            cell.comicNumber = DataManager.resultComicDay[indexPath.row].comicNo!
            cell.comicNumberOfHeart = DataManager.resultComicDay[indexPath.row].comicHeart!
            return cell
        } else {
            //print("good")
                let adCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AdCell", for: indexPath) as UICollectionViewCell
            if let vc = adCell.viewWithTag(123) as? UIImageView{
                vc.image = testImage[indexPath.row]
            }else if let ab = adCell.viewWithTag(124) as? UIPageControl{
                ab.currentPage = indexPath.row
            }
                return adCell
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.collectionView{
            let scrollOffset = scrollView.contentOffset.y
            //print(scrollOffset)
            if (scrollOffset <= 0)
            {
                //print("didscrolltotop")
                navigationController?.navigationBar.isHidden=true
                headerConnectConstraint.constant = 0
                adViewConstraint.constant = -60
                UIView.animate(withDuration: 0.2) {
                    self.view.layoutIfNeeded()
                }
            } else if (scrollOffset > 0){
                //print("scrolled")
                navigationController?.navigationBar.isHidden=false
                adViewConstraint.constant = (self.tabBarController?.tabBar.frame.height)!-90
                headerConnectConstraint.constant = -100
                UIView.animate(withDuration: 0.2) {
                    self.view.layoutIfNeeded()

                }
            }
        }
    }
}

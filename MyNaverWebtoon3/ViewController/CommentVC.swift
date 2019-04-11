//
//  CommentVC.swift
//  MyNaverWebtoon3
//
//  Created by penta on 12/04/2019.
//  Copyright © 2019 TestOrganization. All rights reserved.
//

import UIKit

class CommentVC: UIViewController, UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as? CommentCellTableViewCell else {print("error")
            return UITableViewCell() }
        //cell.bestLabel.text = "best"
        cell.commentLabel.text = "commnet"
        cell.dateLabel.text = "date"
        cell.idLabel.text = "id"
        return cell
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var bestComment: UIButton!
    @IBOutlet weak var allComment: UIButton!
    
    @IBAction func bestCommentTapped(_ sender: Any) {
    }
    @IBAction func allCommentTapped(_ sender: Any) {
    }
    
    @IBAction func goodTapped(_ sender: Any) {
    }
    @IBAction func badTapped(_ sender: Any) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        // Do any additional setup after loading the view.
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

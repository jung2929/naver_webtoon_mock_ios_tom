//
//  LoginVC.swift
//  MyNaverWebtoon3
//
//  Created by penta on 09/04/2019.
//  Copyright © 2019 TestOrganization. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class LoginVC: UIViewController {

    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    @IBAction func test(_ sender: Any) {
    }
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        let url = "http://softcomics.co.kr/token/"+idTextField.text!+"/"+pwTextField.text!
        // DispatchQueue.global(qos:.userInteractive).async {
        print(url)
        Alamofire.request(url).responseObject{(response : DataResponse<LoginDTO>) in
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
                print(response.result.value?.code)
                print(response.result.value?.message)
                print(response.result.value?.result)
                //DataManager.resultComicDay = JSON.result
                let status = response.result.value?.code
                print(status)
                switch status {
                case 100:
                    print("login")
                    DataManager.loginFlag = true
                    print(DataManager.loginFlag)
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "unwindMyPageVC", sender: nil)
                    }
                    break
                case 200:
                    print(status)
                    self.errorLabel.text = "아이디나 패스워드를 확인해주세요."
                    break
                case 201:
                    self.errorLabel.text = "아이디나 패스워드를 확인해주세요."
                    print(status)
                    break
                default:
                    break
                }
                
            }
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.text = ""
        //self.performSegue(withIdentifier: "unwindMyPageVC", sender: nil)
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("in")
        if segue.identifier == "unwindMyPageVC" {
            let vc = segue.destination as! MyPageVC
            print("in")
            vc.navigationItem.title = idTextField.text
            //vc.viewDidLoad()
            //vc.viewWillAppear(true)
        }
    }

}

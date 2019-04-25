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

class LoginVeiwController: UIViewController {

    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    @IBAction func test(_ sender: Any) {
    }
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        let url = "http://softcomics.co.kr/user/fcm"
        let parameters: [String: Any] = [
            "id":idTextField.text!,
            "pw":pwTextField.text!,
            "fcm":"testfcmtoken"
        ]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseObject{(response : DataResponse<LoginDTO>) in
            if let JSON = response.result.value {
                let status = response.result.value?.code
                print(status)
                switch status {
                case 100:
                    print("login")
                    DataManager.logintoken = response.result.value?.result["jwt"] as! String
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "unwindMyPageVC", sender: nil)
                    }
                    break
                case 200:
                    self.errorLabel.text = "아이디나 패스워드를 확인해주세요."
                    break
                case 201:
                    self.errorLabel.text = "아이디나 패스워드를 확인해주세요."
                    break
                default:
                    self.errorLabel.text = "아이디나 패스워드를 확인해주세요."
                    break
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.text = ""
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("in")
        if segue.identifier == "unwindMyPageVC" {
            let vc = segue.destination as! MyPageViewController
            print("in")
            vc.navigationItem.title = idTextField.text
        }
    }
}

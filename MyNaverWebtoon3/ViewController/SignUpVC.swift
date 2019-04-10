//
//  SignUpVC.swift
//  MyNaverWebtoon3
//
//  Created by penta on 08/04/2019.
//  Copyright © 2019 TestOrganization. All rights reserved.
//

import UIKit
import AlamofireObjectMapper
import Alamofire

class SignUpVC: UIViewController {

    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var subpwTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var telTextField: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        
        let id = idTextField.text
        let pw = pwTextField.text
        let subpw = pwTextField.text
        let email = emailTextField.text
        let tel = telTextField.text
        
        let url = "http://softcomics.co.kr/user"
        let parameters: [String: String] = [
            "id" : id!,
            "pw" : pw!,
            "subpw" : subpw!,
            "mail" : email!,
            "tel" : tel!
        ]
        print(parameters)
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                let status = response.response?.statusCode
                print(status)
                switch status {
                case 100:
                    self.performSegue(withIdentifier: "LoginVC", sender: nil)
                    break
                case 200:
                    self.errorLabel.text = "아이디나 패스워드를 확인해주세요."
                    break
                case 201:
                    self.errorLabel.text = "아이디나 패스워드를 확인해주세요."
                    break
                case 202:
                    self.errorLabel.text = "중복된 이메일이 이미 있습니다."
                    break
                case 203:
                    self.errorLabel.text = "이메일 형식이 잘못되었습니다."
                    break
                default:
                    break
                }
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.text = ""
    }
    

    func validateString(validateValue:String ,value:String){
        
        switch validateValue {
        case "email":
            break
        case "tel":
            break
        default:
            break
        }
        
    }

}

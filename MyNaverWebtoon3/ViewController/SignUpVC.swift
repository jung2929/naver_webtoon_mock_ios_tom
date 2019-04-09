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
        print(url)
        Alamofire.request(url).responseObject{(response : DataResponse<userDTO>) in
            let JSON = response.result.value
                print("JSON: \(JSON)")
                print(response.result.value?.code)
                print(response.result.error)
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

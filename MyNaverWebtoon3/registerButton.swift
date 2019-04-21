//
//  registerButton.swift
//  MyNaverWebtoon3
//
//  Created by penta on 21/04/2019.
//  Copyright © 2019 TestOrganization. All rights reserved.
//

import UIKit

class registerButton: UIButton {

    var isOn:Bool = false
    override init(frame: CGRect) {
        super.init(frame: frame)
        initButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initButton()
    }
    func initButton(){
        setTitleColor(UIColor.black, for: .normal)
        addTarget(self, action: #selector(registerButton.buttonPressed), for: .touchUpInside)
    }
    
    @objc func buttonPressed(){
        activateButton(bool: !isOn)
    }
    
    func activateButton(bool: Bool){
        isOn = bool
        let color = bool ? UIColor.black : .gray
        let title = bool ? "☑︎ 관심" : "⎕ 관심"
        setTitle(title, for: .normal)
        setTitleColor(color, for: .normal)
    }
}

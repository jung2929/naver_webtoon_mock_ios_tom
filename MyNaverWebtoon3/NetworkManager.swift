//
//  NetworkManager.swift
//  MyNaverWebtoon3
//
//  Created by penta on 20/04/2019.
//  Copyright © 2019 TestOrganization. All rights reserved.
//

import UIKit

    class NetworkManager {
        
        // MARK: - Properties
        
        private static var sharedNetworkManager: NetworkManager = {
            let networkManager = NetworkManager(baseURL: URL(string: "http://softcomics.co.kr")!)
            
            // Configuration
            // ...
            
            return networkManager
        }()
        
        // MARK: -
        
        let baseURL: URL
        
        // Initialization
        
        private init(baseURL: URL) {
            self.baseURL = baseURL
        }
        
        // MARK: - Accessors
        
        class func shared() -> NetworkManager {
            return sharedNetworkManager
        }
        
    }


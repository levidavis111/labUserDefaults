//
//  UserDefaultsWrapper.swift
//  lab-user-defaults
//
//  Created by Levi Davis on 9/24/19.
//  Copyright © 2019 Levi Davis. All rights reserved.
//

import Foundation

class UserDefaultsWrapper {
    static let manager = UserDefaultsWrapper()
    
    
    //MARK: - Getters
    func getUserName() -> String? {
        return UserDefaults.standard.value(forKey: userNameKey) as? String
    }
    
    func getDate() -> Date? {
        return UserDefaults.standard.value(forKey: dateKey) as? Date
    }
    
    func getHoroscope() -> String? {
        return UserDefaults.standard.value(forKey: horoscopeKey) as? String
    }
    
    
    //MARK: - Setters
    
    func store(userName: String) {
        UserDefaults.standard.set(userName, forKey: userNameKey)
    }
    func store(date: Date) {
        UserDefaults.standard.set(date, forKey: dateKey)
    }
    
    func store(horoscope: String) {
        UserDefaults.standard.set(horoscope, forKey: horoscopeKey)
    }
//    func store(userName: String) {
//        UserDefaults.standard.set(userName, forKey: userNameKey)
//    }
    
    
    
    //MARK: - keyNames
    private let userNameKey  = "userName"
    private let dateKey = "date"
    private let horoscopeKey = "horoscope"
}

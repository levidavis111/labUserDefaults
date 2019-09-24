//
//  ViewController.swift
//  lab-user-defaults
//
//  Created by Levi Davis on 9/24/19.
//  Copyright © 2019 Levi Davis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var horoscope: Horoscope?
    
    var userName: String = "" {
        didSet {
            performLabelTextUpdates()
            UserDefaultsWrapper.manager.store(userName: userName)
        }
    }
    
    var date = Date() {
        didSet {
            performDateUpdate()
            UserDefaultsWrapper.manager.store(date: date)
        }
    }
    
    @IBOutlet weak var nameDisplayOutlet: UILabel!
    @IBOutlet weak var nameTextFieldOutlet: UITextField!
    @IBOutlet weak var datePickerOutlet: UIDatePicker!
    
    @IBAction func datePickerAction(_ sender: UIDatePicker) {
        
        date = sender.date
    }
    @IBAction func readHoroscopeButtonPressed(_ sender: Any) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is HoroscopeDetailViewController {
            guard let horoscopeVC = segue.destination as? HoroscopeDetailViewController else {return}
            horoscopeVC.horoscope = horoscope
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextFieldOutlet.delegate = self
        loadDefaultSettings()
        loadData()
    }
    
    private func loadDefaultSettings() {
        if let name = UserDefaultsWrapper.manager.getUserName() {
            userName = name
        }
        
        if let date = UserDefaultsWrapper.manager.getDate() {
            self.date = date
        }
        
    }

    private func performLabelTextUpdates() {
        guard userName != "" else {
            nameDisplayOutlet.text = "NAME"
            return
        }
        nameDisplayOutlet.text = userName
        
    }
    
    private func performDateUpdate() {
        datePickerOutlet.date = date
    }
    
    private func loadData() {
        HoroscopeAPIManager.manager.getHoroscope { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let horoscope):
                self.horoscope = horoscope
            }
        }
    }
   

}

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text else {
            return false
        }
        let range = Range(range, in: text)!
        let newText = text.replacingCharacters(in: range, with: string)
        userName = newText
        return true
    }
}

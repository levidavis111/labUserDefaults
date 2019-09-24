//
//  HoroscopeDetailViewController.swift
//  lab-user-defaults
//
//  Created by Levi Davis on 9/24/19.
//  Copyright © 2019 Levi Davis. All rights reserved.
//

import UIKit

class HoroscopeDetailViewController: UIViewController {
    
    var horoscope: Horoscope! 

    @IBOutlet weak var horoscopeTextViewOutlet: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHoroscope()
        // Do any additional setup after loading the view.
    }
    

    private func setupHoroscope() {
        horoscopeTextViewOutlet.text = horoscope.horoscope
    }

}

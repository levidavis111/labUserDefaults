//
//  Horoscope.swift
//  lab-user-defaults
//
//  Created by Levi Davis on 9/24/19.
//  Copyright © 2019 Levi Davis. All rights reserved.
//

import Foundation

struct Horoscope: Codable {
    
    let sunsign: String
    let horoscope: String
    
    static func getHoroscope(from jsonData: Data) throws -> Horoscope {
        let response = try JSONDecoder().decode(Horoscope.self, from: jsonData)
        return response
    }
    
}


//{
//    "sunsign": "Gemini",
//    "credit": "(c) Kelli Fox, The Astrologer, http://new.theastrologer.com",
//    "date": "2018-03-09",
//    "horoscope": "The world is your oyster today. So what are you waiting for? Get out there and find your adventure. It's a
//    perfect day for learning something new. This can be formalized through taking a class, or it can be an informal,
//    impromptu process. That's what 'the world is your oyster' means -- your pearl of knowledge is out there, just waiting to
//    be discovered. So where will you search for it first?(c) Kelli Fox, The Astrologer, http://new.theastrologer.com",
//        "meta": {
//            "mood": "strange",
//            "keywords": "one-sided, fervor",
//            "intensity": "87%"
//    }
//}

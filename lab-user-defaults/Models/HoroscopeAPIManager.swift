//
//  HoroscopeAPIManager.swift
//  lab-user-defaults
//
//  Created by Levi Davis on 9/24/19.
//  Copyright © 2019 Levi Davis. All rights reserved.
//

import Foundation

struct HoroscopeAPIManager {
    static let manager = HoroscopeAPIManager()
    
    func getHoroscope(sign: String, completionHandler: @escaping (Result<Horoscope, AppError>) -> () ) {
        let urlStr = "http://sandipbgt.com/theastrologer/api/horoscope/\(sign)/today"
        guard let url = URL(string: urlStr) else {completionHandler(.failure(.badURL))
            return}
        
        
        NetworkManager.manager.performDataTask(url: url, httpMethod: .get) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                do {
                    let horoscope = try Horoscope.getHoroscope(from: data)
                    completionHandler(.success(horoscope))
                } catch {
                    completionHandler(.failure(.couldNotParseJSON(rawError: error)))
                }
            }
        }
    }
    
//    func getPodcasts(searchWord: String, completionHandler: @escaping (Result<[Podcast], AppError>) -> Void) {
//        let urlStr = "https://itunes.apple.com/search?media=podcast&limit=200&term=\(searchWord)"
//        guard let url = URL(string: urlStr) else {
//            completionHandler(.failure(.badURL))
//            return
//        }
//
//
//        NetworkHelper.manager.performDataTask(withUrl: url, andMethod: .get) { (result) in
//            switch result {
//            case .failure(let error) :
//                completionHandler(.failure(error))
//            case .success(let data):
//                do {
//                    let podcastInfo = try JSONDecoder().decode(PodcastInfo.self, from: data)
//                    completionHandler(.success(podcastInfo.results))
//                } catch {
//                    completionHandler(.failure(.couldNotParseJSON(rawError: error)))
//                }
//            }
//        }
//    }
    
//    private var horoscopeURL: URL {
//        guard let url = URL(string: "http://sandipbgt.com/theastrologer/api/horoscope/gemini/today") else {fatalError("Error: Invalid URL")}
//        return url
//    }
    private init() {}
}


//struct ElementAPIClient {
//
//    static let manager = ElementAPIClient()
//
//    func getElements(completionHandler: @escaping (Result<[Element], AppError>) -> () ) {
//        NetworkManager.manager.performDataTask(url: elementURL, httpMethod: .get) { (result) in
//            switch result {
//            case .failure(let error):
//                completionHandler(.failure(error))
//                return
//            case .success(let data):
//                do {
//                    let elements = try Element.getElements(from: data)
//                    completionHandler(.success(elements))
//                } catch {
//                    completionHandler(.failure(.couldNotParseJSON(rawError: error)))
//                }
//            }
//        }
//    }
//
//    private var elementURL: URL {
//        guard let url = URL(string: "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/elements") else {fatalError("Error: Invalid URL")}
//        return url
//    }
//
//    private init() {}
//
//}

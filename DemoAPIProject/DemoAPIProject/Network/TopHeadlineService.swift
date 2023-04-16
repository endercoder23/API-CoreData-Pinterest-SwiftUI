//
//  TopHeadlineService.swift
//  DemoAPIProject
//
//  Created by Raj Saija on 15/04/23.
//

import Foundation
import Combine


class TopHeadlineService {
    static let shared = TopHeadlineService()
    
    func getTopHeadlines() -> AnyPublisher<TopHeadlines, Error> {
        
        let baseURL = "https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=c424ca6c28544b2c8ae283a117fd2dfe"
        
        let request = URL(string: baseURL)
        guard let request = request else {
            return Fail(error: NSError(domain: "Missing Feed URL", code: -10001, userInfo: nil)).eraseToAnyPublisher()
        }
        
        return NetworkManager.shared.callAPI(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}

//
//  MainViewController.swift
//  The Grint Test
//
//  Created by Pedro Toro on 4/3/24.
//

import SwiftKeychainWrapper
import Alamofire

class RedditNewsViewModel {
    
    private var token: String?
    weak var delegate: RedditNewsViewModelDelegate?
    var reddit: Reddit?
    var isLoading = false
    var posts: [Children] = []
    
    func setup(delegate: RedditNewsViewModelDelegate?) {
        self.delegate = delegate
        getToken()
    }
    
}

extension RedditNewsViewModel {
    
    var isReachable: Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
        
    func getToken() {
        let url = "https://www.reddit.com/api/v1/access_token"
        let oAuthUsername = "vUc7qh_32phto_WBe9JOwQ"
        let oAuthPassword = "wnBu7bk1J5hYUkD-aQr8f_VA1GEPYQ"
        let parameters: [String: String] = [
            "username": "PeterBull92",
            "password": "pedro82078951",
            "grant_type": "password"
        ]
        
        guard isReachable else {
            if let reddit = JsonUtilities.shared.decode(object: KeychainWrapper.standard[.reddit], as: Reddit.self),
               let posts = JsonUtilities.shared.decode(object: KeychainWrapper.standard[.posts], as: [Children].self) {
                self.reddit = reddit
                self.posts = posts
            }
            delegate?.onFinish()
            return
        }
        
        delegate?.onLoad()
        
        AF.request(url, method: .post, parameters: parameters, encoder: URLEncodedFormParameterEncoder(destination: .httpBody))
            .authenticate(username: oAuthUsername, password: oAuthPassword)
            .response { [weak self] response in
                guard let self else { return }
                switch response.result {
                    case .success where (200..<300).contains(response.response?.statusCode ?? 0):
                        guard let authResponse = response.data else { return }
                        
                        let auth = JsonUtilities.shared.decode(object: authResponse, as: AuthResponse.self)
                        self.token = auth?.token
                        
                        self.getRedditPosts()
                    case .failure(let error):
                        self.delegate?.onError(error: error)
                    default:
                        let message = "status code \(response.response?.statusCode ?? 0)"
                        let error = NSError(domain: message, code: 0)
                        self.delegate?.onError(error: error)
                }
            }
    }
    
    func getRedditPosts() {
        guard let bearer = token else {
            getToken()
            return
        }
        
        guard isReachable else {
            if let reddit = JsonUtilities.shared.decode(object: KeychainWrapper.standard[.reddit], as: Reddit.self),
               let posts = JsonUtilities.shared.decode(object: KeychainWrapper.standard[.posts], as: [Children].self) {
                self.reddit = reddit
                self.posts = posts
            }
            delegate?.onFinish()
            return
        }
        
        let url = "https://oauth.reddit.com/top"
        
        let parameters: Parameters = [
            "limit": 10,
            "count": posts.count,
            "after": reddit?.data.after ?? ""
        ]
        
        let headers: HTTPHeaders = [
            "User-Agent": "ChangeMeClient/0.1 by YourUsername",
            "Authorization": "bearer " + bearer
        ]
        
        
        isLoading = true
        
        AF.request(url, method: .get, parameters: parameters, headers: headers).response { [weak self] response in
            guard let self else { return }
            switch response.result {
                case .success where (200..<300).contains(response.response?.statusCode ?? 0):
                    guard let redditResponse = response.data else { return }
                  
                    KeychainWrapper.standard[.reddit] = JsonUtilities.shared.encode(object: redditResponse)
                    self.reddit = JsonUtilities.shared.decode(object: redditResponse, as: Reddit.self)
                    
                    self.reddit?.data.children.forEach { post in
                        self.posts.append(post)
                    }
                    
                    KeychainWrapper.standard[.posts] = JsonUtilities.shared.encode(object: self.posts)
                    
                    self.isLoading = false
                    self.delegate?.onFinish()
                case .failure(let error):
                    self.delegate?.onError(error: error)
                default:
                    let message = "status code \(response.response?.statusCode ?? 0)"
                    let error = NSError(domain: message, code: 0)
                    self.delegate?.onError(error: error)
            }
        }
    }
    
}

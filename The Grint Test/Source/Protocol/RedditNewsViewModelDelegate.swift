//
//  MainViewController.swift
//  The Grint Test
//
//  Created by Pedro Toro on 4/5/24.
//

import Foundation

protocol RedditNewsViewModelDelegate: AnyObject {
    func onFinish()
    func onError(error: Error)
    func onLoad()
}

//
//  MainViewController.swift
//  The Grint Test
//
//  Created by Pedro Toro on 4/4/24.
//

import UIKit
import SafariServices

extension UIViewController {
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func showDetail(urlString: String?) {
        guard let urlString = urlString, let url = URL(string: urlString) else { return }
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = true
        let safari = SFSafariViewController(url: url, configuration: config)
        navigationController?.pushViewController(safari, animated: true)
    }
    
}


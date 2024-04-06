//
//  DetailViewController.swift
//  The Grint Test
//
//  Created by Pedro Toro on 4/5/24.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    @IBOutlet weak var textViewDescription: UITextView!
    @IBOutlet weak var detailImageView: UIImageView!
    
    var post: Post!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        detailImageView.layer.cornerRadius = 3
    }
    
    func setupSubviews() {
        textViewDescription.text = post.title
        let imageUrl = URL(string: post.thumbnail)
        
        detailImageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeHolder"))
        
        navigationController?.navigationBar.tintColor = .white
    }
    
}

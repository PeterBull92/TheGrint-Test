//
//  RedditTableViewCell.swift
//  The Grint Test
//
//  Created by Pedro Toro on 4/3/24.
//

import UIKit
import SDWebImage

class RedditTableViewCell: UITableViewCell {
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var totalCommentsLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var totalCommentsView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        categoryLabel.text = nil
        dateLabel.text = nil
        authorLabel.text = nil
        bodyLabel.text = nil
        totalCommentsLabel.text = nil
        thumbnailImageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupTotalCommentsView()
    }
    
    func setup(with post: Post) {
        categoryLabel.text = post.subreddit
        dateLabel.text = dateConvert(createdAt: post.createdAt)
        authorLabel.text = post.author
        bodyLabel.text = post.title
        totalCommentsLabel.text = String(post.totalComments)
        
        let imageUrl = URL(string: post.thumbnail)
        thumbnailImageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeHolder"))
    }

    func setupTotalCommentsView() {
        totalCommentsView.clipsToBounds = true
        totalCommentsView.layer.cornerRadius = totalCommentsView.bounds.height * 0.5
    }
    
    func dateConvert(createdAt: Double) -> String {
        let date = Date(timeIntervalSince1970: createdAt)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: date)
    }
}

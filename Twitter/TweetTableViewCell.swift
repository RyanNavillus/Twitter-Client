//
//  TweetTableViewCell.swift
//  Twitter
//
//  Created by Ryan Sullivan on 2/2/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var favorited = false {
        didSet {
            if favorited {
                favoriteButton.setBackgroundImage(UIImage(named: "favor-icon-red"), for: .normal)
            } else {
                favoriteButton.setBackgroundImage(UIImage(named: "favor-icon"), for: .normal)
            }
        }
    }
    
    var retweeted = false {
        didSet {
            if retweeted {
                retweetButton.setBackgroundImage(UIImage(named: "retweet-icon-green"), for: .normal)
                retweetButton.isEnabled = false
            } else {
                retweetButton.setBackgroundImage(UIImage(named: "retweet-icon"), for: .normal)
                retweetButton.isEnabled = true
            }
        }
    }
    
    var tweetID = -1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        profileImage.clipsToBounds = true
        contentLabel.sizeToFit()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func retweet(_ sender: Any) {
        guard tweetID != -1 else { return }
        guard retweeted == false else { return }
        TwitterAPICaller.client?.retweet(tweetId: tweetID, success: {
            self.retweeted = true
        }, failure: { (error) in
            print(error)
        })
    }
    
    @IBAction func favorite(_ sender: Any) {
        guard tweetID != -1 else { return }
        if favorited {
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetID, success: {
                self.favorited = false
            }, failure: { (error) in
                print(error)
            })
        }
        else {
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetID, success: {
                self.favorited = true
            }, failure: { (error) in
                print(error)
            })
        }
    }
    
}

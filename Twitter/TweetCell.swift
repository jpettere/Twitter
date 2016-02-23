//
//  TweetCell.swift
//  Twitter
//
//  Created by Julia Pettere on 2/22/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userHandle: UILabel!
    @IBOutlet weak var tweetDescriptionLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    var toggleRetweet: Bool = false
    var toggleFavorite: Bool = false
    
    var numFavorites = Int()
    var numRetweet = Int()
    
    var tweet: Tweet! {
        didSet {
            
            favoriteCountLabel.text = "\(tweet.favouritesCount)"
            numFavorites = tweet.favouritesCount
            retweetCountLabel.text = "\(tweet.retweetCount)"
            numRetweet = tweet.retweetCount
            profileImageView.setImageWithURL(tweet.user!.profileUrl!)
            
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileImageView.layer.cornerRadius = 6
        profileImageView.clipsToBounds = true
        // Initialization code
    }
    

    
    @IBAction func onRetweetPressed(sender: AnyObject) {
        if toggleRetweet  {
            numRetweet--
            toggleRetweet = !toggleRetweet
            sender.setImage(UIImage(named: "retweet-action_default"), forState: UIControlState.Normal)
        } else {
            numRetweet++
            toggleRetweet = !toggleRetweet
            sender.setImage(UIImage(named: "retweet-action-on-green"), forState: UIControlState.Normal)
        }
        retweetCountLabel.text = "\(numRetweet)"
    }
    
    @IBAction func onFavoritePressed(sender: AnyObject) {
        if toggleFavorite {
            numFavorites--
            toggleFavorite = !toggleFavorite
            sender.setImage(UIImage(named: "like-action-off"), forState: UIControlState.Normal)
        } else{
            numFavorites++
            toggleFavorite = !toggleFavorite
            sender.setImage(UIImage(named: "like-action-on-red"), forState: UIControlState.Normal)
        }
        favoriteCountLabel.text = "\(numFavorites)"
    }
    
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

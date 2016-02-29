//
//  TweetViewController.swift
//  Twitter
//
//  Created by Julia Pettere on 2/27/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {
    
    var tweets: [Tweet]?
    var tweet: Tweet!
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var handlelabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var favoriteLabel: UILabel!
    
    @IBOutlet weak var avatarView: UIImageView!
    
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var numFavorites = Int()
    var numRetweet = Int()
    
    var toggleRetweet: Bool = false
    var toggleFavorite: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoriteLabel.text = "\(tweet.favouritesCount)"
        numFavorites = tweet.favouritesCount
        tweetLabel.text = tweet.text as? String
        retweetLabel.text = "\(tweet.retweetCount)"
        numRetweet = tweet.retweetCount
        handlelabel.text = tweet.displayname
        avatarView.setImageWithURL(tweet.user!.profileUrl!)
        avatarView.layer.cornerRadius = 7.0
        avatarView.clipsToBounds = true
        usernameLabel.text = "@\(tweet.username!)"
    }
    
    @IBAction func retweetButtonPressed(sender: AnyObject) {
        if toggleRetweet  {
            numRetweet--
            toggleRetweet = !toggleRetweet
            sender.setImage(UIImage(named: "retweet-action_default"), forState: UIControlState.Normal)
        } else {
            numRetweet++
            toggleRetweet = !toggleRetweet
            sender.setImage(UIImage(named: "retweet-action-on-green"), forState: UIControlState.Normal)
        }
        retweetLabel.text = "\(numRetweet)"
    }
    
    @IBAction func favoriteButtonPressed(sender: AnyObject) {
        if toggleFavorite {
            numFavorites--
            toggleFavorite = !toggleFavorite
            sender.setImage(UIImage(named: "like-action-off"), forState: UIControlState.Normal)
        } else{
            numFavorites++
            toggleFavorite = !toggleFavorite
            sender.setImage(UIImage(named: "like-action-on-red"), forState: UIControlState.Normal)
        }
        favoriteLabel.text = "\(numFavorites)"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

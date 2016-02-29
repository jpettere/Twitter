//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Julia Pettere on 2/21/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var tweets: [Tweet]!
    var tweet: Tweet?
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self

        TwitterClient.sharedInstance.homeTimeline({ (tweets: [Tweet]) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
        }, failure: { (error: NSError) -> () in
            print(error.localizedDescription)
        
        })
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        TwitterClient.sharedInstance.homeTimeline({ (tweets: [Tweet]) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
            }, failure: { (error: NSError) -> () in
                print(error.localizedDescription)
                
        })
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        cell.tweet = tweets![indexPath.row]
        let tweet = tweets[indexPath.row]
        
        cell.userName.text = "@\(tweet.username!)"
        cell.userHandle.text = tweet.displayname
        cell.tweetDescriptionLabel.text = tweet.text as? String
        
        cell.profileImageView.layer.cornerRadius = 7.0
        cell.profileImageView.clipsToBounds = true
        cell.profileImageView.setImageWithURL(tweet.user!.profileUrl!)

        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweets = tweets {
            return tweets.count
        } else {
            return 0
        }
    }
    
    @IBAction func cancelToTweetsViewController(segue:UIStoryboardSegue) {
    }
    
    @IBAction func TwitterToTweetsViewController(segue:UIStoryboardSegue) {
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogoutButton(sender: AnyObject) {
        TwitterClient.sharedInstance.logout()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "tweetDetailSegue" {
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            let tweet = tweets![indexPath!.row]
            let tweetViewController = segue.destinationViewController as! TweetViewController
            tweetViewController.tweet = tweet
        } else if segue.identifier == "profileSegue" {
            
            let button = sender as! UIButton
            
            var superView = button.superview
            while superView != nil {
                if let tweetCell = superView as? TweetCell {
                    if let selectedUser = tweetCell.tweet.user {
                        
                        let profileViewController = segue.destinationViewController as! ProfileViewController
                        profileViewController.user = selectedUser
                        
                        
                        
                        superView = nil
                    }
                } else {
                    superView = superView?.superview
                }
            }
        } else if segue.identifier == "composeSegue" {
            if let tweet = sender as? Tweet {
                let composeViewController = segue.destinationViewController as! ComposeViewController
                composeViewController.replyTweet = tweet
    
            }
        } else if segue.identifier == "replySegue" {
            print("started replying")
            if let tweet = sender as? Tweet {
                let composeViewController = segue.destinationViewController as! ComposeViewController
                composeViewController.replyTweet = tweet
                let replyHandle  = "@\((tweet.user?.screenname!)!) " as String
    
                composeViewController.tweetId = ((tweet.id!) as? String)!
                composeViewController.replyTo = replyHandle
                composeViewController.isReply = true
            }
        }
    }
}

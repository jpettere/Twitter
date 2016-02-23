//
//  Tweet.swift
//  Twitter
//
//  Created by Julia Pettere on 2/21/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var user: User?
    var username: String?
    var displayname: String?
    var text: NSString?
    var timestamp: NSDate?
    var profileImageUrl: NSURL?
    
    var id: NSNumber?
    
    var retweetCount: Int = 0
    var favouritesCount: Int = 0
    
    init(dictionary: NSDictionary) {
        
        text = dictionary["text"] as? String
        
        id = dictionary["id"] as? Int
        
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favouritesCount = (dictionary["favorite_count"] as? Int) ?? 0
        
        let timestampString = dictionary["created_at"] as? String
        
        if let timestampString = timestampString {
            let formatter = NSDateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.dateFromString(timestampString)
        }
        
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        
        username = dictionary["user"]!["screen_name"] as? String
        displayname = dictionary["user"]!["name"] as? String
        
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString {
            profileImageUrl = NSURL(string: profileUrlString)
        }
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
        }
        
        return tweets
    }
    

}

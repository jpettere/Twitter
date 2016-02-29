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
    var retweeted: Bool?
    var favorited: Bool?
    var retweeted_status: NSDictionary?
    var createdAtString: String?
    var createdAt: NSDate?
    
    var id: NSNumber?
    
    var timePassed: Int?
    var timeSince: String!
    
    var retweetCount: Int
    var favouritesCount: Int
    
    init(dictionary: NSDictionary) {
        
        text = dictionary["text"] as? String
        
        id = dictionary["id"] as? Int
        
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favouritesCount = (dictionary["favorite_count"] as? Int) ?? 0
        
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        
        username = dictionary["user"]!["screen_name"] as? String
        displayname = dictionary["user"]!["name"] as? String
        
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString {
            profileImageUrl = NSURL(string: profileUrlString)
        }
        createdAtString = dictionary["created_at"] as? String
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
        
        let now = NSDate()
        let then = createdAt
        timePassed = Int(now.timeIntervalSinceDate(then!))
        
        if timePassed >= 86400 {
            timeSince = String(timePassed! / 86400)+"d"
        }
        if (3600..<86400).contains(timePassed!){
            timeSince = String(timePassed!/3600)+"h"
        }
        if (60..<3600).contains(timePassed!){
            timeSince = String(timePassed!/60)+"m"
        }
        if timePassed < 60 {
            timeSince = String(timePassed!)+"s"
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

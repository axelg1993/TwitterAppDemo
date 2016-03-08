 //
//  Tweet.swift
//  TwitterDemo
//
//  Created by Axel Guzman on 2/29/16.
//  Copyright © 2016 Axel Guzman. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var user: User?
    var text: NSString?
    var timestamp: NSDate?
    var retweetCount: Int!
    var favoritesCount: Int!
    var createdAtString: String?
    var createdAt: NSDate?
    var id: NSNumber?

    
    init(dictionary: NSDictionary) {
        
        user = User(dictionary: (dictionary["user"] as? NSDictionary)!)
        
        text = dictionary["text"] as? String
        
        retweetCount = dictionary["retweet_count"] as? Int
        
        favoritesCount = dictionary["favorite_count"] as? Int
        
        createdAtString = dictionary["created_at"] as? String
        
        id = dictionary["id"] as? Int
        
            let formatter = NSDateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        
        createdAt = formatter.dateFromString(createdAtString!)
        
        
    
    }
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet]{
        var tweets = [Tweet]()
        
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
        }
        
    return tweets
    }
    
}

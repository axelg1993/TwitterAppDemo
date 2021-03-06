//
//  User.swift
//  TwitterDemo
//
//  Created by Axel Guzman on 2/29/16.
//  Copyright © 2016 Axel Guzman. All rights reserved.
//

import UIKit

class User: NSObject {
    var name: String?
    var screenName: NSString?;
    
    var profileUrl: NSURL?
    var tagline: NSString?
    var dictionary: NSDictionary?
    var backgroundImageUrl = NSURL(string: "")

    var followersCount: Int = 0
    var followingCount: Int = 0
    
    var tweetsCount: Int = 0
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        
        name = dictionary["name"] as? String
        
        screenName = dictionary["screen_name"] as? String
        
        
        followersCount = (dictionary["followers_count"] as? Int) ?? 0
        followingCount = (dictionary["friends_count"] as? Int) ?? 0
        tweetsCount = (dictionary["statuses_count"] as? Int) ?? 0
        

        let profileUrlString = dictionary["profile_image_url_https"] as? String
        
        if let profileUrlString = profileUrlString {
            profileUrl = NSURL(string: profileUrlString)
        }
        
       
        if (dictionary["profile_banner_url"]) != nil {
            backgroundImageUrl = NSURL(string: (dictionary["profile_banner_url"] as? String)!)
        }
        
        tagline = dictionary["description"] as? String
           }
    
    static let userDidLogoutNotification = "UserDidLogout"

    static var _currentUser: User?
    
    class var currentUser: User?{
        get {
        
        if _currentUser == nil{
            let defaults = NSUserDefaults.standardUserDefaults()
            let userData = defaults.objectForKey("currentUserData") as? NSData
            if let userData = userData {
                let dictionary = try! NSJSONSerialization.JSONObjectWithData(userData, options: []) as! NSDictionary
                _currentUser = User(dictionary: dictionary)
            }
        }
            return _currentUser
    }

       
        set(user) {
            let defaults = NSUserDefaults.standardUserDefaults()

            if let user = user {
                let data = try! NSJSONSerialization.dataWithJSONObject(user.dictionary!, options: [])
            
            defaults.setObject(data, forKey: "currentUserData")
        } else {
    
        defaults.setObject(nil, forKey: "currentUserData")

        
        }

            defaults.synchronize()

        }
        
    

 }

}
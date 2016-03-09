//
//  TwitterClient.swift
//  TwitterDemo
//
//  Created by Axel Guzman on 2/29/16.
//  Copyright © 2016 Axel Guzman. All rights reserved.
//

import UIKit
import BDBOAuth1Manager
 
class TwitterClient: BDBOAuth1SessionManager {
    static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com/")!, consumerKey: "KUvDKitbw8nL4dFT05ydgjLgU",
        consumerSecret: "UUEzwzELqpJ16oKIu6oJr1tJ4jwLF4GCyFpnFDff6GraKkbpLd")
    var loginSuccess: (() -> ())?
    var loginFailure: ((NSError) -> ())?
    
    
    
    func login(success: () ->(), failure: (NSError) -> ()){
        loginSuccess = success
        loginFailure = failure
        
        TwitterClient.sharedInstance.deauthorize()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string:"mytwitterdemo://oauth"), scope: nil, success: { (requestToken:BDBOAuth1Credential!) -> Void in
            
            
            let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token )")!
            UIApplication.sharedApplication().openURL(url)
            
            
            }) { (error: NSError!) -> Void in
                print("error: \(error.localizedDescription) ")
                
                self.loginFailure?(error)
                
        }
    }
    
    func logout(){
        User.currentUser = nil
        deauthorize()
        
        NSNotificationCenter.defaultCenter().postNotificationName (User.userDidLogoutNotification, object: nil)
    }
    func handleOpenUrl(url: NSURL){
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: requestToken , success: { (accessToken:BDBOAuth1Credential!) -> Void in
            
            self.currentAccount({ (user: User) -> () in
                User.currentUser = user
                self.loginSuccess?()
            }, failure: { (error: NSError) -> () in
                self.loginFailure?(error)
            })

        
        }) { (error:NSError!) -> Void in
            print("error:\(error.localizedDescription)")
            self.loginFailure?(error)
        }
        
    }
    
    func homeTimeline(success: ([Tweet]) -> (), failure: (NSError) -> ()){
        GET("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task:NSURLSessionDataTask, response: AnyObject?) -> Void in
            let dictionaries = response as! [NSDictionary]
            let tweets = Tweet.tweetsWithArray(dictionaries)
           success(tweets)
            }, failure: {(task: NSURLSessionDataTask?, error: NSError) -> Void in
                failure(error)
        })
        
    }
    func currentAccount(success: (User) -> (), failure: (NSError) -> ()){
        GET("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: {(task: NSURLSessionDataTask, response: AnyObject?)  -> Void in
            
            let userDictionary = response as! NSDictionary
            let user = User(dictionary: userDictionary)
            success(user)
            
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                failure(error)
        })
    }
    
    func fav(id: String){
        POST("1.1/favorites/create.json?id=\(id)", parameters: nil, constructingBodyWithBlock: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("Liked")
            }) { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                print("NO")
        }
        
    }
    
    func retweet(id: String){
        POST("/1.1/statuses/retweet/\(id).json", parameters: nil, constructingBodyWithBlock: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("Retweet!")
            }) { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                print("NO")
        }
        
    }
    
}

//
//  TweetsCell.swift
//  TwitterDemo
//
//  Created by Axel Guzman on 3/5/16.
//  Copyright © 2016 Axel Guzman. All rights reserved.
//

import UIKit

class TweetsCell: UITableViewCell {
  
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetsLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var profileImageButton: UIButton!
    var tweet_id: String!
    var count_retweet: Int?
    
    var count_favourite: Int?
    
    
    var tweet: Tweet! {
        didSet {
            
            tweetsLabel.text = tweet.text as? String
            
            nameLabel.text = tweet.user?.name
            
            usernameLabel.text = "@" + "\((tweet.user?.screenname)!)"

            retweetLabel.text = "\(tweet.retweetCount as Int)"
            
            likesLabel.text = "\(tweet.favoritesCount)"
            
            profileImageView.setImageWithURL(tweet.user!.profileUrl!)
       
            
            timeLabel.text = calculateTimeStamp(tweet.createdAt!.timeIntervalSinceNow)
           
            count_retweet = tweet.retweetCount
            count_favourite = tweet.favoritesCount
            
            favButton.setImage(UIImage(named: "like-action-on-pressed-red"), forState: UIControlState.Normal)
            retweetButton.setImage(UIImage(named: "retweet-action-pressed"), forState: UIControlState.Normal)
          
            
            //replyButton.setImage(UIImage(named: "reply_action"), forState: UIControlState.Normal)
            
            
            
            
        }
    }
    
    

    //All credit for this method goes to David Wayman, slack @dwayman
    func calculateTimeStamp(timeTweetPostedAgo: NSTimeInterval) -> String {
        // Turn timeTweetPostedAgo into seconds, minutes, hours, days, or years
        var rawTime = Int(timeTweetPostedAgo)
        var timeAgo: Int = 0
        var timeChar = ""
        
        rawTime = rawTime * (-1)
        
        // Figure out time ago
        if (rawTime <= 60) { // SECONDS
            timeAgo = rawTime
            timeChar = "s"
        } else if ((rawTime/60) <= 60) { // MINUTES
            timeAgo = rawTime/60
            timeChar = "m"
        } else if (rawTime/60/60 <= 24) { // HOURS
            timeAgo = rawTime/60/60
            timeChar = "h"
        } else if (rawTime/60/60/24 <= 365) { // DAYS
            timeAgo = rawTime/60/60/24
            timeChar = "d"
        } else if (rawTime/(3153600) <= 1) { // YEARS
            timeAgo = rawTime/60/60/24/365
            timeChar = "y"
        }
        
        return "\(timeAgo)\(timeChar)"
    }
    



    
    @IBAction func retweetButtonClicked(sender: AnyObject) {
        print(tweet.retweetCount)
        retweetButton.setImage(UIImage(named: "retweet-action_default"), forState: UIControlState.Normal)
        //TwitterClient.sharedInstance.retweet(tweet_id)
        self.retweetLabel.text = "\(self.count_retweet!+1)"
        //print(tweet.retweetCount)
    }
    
    
    
    
    @IBAction func favButtonClicked(sender: AnyObject) {
        print(tweet.favoritesCount)
        favButton.setImage(UIImage(named: "like-action-off"), forState: UIControlState.Normal)
        //TwitterClient.sharedInstance.fav(tweet_id)
        self.likesLabel.text = "\(self.count_favourite!+1)"
        //print(tweet.favoritesCount)

    }
    
    
    
    override func awakeFromNib() {
        profileImageView.layer.cornerRadius = 4
        profileImageView.clipsToBounds = true
        profileImageView.userInteractionEnabled = true
        
        tweetsLabel.preferredMaxLayoutWidth = tweetsLabel.frame.size.width
        // Initialization code
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
         tweetsLabel.preferredMaxLayoutWidth = tweetsLabel.frame.size.width
    }
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

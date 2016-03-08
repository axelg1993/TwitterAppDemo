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
    
    var tweet: Tweet! {
        didSet {
            
            tweetsLabel.text = tweet.text as? String
            
            nameLabel.text = tweet.user?.name
            
            usernameLabel.text = "@" + "\((tweet.user?.screenname)!)"

            retweetLabel.text = "\(tweet.retweetCount as Int)"
            
            likesLabel.text = "\(tweet.favoritesCount)"
            
            profileImageView.setImageWithURL(tweet.user!.profileUrl!)
       
            
            timeLabel.text = calculateTimeStamp(tweet.createdAt!.timeIntervalSinceNow)
            
            
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
    



    
    override func awakeFromNib() {
   
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

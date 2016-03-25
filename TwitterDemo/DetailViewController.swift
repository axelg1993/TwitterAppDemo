//
//  DetailViewController.swift
//  TwitterDemo
//
//  Created by Axel Guzman on 3/12/16.
//  Copyright © 2016 Axel Guzman. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIGestureRecognizerDelegate {

    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var timeStampLabel: UILabel!
    
    var user: User!
    var data: Tweet!
    var tweetForSegue: Tweet!

    override func viewDidLoad() {
        super.viewDidLoad()
        // clicking on imageview renders profile vc
        let tap = UITapGestureRecognizer(target: self, action: #selector(DetailViewController.followingTap(_:)))
        // use the delegate
        tap.delegate = self
        
        profileImageView.userInteractionEnabled = true
        // add tap as gestureRecognizer to the tapView
        profileImageView.addGestureRecognizer(tap)

        profileImageView.setImageWithURL(data.user!.profileUrl!)
        
        profileImageView.layer.cornerRadius = 4
        
        profileImageView.clipsToBounds = true

        userNameLabel.text = "@" + "\((data.user?.screenName)!)"
        
        timeStampLabel.text = calculateTimeStamp(data.createdAt!.timeIntervalSinceNow)

        nameLabel.text = String(data.user!.name!)
        
        tweetLabel.text = String(data.text!)
        
        retweetCountLabel.text = String(data.retweetCount)
        
        favoriteCountLabel.text = String(data.favoritesCount)
        
        favoriteButton.setImage(UIImage(named: "like-action-off"), forState:
            UIControlState.Normal)
        
        retweetButton.setImage(UIImage(named: "retweet-action-inactive"), forState: UIControlState.Normal)
        
        replyButton.setImage(UIImage(named: "reply-action-0"), forState: UIControlState.Normal)
       
        tweetLabel.preferredMaxLayoutWidth = tweetLabel.frame.size.width

    }
    
   func followingTap(sender: UITapGestureRecognizer? = nil) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let ViewController = storyBoard.instantiateViewControllerWithIdentifier("ProfileViewController") as! ProfileViewController
        self.navigationController?.pushViewController(ViewController, animated: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //again this method derived from the very special David Wayman, slack: @dwayman
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
        } else if (rawTime/(60/60/24/365) <= 1) { // ROUGH ESTIMATE OF YEARS
            timeAgo = rawTime/60/60/24/365
            timeChar = "y"
        }
        
        return "\(timeAgo)\(timeChar)"
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

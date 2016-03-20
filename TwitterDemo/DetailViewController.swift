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
    
    
    var tweet: [Tweet]?
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: Selector("handleTap:"))
        // we use our delegate
        tap.delegate = self
        
        profileImageView.userInteractionEnabled = true
        // add tap as a gestureRecognizer to tapView
        profileImageView.addGestureRecognizer(tap)
   
        print(tweet)
    
        
        //nameLabel.text = tweet.name
        //userNameLabel.text =  "@\(tweet.user!.screenname!)"
        //tweetLabel.text = tweet.text as? String
        //profileImageView.setImageWithURL((tweet.user?.profileUrl)!)
        
       // retweetCountLabel.text = "\(tweet.retweetCount)"
       // favoriteCountLabel.text = "\(tweet.favoritesCount)"
        
        favoriteButton.setImage(UIImage(named: "like-action-off"), forState: UIControlState.Normal)
        retweetButton.setImage(UIImage(named: "retweet-action-inactive"), forState: UIControlState.Normal)
        replyButton.setImage(UIImage(named: "reply-action"), forState: UIControlState.Normal)
        
        
    }
        
        
        
        // Do any additional setup after loading the view.
    

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

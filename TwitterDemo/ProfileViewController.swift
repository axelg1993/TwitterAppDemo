//
//  ProfileViewController.swift
//  TwitterDemo
//
//  Created by Axel Guzman on 3/15/16.
//  Copyright © 2016 Axel Guzman. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetCountLabel: UILabel!
    @IBOutlet weak var followCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!

    var tweet: Tweet!
    var user: User!
    var screenName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImageView.setImageWithURL(tweet.user!.profileUrl!)
        
        profileImageView.layer.cornerRadius = 4
        
        backgroundImageView.setImageWithURL(tweet.user!.backgroundImageUrl!)

        profileImageView.clipsToBounds = true
        
        usernameLabel.text = "@" + "\((tweet.user!.screenName)!)"
        
        nameLabel.text = String(tweet.user!.name!)

        tweetCountLabel.text = String(tweet.user!.tweetsCount)
        followCountLabel.text = String(tweet.user!.followersCount)
        followingCountLabel.text = String(tweet.user!.followingCount)
        
    }        // Do any additional setup after loading the view.
    
    
    @IBAction func backButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

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

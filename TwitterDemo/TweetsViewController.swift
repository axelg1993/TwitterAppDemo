//
//  TweetsViewController.swift
//  TwitterDemo
//
//  Created by Axel Guzman on 3/1/16.
//  Copyright © 2016 Axel Guzman. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var tweets: [Tweet]?
    
    @IBOutlet weak var tableView: UITableView!
    //TweetsCellDelegate
   
    //var cellDelegate: TweetCellDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        TwitterClient.sharedInstance.homeTimeline({ (tweets: [Tweet]) -> () in
            
            self.tweets = tweets
            self.tableView.reloadData()
            
            
            for tweet in tweets {
                print(tweet.text)
             
            }
            
            }) { (error: NSError) -> () in
                print(error.localizedDescription)
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets != nil {
            return tweets!.count
        } else {
            return 0
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetsCell", forIndexPath: indexPath) as! TweetsCell
      
        //cell.user = user[indexPath.row]
        
        if (tweets != nil) {
            cell.tweet = tweets![indexPath.row]
        }
        
       
        
        
        return cell
        
    }
   /*
    func likeButtonClicked (tweetCell: TweetsCell!) {
                TwitterClient.sharedInstance.favoriteWithCompletion(["id": tweetID!]) { (tweet, error) -> () in
        
                    if (tweet != nil) {
        
                        self.favButton.setImage(UIImage(named: "like-action-on-red.png"), forState: UIControlState.Normal)
        
                        if self.favCountLabel.text! > "0" {
                            self.favCountLabel.text = String(self.tweet.favCount! + 1)
                        } else {
                            self.favCountLabel.hidden = false
                            self.favCountLabel.text = String(self.tweet.favCount! + 1)
                        }
        
                    }
                    else {
                        print("Did it print the print fav tweet? cause this is the error message and you should not be seeing this.")
                    }
                }
    }
    */
    
    @IBAction func onLogoutButton(sender: AnyObject) {
        TwitterClient.sharedInstance.logout() 
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

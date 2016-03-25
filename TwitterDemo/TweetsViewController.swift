//
//  TweetsViewController.swift
//  TwitterDemo
//
//  Created by Axel Guzman on 3/1/16.
//  Copyright © 2016 Axel Guzman. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var tweets: [Tweet]!
    var tweetForSegue: Tweet?
    var screenName: String?
    var USER: User?

    @IBOutlet weak var tableView: UITableView!
    
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
        
        if (tweets != nil) {
            cell.tweet = tweets![indexPath.row]
        }
        return cell
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "composeSegue" {
            let composeViewController = segue.destinationViewController as! ComposeViewController
            composeViewController.tweet = tweetForSegue
        } else if segue.identifier == "tweetSegue" {
        let cell = sender as! TweetsCell
        let indexPath = tableView.indexPathForCell(cell)
        let data = tweets![indexPath!.row]
        let detailViewController = segue.destinationViewController as! DetailViewController
            detailViewController.data = data}
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

    
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

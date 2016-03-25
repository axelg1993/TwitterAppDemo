//
//  ComposeViewController.swift
//  TwitterDemo
//
//  Created by Axel Guzman on 3/12/16.
//  Copyright © 2016 Axel Guzman. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var tweetField: UITextField!
    
    var reply: Bool = false
    var tweet: Tweet?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tweetField.text = ""
        tweetField.becomeFirstResponder()
        
        if reply {
            tweetField.text = "@\(tweet!.user!.screenName!) "
        }
        // Do any additional setup after loading the view.
    }

    
    func textFieldDidEndEditing(textField: UITextField) {
        tweetField.resignFirstResponder()
    }
    
    @IBAction func onCancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    

    @IBAction func onSendTweet(sender: AnyObject) {
        var formattedString: String = ""
        
        if tweetField.text != "" || tweetField.text != " " {
            formattedString = tweetField.text!.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
            
            TwitterClient.sharedInstance.sendTweet(formattedString, params: nil, completion:  { (error) -> () in
                self.dismissViewControllerAnimated(true, completion: {})
            })
            
        }
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

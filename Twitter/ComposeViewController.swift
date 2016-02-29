//
//  ComposeViewController.swift
//  Twitter
//
//  Created by Julia Pettere on 2/27/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var charCount: UILabel!
    
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var tweetButton: UIBarButtonItem!
    
    var replyTweet: Tweet?
    let maxChars = 140
    var user: User!
    var tweet: Tweet!
    var replyTo: String = ""
    var tweetId: String = ""
    var isReply: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.delegate = self
        textView.becomeFirstResponder()

        
        let currentUser = User.currentUser!
        let imageUrl = currentUser.profileUrl
        profileImageView.setImageWithURL(imageUrl!)
        profileImageView.layer.cornerRadius = 5
        profileImageView.clipsToBounds = true

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onTweet(sender: UIBarButtonItem) {
        let text = textView.text
        let params = ["status": text] as NSDictionary
        TwitterClient.sharedInstance.postTweetWithCompletion(params, completion: { (response, error) -> () in
            if response != nil {
                print("tweet posted")
                self.dismissViewControllerAnimated(true, completion: nil)
            } else {
                print("Failed to post tweet")
                //self.popupMessage("Failed to tweet")
            }
        })
        navigationController!.popViewControllerAnimated(true)
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        return textView.text.characters.count + (text.characters.count - range.length) <= maxChars
    }
    
    func textViewDidChange(textView: UITextView) {
        let count = textView.text.characters.count
        charCount.text = "\(140-count)"
        if (140-count) < 0 {
            charCount.textColor = UIColor.redColor()
        } else {
            charCount.textColor = UIColor.grayColor()
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

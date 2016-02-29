//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Julia Pettere on 2/28/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var tweetsLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var headerImageView: UIImageView!
    
    var user: User!
    var tweets: [Tweet]?
    var tweet: Tweet!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImageView.setImageWithURL(user!.profileUrl!)
        profileImageView.layer.cornerRadius = 7.0
        profileImageView.clipsToBounds = true
        usernameLabel.text = user!.name as? String
        handleLabel.text = "@\(user!.screenname!)"
        followersLabel.text = "\(user!.followerCount!)"
        followingLabel.text = "\(user!.followingCount!)"
        tweetsLabel.text = "\(user!.tweetsCount!)"
        if user!.headerImageUrl != nil {
            headerImageView.setImageWithURL(NSURL(string: user!.headerImageUrl!)!)
        } else {
            let headerColor = UIColorFromRGB("0xFF\(user!.headerBackgroundColor!)")
            headerImageView.backgroundColor = headerColor
        }
    }
    
    func UIColorFromRGB(colorCode: String, alpha: Float = 1.0) -> UIColor {
        let scanner = NSScanner(string:colorCode)
        var color:UInt32 = 0;
        scanner.scanHexInt(&color)
        
        let mask = 0x000000FF
        let r = CGFloat(Float(Int(color >> 16) & mask)/255.0)
        let g = CGFloat(Float(Int(color >> 8) & mask)/255.0)
        let b = CGFloat(Float(Int(color) & mask)/255.0)
        
        return UIColor(red: r, green: g, blue: b, alpha: CGFloat(alpha))
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

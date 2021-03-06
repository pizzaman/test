//
//  SettingViewController.swift
//  iNoteCore
//
//  Created by xuxiaomin on 16/5/22.
//  Copyright © 2016年 xuxiaomin. All rights reserved.
//

import UIKit
import MessageUI

class SettingViewController: UIViewController, MFMailComposeViewControllerDelegate{
    
    @IBOutlet weak var settingNavi: UINavigationItem!
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var btnMailto: UIButton!
    @IBOutlet weak var btnHelp: UIButton!
    @IBOutlet weak var btnReview: UIButton!
    @IBOutlet weak var btnTheme: UIButton!
    
    @IBOutlet weak var btnAboutUs: UIButton!
    
    @IBOutlet var imageViwe: UIImageView?
    
    @IBAction func changeTheme(sender: AnyObject) {
        print ("changeTheme")
    }
    
    
    @IBAction func aboutUs(sender: AnyObject) {
        print("about us")
    }
    @IBAction func help(sender: AnyObject) {
        print("help")
    }

    //商店评分
    @IBAction func review(sender: AnyObject) {
//        let url : NSURL = NSURL(string: "http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=980864870&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8")!
        let url: NSURL = NSURL(string: "http://app-adforce.jp/ad/p/r?_site=34588&_article=210800&_link=5344483&_image=4920534&adid=&sad=4niwtn726aa")!
        
        if(UIApplication.sharedApplication().canOpenURL(url)){
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    // 联系开发者
    @IBAction func mailToDeveloper(sender: AnyObject) {
        
        let infoDictionary = NSBundle.mainBundle().infoDictionary
        let shortVersion: String? = infoDictionary! ["CFBundleShortVersionString"] as? String
       
        // 应用版本号
        let majorVersion = (shortVersion != nil) ? shortVersion! : "0.0"
        //系统版本号
        let systemVersion = UIDevice.currentDevice().systemVersion

        let body = NSString(format: NSLocalizedString("BODY", comment: "邮件内容"), systemVersion, majorVersion)
        
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients([Constant.EMAIL])
        mailComposerVC.setSubject(NSLocalizedString("SUBJECT", comment: "邮件标题"))
        mailComposerVC.setMessageBody(body as String, isHTML: false)
        self.presentViewController(mailComposerVC, animated: true, completion: nil)
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // 分享应用给好用
    @IBAction func shareToFriend(sender: AnyObject) {
        
        // 共有する項目
        let shareText = "Apple - Apple Watch"
        let shareWebsite = NSURL(string: "https://www.apple.com/jp/watch/")!
        let shareImage = UIImage(named: "pen.png")!
        
        let activityItems = [shareText, shareWebsite, shareImage]
        
        // 初期化処理
        let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        
        // 使用しないアクティビティタイプ
        let excludedActivityTypes = [
            UIActivityTypePostToWeibo,
            UIActivityTypeSaveToCameraRoll,
            UIActivityTypePrint
        ]
        
        activityVC.excludedActivityTypes = excludedActivityTypes
        
        // UIActivityViewControllerを表示
        self.presentViewController(activityVC, animated: true, completion: nil)
        
    }

    // 通过发邮件分享给好友
    func mailTapped(sender:UITapGestureRecognizer){
        let body = NSLocalizedString("INVITE_BODY", comment: "邮件内容")
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setSubject(NSLocalizedString("INVITE_SUBJECT", comment: "邮件标题"))
        mailComposerVC.setMessageBody(body as String, isHTML: false)
        
        // A view controller can only present one other view controller at a time
        if self.presentedViewController != nil{
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        self.presentViewController(mailComposerVC, animated: true, completion: nil)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 初始化界面
        initPage()
    }

    private func initPage(){
        // 主题更换页面显示默认的返回按钮
        self.navigationItem.setHidesBackButton(false, animated: false)
        settingNavi.title = NSLocalizedString("SETTING_TITLE", comment: "设定标题")
        btnShare.setTitle(NSLocalizedString("SHARE", comment: "分享"), forState: UIControlState.Normal)
        btnMailto.setTitle(NSLocalizedString("MAILTO", comment: "联系开发者"), forState: UIControlState.Normal)
        btnHelp.setTitle(NSLocalizedString("HELP", comment: "帮助"), forState: UIControlState.Normal)
        btnTheme.setTitle(NSLocalizedString("THEME", comment: "主题"), forState: UIControlState.Normal)
        btnReview.setTitle(NSLocalizedString("REVIEW", comment: "评分"), forState: UIControlState.Normal)
        btnAboutUs.setTitle(NSLocalizedString("ABOUTUS", comment: "关于我们"), forState: UIControlState.Normal)

        
        btnShare.backgroundColor = UIColor.whiteColor()
        btnShare.layer.cornerRadius = 5
        
        btnMailto.backgroundColor = UIColor.whiteColor()
        btnMailto.layer.cornerRadius = 5
        
        btnHelp.backgroundColor = UIColor.whiteColor()
        btnHelp.layer.cornerRadius = 5
        
        btnTheme.backgroundColor = UIColor.whiteColor()
        btnTheme.layer.cornerRadius = 5
        
        btnReview.backgroundColor = UIColor.whiteColor()
        btnReview.layer.cornerRadius = 5

        btnAboutUs.backgroundColor = UIColor.whiteColor()
        btnAboutUs.layer.cornerRadius = 5

        // 设定背景图片
        let theme: Int = NSUserDefaults.standardUserDefaults().valueForKey("theme") as! Int
        imageViwe = UIImageView(frame: CGRect(origin: CGPointZero, size: self.view.frame.size))
        imageViwe!.image = UIImage(named:  "setting_bk\(theme)")
        self.view.addSubview(imageViwe!)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "themeSegue"){
            print("identifier1:  \(segue.identifier)")
            _ = segue.destinationViewController as! ThemePageViewController
            
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        // 设定背景图片
        let theme: Int = NSUserDefaults.standardUserDefaults().valueForKey("theme") as! Int
        imageViwe!.image = UIImage(named:  "setting_bk\(theme)")

    }
}
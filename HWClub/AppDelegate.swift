//
//  AppDelegate.swift
//  HWClub
//
//  Created by Lyndon Samual McKay on 9/23/15.
//  Copyright © 2015 Lyndon Samual McKay. All rights reserved.
//

import UIKit
import Parse
import Bolts


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var tx : Int?
    
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        

        var sdk: STAStartAppSDK = STAStartAppSDK.sharedInstance()
        sdk.appID = "201986052"
        sdk.devID = "104057493"
        
        sdk.preferences = STASDKPreferences.prefrencesWithAge(18, andGender: STAGender_Undefined)

//        sdk.disableReturnAd()
        
        
        application.statusBarStyle = UIStatusBarStyle.LightContent
        // instead of
        // UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: false)
        // which gives warning about deprecation in iOS 9
        
        
        Parse.setApplicationId("YzbkdagO6uw4dDjyp8g0rjXdiCUCz9Z8tKnuTbYZ", clientKey: "enwPjVthpfIZiPGnozr1xP0DFhx8PRG8yt7Pp5IU")
        
        PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
        
        //let userNotificationTypes = UIUserNotificationType.Alert ; UIUserNotificationType.Badge ;  UIUserNotificationType.Sound
        //let settings = UIUserNotificationSettings(forTypes: userNotificationTypes, categories: nil)
        let settings = UIUserNotificationSettings(forTypes: [.Alert, .Sound, .Badge], categories: nil)
        application.registerUserNotificationSettings(settings)
        application.registerForRemoteNotifications()
        
        clearBadges()
        
        if let launchOptions = launchOptions as? [String : AnyObject] {
            if let notificationDictionary = launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey] as? [NSObject : AnyObject] {
                self.application(application, didReceiveRemoteNotification: notificationDictionary)
            }
        }
        
        return true
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        
//        let installation = PFInstallation.currentInstallation()
//        installation.setDeviceTokenFromData(deviceToken)
//        installation.channels = ["global"]
        if  PFUser.currentUser() != nil{
            let installation = PFInstallation.currentInstallation()
            installation["user"] = PFUser.currentUser()
            installation["userID"] = PFUser.currentUser()?.objectId!
            installation.setDeviceTokenFromData(deviceToken)
            installation.saveInBackground()
        }
    }

    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        PFPush.handlePush(userInfo)
        
        
    }
    
    func application(application: UIApplication,  didReceiveRemoteNotification userInfo: [NSObject : AnyObject],  fetchCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
        queryNotiis()
        if let userId: String = userInfo["userID"] as? String {
            //let targetPhoto = PFObject(withoutDataWithClassName: "Photo", objectId: photoId)
            let targetNoti = PFObject(withoutDataWithClassName: "Notifications", objectId: userId)
            targetNoti.fetchIfNeededInBackgroundWithBlock { (object: PFObject?, error: NSError?) -> Void in
                // Show photo view controller
                if error != nil {
                    completionHandler(UIBackgroundFetchResult.Failed)
                } else if PFUser.currentUser() != nil {

                    
                    let viewController = NotiTVC()
                    let navController = notiNAVI()
                    
                    navController.pushViewController(viewController, animated: true)
                    completionHandler(UIBackgroundFetchResult.NewData)
                } else {
                    completionHandler(UIBackgroundFetchResult.NoData)
                }
            }
        }
        completionHandler(UIBackgroundFetchResult.NoData)
    }

    
    func clearBadges() {
        let installation = PFInstallation.currentInstallation()
        installation.badge = 0
        installation.saveInBackgroundWithBlock { (success, error) -> Void in
            if success {
                print("cleared badges")
                UIApplication.sharedApplication().applicationIconBadgeNumber = 0
            }
            else {
                print("failed to clear badges")
            }
        }
    }
    
    
    func queryNotiis(){
        let cUser = PFUser.currentUser()
            let qN = PFQuery(className: "Notifications")
            qN.whereKey("getterID", equalTo: (cUser!.objectId)!)
            qN.whereKey("recieved", equalTo: false)
            qN.orderByDescending("createdAt")
            qN.findObjectsInBackgroundWithBlock { (results: [PFObject]?, error: NSError?) -> Void in
                
                if error == nil{
                
                    if let results = results as [PFObject]?{
                         UIApplication.sharedApplication().applicationIconBadgeNumber = results.count
                        
                    }
                }
            }
    }

    
    
    func applicationDidBecomeActive(application: UIApplication) {
        if  PFUser.currentUser() != nil{
            clearBadges()
        }
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        
        let installation = PFInstallation.currentInstallation()

        if installation.badge != 0 {
            UIApplication.sharedApplication().applicationIconBadgeNumber = installation.badge
        }else{
            print("nothing back")
        }
        
        if  PFUser.currentUser() != nil{
            queryNotiis()
        }

    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        if  PFUser.currentUser() != nil{
            queryNotiis()
        }
        // clear CachedPosts HERE

    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

//    func applicationDidBecomeActive(application: UIApplication) {
//        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
//    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


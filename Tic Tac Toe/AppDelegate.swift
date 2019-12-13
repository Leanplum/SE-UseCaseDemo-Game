/*
//  AppDelegate.swift
//  Tic Tac Toe
//
//  Created on 1/23/19


1. What is an SDK?
    Software Development Kit
2. What is the Leanplum SDK
 A wrapper for the Leanplum API that is the driver for all functions you will want to implement with Leanplum.  These functions include capturing OS level device information and delivering messageing and trigger logic to the mobile phone

*/

import UIKit
import UserNotifications
import os.log

#if DEBUG
    import AdSupport
#endif
import Leanplum

/*
  1. Download the cocoapods, create a Podfile and add the Leanplum SDK to the podfile you created. This can all be completed in the terminal program and you can find more information in our docs on what to include at https://docs.leanplum.com/reference#ios-setup
  2. Next steps after cocoa pods/Leanplum SDK installed is to import Leanplum into the AppDelegate. Place in the App Delegate so Leanplum is initialized at the same time your app.
*/

//Leanplum variables: variables in your code that allow you to control data remotely without writing additional code or resubmitting the app

var onboardTrack = LPVar.define("onboard", with: false)
var LPindex = LPVar.define("LPindex", with: 1 )
var welcomeText = LPVar.define("welcomeText", with: "Welcome to TicTacToe")
var userId = LPVar.define("username", with: "")
var smallPrice = LPVar.define("smallPrice", with: 1.99)
var largePrice = LPVar.define("largePrice", with: 4.99)
var btnRadius = LPVar.define("radius", with: 4.0)
var companyNameTitle = LPVar.define("companyNameTitle", with: "LEANPLUM DEMO")
var picture1 = LPVar.define("picture1", withFile: "image4.png")
var picture2 = LPVar.define("picture2", withFile: "image4.png")
var picture3 = LPVar.define("picture3", withFile: "image4.png")

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let appDev:String = "app_S8Yt8OeAK2Ovgrq0F8Je3S3V8g0U4ar8Cv2E7e9Lgz0"
        let devDev:String = "dev_308Z1YC7TgWSLlFPvcf3c0WtbazKAwpEegElKcDZe9A"
        
        #if DEBUG
        Leanplum.setDeviceId(ASIdentifierManager.shared().advertisingIdentifier.uuidString)
        Leanplum.setAppId(appDev, withDevelopmentKey: devDev)
        #else

        //Leanplum.setAppId(appDev, withProductionKey: "prod_EZkrxXnONTH47uKBLr3taZkgTcNUIupgP5sFGMPYzF0")
        #endif

        
        //Optional: Tracks in-app purchases automatically as the "Purchase" event.
        // To require valid receipts upon purchase or change your reported
        // currency code from USD, update your app settings.
        // Leanplum.trackInAppPurchases()
        
        // Optional: Tracks all screens in your app as states in Leanplum.
        //Leanplum.trackAllAppScreens()
        
        // Optional: Activates UI Editor.
        // Requires the Leanplum-iOS-UIEditor framework.
        // LeanplumUIEditor.shared().allowInterfaceEditing()
        
        LPMessageTemplatesClass.sharedTemplates()
        Leanplum.setVerboseLoggingInDevelopmentMode(true)
        Leanplum.setAppVersion("1.3.0")
        
        
        // Starts a new session and updates the app content from Leanplum.
        Leanplum.start()
    

        registerForPushNotifications()
        
        return true
        
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let url = url.absoluteURL.absoluteString
        if url.contains("sedemo://purchase") {
            let purchaseVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "purchaseVC") as! PurchaseViewController
            if let vc = UIApplication.shared.keyWindow?.rootViewController {
                vc.show(purchaseVC, sender: (Any).self)
                }
            }
        
        return false
    }
    
    func registerForPushNotifications() {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .sound, .badge]) {
                [weak self]granted, error in
                print("Permission granted: \(granted)")
                
                guard granted else { return }
                self?.getNotificationSettings()
        }
    }
        
    func getNotificationSettings() {
            UNUserNotificationCenter.current().getNotificationSettings { settings in
                print("Notification settings: \(settings)")
                guard settings.authorizationStatus == .authorized else { return }
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
        }
    }
    
    func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
        ) {
        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
        let token = tokenParts.joined()
        print("Device Token: \(token)")
    }
    
    func application(
        _ application: UIApplication,
        didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register: \(error)")
    }
    
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable : Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        completionHandler(.newData)
    }
    

}
    


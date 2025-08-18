//
//  NotificationViewController.swift
//  InterviewPrep
//
//  Created by Akhilesh Rathor on 13/07/25.
//
/*
 Q. 27) Types of Notifications in iOS?
 Ans.
 
 notifications are a way to deliver timely information to users or between components of your app. Here are the main types:
 
 1. Local Notifications
    * Scheduled by the app itself on the device.
    * Do not require internet or server.
    * Triggered by time, calendar, or location.
 📌 Use case: Alarm, reminder, offline alert
 🧾 Example: Calendar app reminding of a meeting.
 
 import UserNotifications

 let content = UNMutableNotificationContent()
 content.title = "Meeting Reminder"
 content.body = "Your meeting starts in 10 minutes"
 content.sound = .default

 let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 600, repeats: false)
 let request = UNNotificationRequest(identifier: "meetingReminder", content: content, trigger: trigger)

 UNUserNotificationCenter.current().add(request)
 
 2. Remote Notifications (Push Notifications).
    * Sent by a server via Apple Push Notification service (APNs).
    * Can be received even when app is not running.
📌 Use case: Chat message, order status, offers
 
 Example:
 
 Requires backend + APNs. Example payload sent from server:
 {
   "aps": {
     "alert": {
       "title": "New Message",
       "body": "You have a new message"
     },
     "sound": "default",
     "badge": 1
   }
 }
 
 iOS registers for push in AppDelegate:
 
 UIApplication.shared.registerForRemoteNotifications()
 
 3. Silent Notifications
    * Type of remote push with "content-available": 1
    * No user alert, but wakes app in background.
 📌 Use case: Background data sync
 
 Server payload (no alert, no sound):
 {
   "aps": {
     "content-available": 1
   }
 }
 Handle in background:
 func application(_ application: UIApplication,
                  didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                  fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
     // Fetch new data here
     completionHandler(.newData)
 }
 
 4. In-App Notifications
    * Displayed while the user is using the app.
    * Implemented manually (e.g., banners, modals).

 📌 Types:
 Banner
 Modal popup
 Tooltip
 Onboarding hotspots

 🧾 Use case: App shows "Form submitted successfully" in a toast.
 
 let banner = UILabel()
 banner.text = "Item added to cart"
 banner.backgroundColor = .black
 banner.textColor = .white
 // animate into view, then hide
 
 5. NotificationCenter (Internal Notification)
    * For communication within app components.
    * Uses Observer pattern.
 📌 Use case: Data update event, login status broadcast.
 
 // Post notification
 NotificationCenter.default.post(name: .didLogin, object: nil)

 // Observe notification
 NotificationCenter.default.addObserver(self, selector: #selector(handleLogin), name: .didLogin, object: nil)

 @objc func handleLogin() {
     print("User Logged In")
 }
 
 6. Badge Notifications
    * Red indicator on app icon.
    * Shows unread count or alert state.
 📌 Use case: Messages, tasks, notifications pending
 
 UIApplication.shared.applicationIconBadgeNumber = 3
 
 7. Rich Notifications
    * Include images, videos, buttons, etc.
    * Custom content using Notification Service Extension.
 📌 Use case: Media preview in messaging app
 
 {
   "aps": {
     "alert": {
       "title": "New Photo",
       "body": "Check out this image"
     },
     "mutable-content": 1
   },
   "media-url": "https://example.com/image.jpg"
 }

 
 8. Critical Alerts
    * Bypass Do Not Disturb & Silent mode
    * Requires Apple permission
 📌 Use case: Health alerts, weather warnings
 
 content.interruptionLevel = .critical
 content.sound = UNNotificationSound.defaultCritical


 9. Toast Notifications
    * Short in-app messages that auto-dismiss
    * No user interaction needed
 📌 Use case: "Item added to cart" message
 
 func showToast(message: String) {
     let toastLabel = UILabel()
     toastLabel.text = message
     toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
     toastLabel.textColor = .white
     toastLabel.alpha = 1.0
     // Animate in/out
 }

 
 Interview One-Liner:
 "iOS supports various types of notifications including local, remote (push), silent, in-app, and system notifications — each used for different user engagement and internal communication scenarios."
 
 
 Q. 27) b)
 How to Implement Push Notifications in iOS using Firebase (FCM)?
 
 Ans.
 
🔹 1. **Set up Firebase in Your iOS App**

 1. Go to [Firebase Console](https://console.firebase.google.com)
 2. Create or select a project
 3. Add your iOS app (enter your **bundle ID**)
 4. Download the `GoogleService-Info.plist` file
 5. Add the `.plist` to your Xcode project (Drag into the root)

 🔹 2. **Install Firebase SDK via Swift Package Manager**

 In Xcode:

 ```
 File > Add Packages > paste:
 https://github.com/firebase/firebase-ios-sdk
 ```

 Then, add:

 * `FirebaseMessaging`
 * `FirebaseCore`

🔹 3. **Configure Firebase in AppDelegate**

 ```swift
 import Firebase
 import FirebaseMessaging
 import UserNotifications

 @UIApplicationMain
 class AppDelegate: UIResponder, UIApplicationDelegate {

     func application(_ application: UIApplication,
                      didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
         FirebaseApp.configure()
         
         UNUserNotificationCenter.current().delegate = self
         let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
         
         UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { _, _ in }
         application.registerForRemoteNotifications()
         
         Messaging.messaging().delegate = self
         return true
     }
 }
 ```
🔹 4. **Get FCM Token**

 ```swift
 extension AppDelegate: MessagingDelegate {
     func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
         print("FCM Token: \(fcmToken ?? "")")
         // Send this to your server to send notifications later
     }
 }
 ```

🔹 5. **Handle Notifications**

 ```swift
 extension AppDelegate: UNUserNotificationCenterDelegate {
     // App in foreground
     func userNotificationCenter(_ center: UNUserNotificationCenter,
         willPresent notification: UNNotification,
         withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
         completionHandler([.alert, .badge, .sound])
     }
     
     // App in background / tapped
     func userNotificationCenter(_ center: UNUserNotificationCenter,
         didReceive response: UNNotificationResponse,
         withCompletionHandler completionHandler: @escaping () -> Void) {
         let userInfo = response.notification.request.content.userInfo
         // Handle tap
         completionHandler()
     }
 }
 ```

 🔹 6. **Send Push from Firebase Console**

 * Go to **Firebase Console → Cloud Messaging**
 * Click **"Send your first message"**
 * Add title and body
 * Choose **target app** and **device token** (from step 4)

🔹 7. **Important Notes for Production**

 * Upload your **APNs Auth Key (.p8)** to Firebase:

   * Firebase Console → Project Settings → Cloud Messaging → Upload Key
 * Without this, Firebase can’t send push to iOS

 ---

 ## 🎤 Interview One-liner:

 > "We configure Firebase in the app, request notification permissions, get the FCM token, and use Firebase Console or server to push messages using that token."


 */
import UserNotifications
import UIKit

class NotificationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        

        let content = UNMutableNotificationContent()
        content.title = "Meeting Reminder"
        content.body = "Your meeting starts in 10 minutes"
        content.sound = .default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "meetingReminder", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request)
    }
    


}

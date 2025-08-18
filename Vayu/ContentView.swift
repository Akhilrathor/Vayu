//
//  ContentView.swift
//  Vayu
//
//  Created by Akhilesh Rathor on 13/07/25.
//
import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Button("Schedule Notification") {
                scheduleNotification()
            }
        }
        .onAppear {
            requestNotificationPermissions()
        }
    }
    
    func requestNotificationPermissions() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
            print(granted ? "Permission granted" : "Permission denied")
        }
    }
    
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Test Notification"
        content.body = "This is a test notification from your demo app"
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled successfully")
            }
        }
    }
}


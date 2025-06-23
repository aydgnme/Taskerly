//
//  NotificationService.swift
//  Taskerly
//
//  Created by Mert Aydogan on 23.06.2025.
//

import Foundation
import UserNotifications

enum NotificationService {
    static func scheduleNotification(id: String, title: String, date: Date) {
        let content = UNMutableNotificationContent()
        content.title = "Upcoming Task"
        content.body = title
        content.sound = .default

        let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents(
            [.year, .month, .day, .hour, .minute], from: date), repeats: false)

        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }

    static func cancelNotification(id: String) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
    }
}

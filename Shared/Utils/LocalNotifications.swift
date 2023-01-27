import Foundation
import UserNotifications

class LocalNotifications {
	static var shared = LocalNotifications()
	
	var lastKnownPermission: UNAuthorizationStatus?
	var userNotificationCenter: UNUserNotificationCenter { UNUserNotificationCenter.current() }
	
	private init() {
		userNotificationCenter.getNotificationSettings { settings in
			let permission = settings.authorizationStatus
			
			switch permission {
			#if os(iOS)
			case .ephemeral, .provisional: fallthrough
			#endif
				
			case .notDetermined:
				self.requestLocalNotificationPermission(completion: { _ in })
				
			case .authorized, .denied:
				break
				
			@unknown default: break
			}
		}
	}
	
	func createReminder(time: Date) {
		deleteReminder()
		userNotificationCenter.getNotificationSettings { settings in
			let content = UNMutableNotificationContent()
			content.title = "Kuchi"
			content.subtitle = "It's time to practice!"
			
			if settings.soundSetting == .enabled {
				content.sound = UNNotificationSound.default
			}
			
			var date = DateComponents()
			date.calendar = Calendar.current
			date.timeZone = TimeZone.current
			date.hour = Calendar.current.component(.hour, from: time)
			date.minute = Calendar.current.component(.minute, from: time)
			
			let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
			
			let reminder = UNNotificationRequest(
				identifier: "kuchi-reminder",
				content: content,
				trigger: trigger
			)
			
			self.userNotificationCenter.add(reminder)
		}
	}
	
	func deleteReminder() {
		userNotificationCenter.removeAllDeliveredNotifications()
	}
	
	func requestLocalNotificationPermission(completion: @escaping (_ granted: Bool) -> Void) {
		let options: UNAuthorizationOptions = [.alert, .sound]
		
		userNotificationCenter.requestAuthorization(options: options) { granted, error in
			DispatchQueue.main.async {
				if let error = error {
					print(error)
					completion(false)
					return
				}
				
				guard granted else {
					completion(false)
					return
				}
				
				completion(true)
			}
		}
	}
}

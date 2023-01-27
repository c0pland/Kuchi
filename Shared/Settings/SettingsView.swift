import SwiftUI

struct SettingsView: View {
	@AppStorage("numberOfQuestions") var numberOfQuestions = 6
	@AppStorage("appearance") var appearance: Appearance = .automatic
	@AppStorage("learningEnabled") var learningEnabled = true
	@AppStorage("dailyReminderEnabled") var dailyReminderEnabled = false
	@State var dailyReminderTime = Date(timeIntervalSince1970: 0)
	@AppStorage("dailyReminderTime") var dailyReminderTimeShadow: Double = 0
	@AppStorage("cardBackgroundColor") var cardBackgroundColorInt: Int = 0xFF0000FF
	@State var cardBackgroundColor: Color = .red
	
	var body: some View {
		List {
			Text("Settings")
				.font(.largeTitle)
				.padding(.bottom, 8)
			Section("Appearance") {
				VStack {
					Picker("", selection: $appearance) {
						ForEach(Appearance.allCases) { appearance in
							Text(appearance.name).tag(appearance)
						}
					}
					.pickerStyle(.segmented)
					ColorPicker("Card Background Color", selection: $cardBackgroundColor)
				}
			}
			Section("Game") {
				VStack(alignment: .leading) {
					Stepper("Number of Questions: \(numberOfQuestions)", value: $numberOfQuestions, in: 3...20)
					Text("Any change will affect the next game")
						.font(.caption2)
						.foregroundColor(.secondary)
				}
				Toggle("Learning Enabled", isOn: $learningEnabled)
			}
			Section("Notifications") {
				HStack {
					Text("Reminder")
					if (dailyReminderEnabled) {
						DatePicker("", selection: $dailyReminderTime, displayedComponents: .hourAndMinute)
							.onChange(of: dailyReminderTime, perform: { newValue in
								dailyReminderTimeShadow = newValue.timeIntervalSince1970
								configureNotification()
								
							})
							.onAppear {
								dailyReminderTime = Date(timeIntervalSince1970: dailyReminderTimeShadow)
								cardBackgroundColor = Color(rgba: cardBackgroundColorInt)
							}
					}
					else { Spacer() }
					Toggle("", isOn: $dailyReminderEnabled)
						.onChange(of: dailyReminderTime, perform: { _ in configureNotification() })
				}
			}
		}
		.onChange(of: cardBackgroundColor) { newValue in
			cardBackgroundColorInt = newValue.asRgba
		}
	}
	
	func configureNotification() {
		if dailyReminderEnabled {
			LocalNotifications.shared.createReminder(time: dailyReminderTime)
		} else {
			LocalNotifications.shared.deleteReminder()
		}
	}
}

struct SettingsView_Previews: PreviewProvider {
	static var previews: some View {
		SettingsView()
	}
}

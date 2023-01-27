import SwiftUI

struct WelcomeView: View {
	@EnvironmentObject var userManager: UserManager
	@State var showPractice = false
	
	@ViewBuilder
	var body: some View {
		if showPractice {
			HomeView()
		} else {
			ZStack {
				WelcomeBackgroundImage()
				VStack {
					Text(verbatim: "Hi, \(userManager.profile.name)")
					WelcomeMessageView()
					Button(action: {
						self.showPractice = true
					}, label: {
						HStack {
							Image(systemName: "play")
							Text("Start")
						}
					})
				}
			}
		}
	}
}
	
	struct WelcomeView_Previews: PreviewProvider {
		static var previews: some View {
			WelcomeView()
				.environmentObject(UserManager())
		}
	}

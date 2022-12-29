import SwiftUI

struct WelcomeMessageView: View {
	var body: some View {
		HStack {
			VStack(alignment: .leading) {
				Text("Welcome to")
					.font(.headline)
					.bold()
				Text("Kuchi")
					.font(.largeTitle)
					.bold()
			}
			.foregroundColor(.red)
			.padding(.horizontal)
		}
	}
}

struct WelcomeMessageView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeMessageView()
    }
}

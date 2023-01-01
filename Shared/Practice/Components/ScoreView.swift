import SwiftUI

struct ScoreView: View {
	let numberOfQuestions: Int
	@Binding var numberOfAnswered: Int
	
	var body: some View {
		HStack {
			Text("\(numberOfAnswered)/\(numberOfQuestions)")
				.font(.caption)
				.padding(4)
			Spacer()
		}
	}
}

struct ScoreView_Previews: PreviewProvider {
	static var previews: some View {
		ScoreView(numberOfQuestions: 5, numberOfAnswered: .constant(0))
	}
}

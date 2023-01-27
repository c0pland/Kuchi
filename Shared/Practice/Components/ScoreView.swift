import SwiftUI

struct ScoreView: View {
	@Binding var numberOfQuestions: Int
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
	@State static var numberOfQuestions: Int = 6
	
	static var previews: some View {
		ScoreView(numberOfQuestions: $numberOfQuestions, numberOfAnswered: .constant(0))
	}
}

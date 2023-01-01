import SwiftUI

struct ChallengeView: View {
	let challengeTest: ChallengeTest
	@State var showAnswers = false
	@State var numberOfAnswered = 0
	
	var body: some View {
		VStack {
			Button(action: {
				showAnswers.toggle()
			}) {
				QuestionView(question: challengeTest.challenge.question)
					.frame(height: 300)
			}
			ScoreView(numberOfQuestions: 5, numberOfAnswered: $numberOfAnswered)
			if showAnswers {
				Divider()
				ChoicesView(challengeTest: challengeTest)
					.frame(height: 300)
					.padding()
			}
		}
	}
}

struct ChallengeView_Previews: PreviewProvider {
	static let challengeTest = ChallengeTest(
		challenge: Challenge(
			question: "おねがい　します",
			pronunciation: "Onegai shimasu",
			answer: "Please"
		),
		answers: ["Thank you", "Hello", "Goodbye"]
	)
	
	static var previews: some View {
		// 2
		return ChallengeView(challengeTest: challengeTest)
	}
}

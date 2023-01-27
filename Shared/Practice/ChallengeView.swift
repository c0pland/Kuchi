import SwiftUI

struct ChallengeView: View {
	let challengeTest: ChallengeTest
	@State var showAnswers = false
	@Binding var numberOfAnswered: Int
	@Environment(\.verticalSizeClass) var verticalSizeClass
	@AppStorage("numberOfQuestions") var numberOfQuestions = 6
	
	@ViewBuilder
	var body: some View {
		if verticalSizeClass == .compact {
			VStack {
				HStack {
					Button(action: {
						showAnswers = !showAnswers
					}) {
						QuestionView(
							question: challengeTest.challenge.question)
					}
					if showAnswers {
						Divider()
						ChoicesView(challengeTest: challengeTest)
					}
				}
				ScoreView(
					numberOfQuestions: $numberOfQuestions,
					numberOfAnswered: $numberOfAnswered
				)
			}
		} else {
			VStack {
				Button(action: {
					showAnswers = !showAnswers }) {
						QuestionView(
							question: challengeTest.challenge.question)
						.frame(height: 300)
					}
				ScoreView(
					numberOfQuestions: $numberOfQuestions,
					numberOfAnswered: $numberOfAnswered
				)
				if showAnswers {
					Divider()
					ChoicesView(challengeTest: challengeTest)
						.frame(height: 300)
						.padding()
				}
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
		return ChallengeView(challengeTest: challengeTest, numberOfAnswered: .constant(0))
	}
}

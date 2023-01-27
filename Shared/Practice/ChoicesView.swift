import SwiftUI

/// Displays the view for the choices available for the practice
/// question.
struct ChoicesView: View {
	let challengeTest: ChallengeTest
	@State var challengeSolved = false
	@State var isChallengeResultAlertDisplayed = false
	@EnvironmentObject var challengesViewModel: ChallengesViewModel
	var body: some View {
		VStack(spacing: 25) {
			ForEach(0..<challengeTest.answers.count, id: \.self) { index in
				Button(action: {
					challengeSolved = checkAnswer(at: index)
					isChallengeResultAlertDisplayed = true
				}, label: {
					ChoicesRow(choice: challengeTest.answers[index])
				}).alert(isPresented: $isChallengeResultAlertDisplayed, content: {
					challengeOutcomeAlert()
				})
				Divider()
			}
		}
	}
	
	func challengeOutcomeAlert() -> Alert {
		let alert: Alert
		
		if challengeSolved {
			let dismissButton = Alert.Button.default(Text("OK")) {
				isChallengeResultAlertDisplayed = false
				challengesViewModel.generateRandomChallenge()
			}
			
			alert = Alert(
				title: Text("Congratulations"),
				message: Text("The answer is correct"),
				dismissButton: dismissButton
			)
		} else {
			let dismissButton = Alert.Button.default(Text("OK")) {
				isChallengeResultAlertDisplayed = false
			}
			
			alert = Alert(
				title: Text("Oh no!"),
				message: Text("Your answer is not correct!"),
				dismissButton: dismissButton
			)
		}
		
		return alert
	}
	
	func checkAnswer(at index: Int) -> Bool {
		let answer = challengeTest.answers[index]
		let challengeSolved: Bool
		
		if challengeTest.isAnswerCorrect(answer) {
			challengeSolved = true
			challengesViewModel.saveCorrectAnswer(for: challengeTest.challenge)
		} else {
			challengeSolved = false
			challengesViewModel.saveWrongAnswer(for: challengeTest.challenge)
		}
		
		isChallengeResultAlertDisplayed = true
		return challengeSolved
	}
}

struct ChoicesView_Previews: PreviewProvider {
	static let challengesViewModel = ChallengesViewModel()
	
	static var previews: some View {
		challengesViewModel.generateRandomChallenge()
		return ChoicesView(challengeTest: challengesViewModel.currentChallenge!)
	}
}

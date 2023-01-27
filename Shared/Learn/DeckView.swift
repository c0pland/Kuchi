import SwiftUI

struct DeckView: View {
	@ObservedObject var deck: FlashDeck
	@AppStorage("cardBackgroundColor") var cardBackgroundColorInt: Int = 0xFF0000FF
	
	let onMemorized: () -> Void
	
	init(deck: FlashDeck, onMemorized: @escaping () -> Void) {
		self.onMemorized = onMemorized
		self.deck = deck
	}
	
    var body: some View {
		ZStack {
			ZStack {
				ForEach(deck.cards.filter { $0.isActive }) { card in
					getCardView(for: card)
				}
			}
		}
    }
	
	func getCardView(for card: FlashCard) -> CardView {
	  let activeCards = deck.cards.filter { $0.isActive == true }
	  if let lastCard = activeCards.last {
		if lastCard == card {
		  return createCardView(for: card)
		}
	  }

	  let view = createCardView(for: card)

	  return view
	}

	func createCardView(for card: FlashCard) -> CardView {
	  let view = CardView(card, cardColor: Binding(
		  get: { Color(rgba: cardBackgroundColorInt) },
		  set: { newValue in cardBackgroundColorInt = newValue.asRgba }
		)
	  )

	  return view
	}
}

struct DeckView_Previews: PreviewProvider {
    static var previews: some View {
		DeckView(deck: FlashDeck(from: ChallengesViewModel.challenges), onMemorized: {})
    }
}

import Foundation

protocol DeckBaseCompatible: Codable {
    var cards: [Card] {get set}
    var type: DeckType {get}
    var total: Int {get}
    var trump: Suit? {get}
}

enum DeckType:Int, CaseIterable, Codable {
    case deck36 = 36
}

struct Deck: DeckBaseCompatible {

    //MARK: - Properties

    var cards = [Card]()
    var type: DeckType
    var trump: Suit?

    var total:Int {
        return type.rawValue
    }
}

extension Deck {

    init(with type: DeckType) {
        self.type = type
        self.cards = createDeck(suits: Suit.allCases, values: Value.allCases)
    }

    public mutating func createDeck(suits:[Suit], values:[Value]) -> [Card] {
        for cardSuit in suits {
            for cardValue in values {
                let newCard = Card(suit: cardSuit, value: cardValue)
                self.cards.append(newCard)
            }
        }
        return self.cards
    }

    public mutating func shuffle() {
        self.cards.shuffle()

    }

    public mutating func defineTrump() {
        self.trump = self.cards.last?.suit
        guard self.trump != nil else { return }
        setTrumpCards(for: self.trump!)
    }

    public mutating func initialCardsDealForPlayers(players: [Player]) {
        
        if players.count > 0 && players.count < 7 {
            for player in players {
                player.hand = [Card]()
            }
            
            for _ in 1...6 {
                for player in players {
                    let cardForAPlayer = self.cards.removeFirst()
                    player.hand?.append(cardForAPlayer)
                }
            }
        }

    }

    public mutating func setTrumpCards(for suit:Suit) {
        
        self.cards = cards.map {
            Card(suit: $0.suit, value: $0.value, isTrump: $0.suit == suit)
        }
    }
}


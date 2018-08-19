//
//  GameViewController.swift
//  Concentration
//
//  Created by Lorenzo Baldassarri on 06.06.18.
//  Copyright © 2018 Lorenzo Baldassarri. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Prefrences.backGroundColor
        
        cardCollectionView.delegate = self
        cardCollectionView.dataSource = self
        
        cardCollectionView.backgroundColor = Prefrences.backGroundColor
        
        cancelButton.tintColor = Prefrences.textColor
        cancelButton.backgroundColor = Prefrences.accentColor
        cancelButton.layer.cornerRadius = 10
        
        setGameAttributes()
    }
    
    @IBOutlet weak var cardCollectionView: UICollectionView!
    @IBOutlet weak var cancelButton: UIButton!
    
    var flipCount = Int()
    var emojiChoices = [String]()
    var emoji = Dictionary<Int,String>()
    var cards = [CardCollectionViewCell]()
    var cardBackColor = Prefrences.accentColor.cgColor
    lazy var game = Concentration(numberOfPairsOfCards: (cards.count) / 2)
    
    func setGameAttributes() {
        flipCount = 0
        emojiChoices = Prefrences.emoji
        switch Prefrences.gameDifficulty {
        case 0:
            generateCards(amount: 8)
        case 1:
            generateCards(amount: 12)
        case 2:
            generateCards(amount: 16)
        default:
            print("game error")
        }
        
    }
    
    func generateCards(amount: Int) {
        for _ in 0..<amount {
            let card = CardCollectionViewCell();
            cards.append(card)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        //let cell = cards[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as! CardCollectionViewCell

        cell.cardLabel.text = " "
        cell.layer.cornerRadius = 10
        cell.layer.backgroundColor = cardBackColor
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let card = cardCollectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        
        flipCount += 1
        UIView.transition(with: card, duration: 0.3, options: .transitionFlipFromRight, animations: nil, completion: nil)
        
        let cardNumber = indexPath.row
        print(cardNumber)
            if game.chooseCard(at: cardNumber) == "won" {
                updateViewFromModel()
                print("YOU WON IT TOOK \(flipCount) FLIPS")
                performSegue(withIdentifier: "gameFinishedSegue", sender: self)
            } else {
                updateViewFromModel()
            }
 
    }
    
    func updateViewFromModel() {
        for cell in cardCollectionView.visibleCells as! [CardCollectionViewCell] {
            let card = game.cards[(cardCollectionView.indexPath(for: cell)?.row)!]
            
            if card.isFaceUp {
                cell.cardLabel.text = emoji(for: card)
                cell.layer.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            } else {
                cell.cardLabel.text = ""
                cell.layer.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : cardBackColor
            }
        }
        
    }
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil {
            if emojiChoices.count > 0 {
                let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count - 1)))
                emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
            }
        }
        return emoji[card.identifier] ?? "?"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "gameFinishedSegue":
            let popUpVC = segue.destination as! PopUpViewController
            popUpVC.setAmountOf(flips: self.flipCount)
        default:
            print("other segue")
        }
        
    }

}

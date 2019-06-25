//
//  ViewController.swift
//  concentration
//
//  Created by najmeh nasiriyani on 2019-06-18.
//  Copyright © 2019 najmeh nasiriyani. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {

    
   // @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet var cardButtons: [UIButton]!
    
    var emojiChoices = ["🏓","🏐","🏈","🏀","⚽️","🎾"]
    var imageSet :[UIImage]?
    var imageSetPresent: Bool = false
    var numberOfPairs: Int {
        return (cardButtons.count + 1) / 2
    }
    
    lazy var game: Concentrate = Concentrate(numberOfPairsOfCards: 6)
    
    
    @IBAction func startNewGame(_ sender: UIButton) {
        game=Concentrate(numberOfPairsOfCards: 6)
        emojiChoices = ["🏓","🏐","🏈","🏀","⚽️","🎾"]
        updateViewFromModel()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if imageSet!.count > 1{
            imageSetPresent = true
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
  
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender){
                        game.chooseCard(at: cardNumber)
                        updateViewFromModel()
                    }
    }
   
    func updateViewFromModel(){
        
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isFaceUp{
                if imageSetPresent{
                    button.setBackgroundImage(image(for: card), for: UIControl.State.normal)
                 //   button.setImage(image(for: card), for: .normal)
                }else{
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }}else{
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.6717454693, blue: 0.154913314, alpha: 0):#colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
            }
        }
        
    }
    var emoji = [Int:String]()
    var image = [Int:UIImage]()
    
    func emoji(for card:Card) -> String{
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
    func image(for card:Card) -> UIImage{
        if image[card.identifier] == nil, imageSet!.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(imageSet!.count)))
            image[card.identifier] = (imageSet!.remove(at: randomIndex)).scaled(by: CGSize(width: 0.25, height: 0.25))
        }
        let myImage = (image[card.identifier] ?? UIImage(named: "defaultImage")!)
        return myImage
    }
    
    
    
}
extension Int{
    var arc4random: Int{
        if self > 0{
            return Int(arc4random_uniform(UInt32(self)))
        }else if self < 0{
            return -Int(arc4random_uniform(UInt32(abs(self))))
        }else {return 0}
    }
    
}
extension UIImage {
    func scaled(by targetSize: CGSize) -> UIImage {
        let size = self.size
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        let newSize = widthRatio > heightRatio ?  CGSize(width: size.width * heightRatio, height: size.height * heightRatio) : CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}

  

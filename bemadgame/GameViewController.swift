//
//  GameViewController.swift
//  bemadgame
//
//  Created by User18 on 2019/5/12.
//  Copyright © 2019 User18. All rights reserved.
//

import UIKit
import GameplayKit
var timer: Timer?
var goal = 0
class GameViewController: UIViewController {

    @IBOutlet var cardCollections: [UIButton]!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var finish: UIButton!
    @IBOutlet weak var time_out: UIImageView!
    @IBOutlet weak var timeup: UILabel!
    let face = [UIImage(named: "01"),UIImage(named: "02"),UIImage(named: "03"),UIImage(named: "04"),UIImage(named: "05"),UIImage(named: "06")]
    var faceChoicedArray = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        gameInit()
        var sec = 20
        time_out.isHidden = true
        timeup.isHidden = true
        finish.isHidden = true
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (_) in
            
            self.timeLabel.text = String(sec)
            if sec > 0
            {
                sec = sec - 1
            }
            else
            {
                if timer != nil {
                    timer?.invalidate()
                    self.time_out.isHidden = false
                    self.timeup.isHidden = false
                    self.finish.isHidden = false
                    for i in 0...11 {
                        self.cardCollections[i].isHidden = true
                    }
                    
                }
            }
            
        }
        
    }
    struct MatchState{
        var isOnBinding = false
        var bindCardIdentifier: Int = 0
        var bindCardCollectionIndex: Int? = nil
        var timeoutHolding = false
    }
    var matchState = MatchState()
    //let numberOfPairsOfCard = cardButtons.count
    
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardIndex = cardCollections.index(of: sender), !cards[cardIndex].isMatch , !matchState.timeoutHolding{
            
            //是否是還沒翻過牌（兩次的第一次）
            if !matchState.isOnBinding{
                matchState.isOnBinding = true
                matchState.bindCardIdentifier = cards[cardIndex].identifier
                matchState.bindCardCollectionIndex = cardIndex

                
                sender.setImage(cards[cardIndex].cardImage, for: .normal)
                UIView.transition(with: sender, duration: 0.5, options: .transitionFlipFromRight, animations: nil, completion: nil)
            }
            else{
                if let bindingIndex = matchState.bindCardCollectionIndex, bindingIndex != cardIndex{
                    
                    matchState.isOnBinding = false
                    //判斷是否相同
                    sender.setImage(cards[cardIndex].cardImage, for: .normal)
                    UIView.transition(with: sender, duration: 0.3, options: .transitionFlipFromRight, animations: nil, completion: nil)
                    
                    if matchState.bindCardIdentifier == cards[cardIndex].identifier{
                        //Bingo
                        goal = goal + 30
                        self.scoreLabel.text = String(goal)
                        viewCardChange(for: bindingIndex, withImage: matchImage, transFrom: .transitionFlipFromTop)
                        cards[bindingIndex].isMatch = true
                        viewCardChange(for: cardIndex, withImage: matchImage, transFrom: .transitionFlipFromTop)
                        cards[cardIndex].isMatch = true
                        //                        cardCollections[cardIndex].setImage(matchImage, for: .normal)
                        //                        UIView.transition(with: cardCollections[cardIndex], duration: 0.5, options: .transitionFlipFromTop, animations: nil, completion: nil)
                    }
                    else{
                        matchState.timeoutHolding = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            self.viewCardChange(for: bindingIndex, withImage: self.backImage, transFrom: .transitionFlipFromLeft)
                            self.viewCardChange(for: cardIndex, withImage: self.backImage, transFrom: .transitionFlipFromLeft)
                            self.matchState.timeoutHolding = false
                        }
                        
                    }
                }
            }
            
        }
    }
    
    func viewCardChange (for cardIndex: Int, withImage: UIImage, transFrom: UIView.AnimationOptions){
        
        cardCollections[cardIndex].setImage(withImage, for: .normal)
        UIView.transition(with: cardCollections[cardIndex], duration: 0.3, options: transFrom, animations: nil, completion: nil)
        
    }
    let backImage = UIImage(named: "gr")!
    let matchImage = UIImage(named: "ok")!
    var cards = [Card]()
    
    struct Card{
        var cardImage: UIImage
        let identifier: Int
        var isMatch: Bool
        //        init(){
        //            backImage = UIImage(named: "backcard")!
        //            isFaceUp = false
        //        }
    }
    
    func gameInit (){
        //var cards = Array<Card>()
        
        faceChoicedArray = [UIImage]()
        cards = [Card]()
        choiceFace() //亂數取出圖案
        matchState.isOnBinding = false //比對歸零
        
        //將圖案分配給卡片
        for i in cardCollections.indices {
            let btn = cardCollections[i]
            let card = Card(cardImage: faceChoicedArray[i], identifier: face.index(of: faceChoicedArray[i])! , isMatch: false)
            
            cards.append(card)
            //btn.setImage(faceChoicedArray[i], for: .normal)
            btn.setImage(backImage, for: .normal)
        }
        
        
    }
    
    //取出目前所有卡片二分之一的圖案
    func choiceFace(){
        let randomOfnums = GKShuffledDistribution(lowestValue: 0, highestValue: face.count - 1)
        let numberOfPairsOfCards = Int(cardCollections.count / 2)
        for _ in 0 ..< numberOfPairsOfCards{
            let index = randomOfnums.nextInt()
            if let faceX = face[index]{
                faceChoicedArray.append(faceX)
                faceChoicedArray.append(faceX)
            }
        }
        faceChoicedArray.shuffle()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as? OverViewController
        controller?.score = scoreLabel.text!
    }
}

extension Array{
    mutating func shuffle(){
        for _ in 0 ..< self.count {
            sort{(_,_) in arc4random() < arc4random()}
        }
    }
}

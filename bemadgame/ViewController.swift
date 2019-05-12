//
//  ViewController.swift
//  bemadgame
//
//  Created by User18 on 2019/5/12.
//  Copyright © 2019 User18. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var highscore: UILabel!
    @IBOutlet weak var six: UILabel!
    @IBOutlet weak var six2: UILabel!
    @IBOutlet weak var six3: UILabel!
    @IBOutlet weak var six4: UILabel!
    @IBOutlet weak var six5: UILabel!
    @IBOutlet weak var six6: UILabel!
    @IBOutlet weak var six7: UILabel!
    @IBOutlet weak var six8: UILabel!
    @IBOutlet weak var six9: UILabel!
    @IBOutlet weak var six10: UILabel!
    @IBOutlet weak var six11: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let highest = UserDefaults.standard.integer(forKey: "high")
        highscore.text = String(highest)
        repeatSix()

    }
    func repeatSix() {
        
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 3, delay: 0, animations: {
            self.six.center = CGPoint(x: -150, y: 100)
            self.six2.center = CGPoint(x: -150, y: 83)
            self.six3.center = CGPoint(x: -150, y: 151)
            self.six4.center = CGPoint(x: -150, y: 209)
            self.six5.center = CGPoint(x: -150, y: 325)
            self.six6.center = CGPoint(x: -150, y: 383)
            self.six7.center = CGPoint(x: -150, y: 439)
            self.six8.center = CGPoint(x: -150, y: 547)
            self.six9.center = CGPoint(x: -150, y: 654)
            self.six10.center = CGPoint(x: -150, y: 778)
            self.six11.center = CGPoint(x: -150, y: 794)
        })

    }

    @IBAction func gameRule(_ sender: Any) {
        let controller = UIAlertController(title: "遊戲說明", message: "簡單來說，請在時間內配對出所有牌，然後為了表現出這個遊戲很international，裡面大多採用英文，最後說一句，Gr NB!!!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        controller.addAction(okAction)
        present(controller, animated: true, completion: nil)
    }
    
}


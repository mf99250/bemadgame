//
//  OverViewController.swift
//  bemadgame
//
//  Created by User18 on 2019/5/12.
//  Copyright © 2019 User18. All rights reserved.
//

import UIKit

class OverViewController: UIViewController {
    
    var score : String?
    @IBOutlet weak var BestScore: UILabel!
    @IBOutlet weak var ScoreLabel: UILabel!
    @IBOutlet weak var highScore: UILabel!
    @IBOutlet weak var good: UIImageView!
    @IBOutlet weak var job: UILabel!
    
    func result() {
        BestScore.isHidden = true
        good.isHidden = true
        job.isHidden = true
        let highest = UserDefaults.standard.integer(forKey: "highe")
        if let my_score = score, let myscore = Int(my_score) {
            ScoreLabel.text = my_score
            highScore.text = String(highest)
            if myscore > highest{
                UserDefaults.standard.set(myscore, forKey: "highe")
                BestScore.isHidden = false
                good.isHidden = false
                job.isHidden = false
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        result()
        
    }
    
    @IBAction func restart(_ sender: Any) {
        if let controller = storyboard?.instantiateViewController(withIdentifier: "game") {
            present(controller, animated: true, completion: nil)
        }
    }
    
    @IBAction func homePage(_ sender: Any) {
        if let controller = storyboard?.instantiateViewController(withIdentifier: "home") {
            present(controller, animated: true, completion: nil)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  DifficultyViewController.swift
//  Concentration
//
//  Created by Lorenzo Baldassarri on 06.06.18.
//  Copyright © 2018 Lorenzo Baldassarri. All rights reserved.
//

import UIKit

class DifficultyViewController: UIViewController {
    
    override func viewWillDisappear(_ animated: Bool) {
        Prefrences.savePrefrences()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.view.backgroundColor = Prefrences.backGroundColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch Prefrences.gameDifficulty {
        case 0:
            difficultyLabel.text = "Easy (8 Cards)"
        case 1:
            difficultyLabel.text = "Medium (12 Cards)"
        case 2:
            difficultyLabel.text = "Hard (16 Cards)"
        default:
            print("error difviewcont")
        }
        
        difficultySlider.value = Float(Prefrences.gameDifficulty)
        difficultySlider.tintColor = Prefrences.accentColor
        difficultyLabel.textColor = Prefrences.textColor
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var difficultySlider: UISlider!
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        if sender.value < 0.51 {
            difficultySlider.value = 0
            difficultyLabel.text = "Easy (8 Cards)"
        } else if sender.value < 1.49 {
            difficultySlider.value = 1
            difficultyLabel.text = "Medium (12 Cards)"
        } else {
            difficultySlider.value = 2
            difficultyLabel.text = "Hard (16 Cards)"
        }
        Prefrences.gameDifficulty = Int(difficultySlider.value)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
    }
 

}

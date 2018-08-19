//
//  PopUpViewController.swift
//  Concentration
//
//  Created by Lorenzo Baldassarri on 06.06.18.
//  Copyright © 2018 Lorenzo Baldassarri. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {

    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var popUpLabel: UILabel!
    var amount = Int()
    
    @IBAction func playAgainButtonAction(_ sender: UIButton) {
    }
    
    @IBAction func backToMenuButtonAction(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Taptic engine
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        
        popUpView.layer.cornerRadius = 10
        
        popUpLabel.text = "Congratulations! It took you \(amount) flips."
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setAmountOf(flips amount: Int) {
        self.amount = amount
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        switch segue.identifier {
        case "backToMenuSegue": break
            //let controller: MenuViewController = segue.destination as! MenuViewController
            
        case "restartGameSegue":
            break
        default:
            print("error")
        }
        
    }
 
    

}

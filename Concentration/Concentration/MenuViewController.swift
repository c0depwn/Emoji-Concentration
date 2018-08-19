//
//  MenuViewController.swift
//  Concentration
//
//  Created by Lorenzo Baldassarri on 05.06.18.
//  Copyright © 2018 Lorenzo Baldassarri. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        var counter = 1
        for emoji in animationView.subviews {
            if counter%2==0 {
                emoji.rotateToRigth()
            } else {
                emoji.rotateToLeft()
            }
            counter += 1
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if Prefrences.isAppAlreadyLaunchedOnce() {
            Prefrences.loadPrefrences()
        } else {
            Prefrences.savePrefrences()
        }
        
        self.view.backgroundColor = Prefrences.backGroundColor
        appTitleLabel.textColor = Prefrences.textColor
        
        gameButton.layer.cornerRadius = 10
        gameButton.backgroundColor = Prefrences.accentColor
        gameButton.tintColor = Prefrences.textColor
    
        settingsButton.layer.cornerRadius = 10
        settingsButton.backgroundColor = Prefrences.accentColor
        settingsButton.tintColor = Prefrences.textColor
        
        animationView.isUserInteractionEnabled = false
 
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var gameButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var animationView: UIView!
    @IBOutlet weak var appTitleLabel: UILabel!
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        self.animationView.stopRotating()
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}

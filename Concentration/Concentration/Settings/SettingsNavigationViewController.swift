//
//  SettingsNavigationViewController.swift
//  Concentration
//
//  Created by Lorenzo Baldassarri on 07.06.18.
//  Copyright © 2018 Lorenzo Baldassarri. All rights reserved.
//

import UIKit

class SettingsNavigationViewController: UINavigationController {
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor : Prefrences.textColor]
        self.navigationBar.tintColor = Prefrences.accentColor
        
        if Prefrences.theme == "Dark" {
            self.navigationBar.barStyle = .black
        } else {
            self.navigationBar.barStyle = .default
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  EmojiViewController.swift
//  Concentration
//
//  Created by Lorenzo Baldassarri on 06.06.18.
//  Copyright © 2018 Lorenzo Baldassarri. All rights reserved.
//

import UIKit

class EmojiViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewWillDisappear(_ animated: Bool) {
        Prefrences.emoji = emojiCategories[currentCategory]!
        Prefrences.savePrefrences()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emojiCategories[0] = ["⚽️","🏀","🏈","⚾️","🎾","🏐","⛳️","🥊"]
        emojiCategories[1] = ["🍎","🍐","🥑","🥖","🥐","🌮","🍔","🥩"]
        emojiCategories[2] = ["📱","⌚️","💻","🖥","💾","💿","🖱","📺"]
        emojiCategories[3] = ["😁","😆","😂","😍","😛","🤨","😭","😱"]
        
        emojiCategorieTableView.delegate = self
        emojiCategorieTableView.dataSource = self
        
        currentCategory = categoryNames.index(of: Prefrences.emojiCategoryName)!
        
        self.view.backgroundColor = Prefrences.backGroundColor
        emojiCategorieTableView.backgroundColor = Prefrences.backGroundColor
        emojiCategorieTableView.tintColor = Prefrences.accentColor
        emojiCategorieTableView.separatorStyle = .none
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var currentCategory = 0
    var categoryNames = ["Sports", "Food","Technology", "Default"]
    var emojiCategories = Dictionary<Int, [String]>()
    
    @IBOutlet weak var emojiCategorieTableView: UITableView!
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.emojiCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "emojiCategorieCell", for: indexPath)
        
        cell.textLabel?.text = categoryNames[indexPath.row]
        
        if indexPath.row == currentCategory {
            cell.accessoryType = .checkmark
        }
        
        cell.textLabel?.textColor = Prefrences.textColor
        cell.backgroundColor = Prefrences.backGroundColor
        cell.tintColor = Prefrences.accentColor
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let allCells = tableView.visibleCells
        
        for cell in allCells {
            if cell == tableView.cellForRow(at: indexPath) {
                cell.accessoryType = .checkmark
                currentCategory = indexPath.row
                Prefrences.emojiCategoryName = categoryNames[currentCategory]
                Prefrences.emoji = emojiCategories[currentCategory]!
            } else {
                cell.accessoryType = .none
            }
        }
        
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()

    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        Prefrences.emoji = emojiCategories[currentCategory]!
    }
    

}

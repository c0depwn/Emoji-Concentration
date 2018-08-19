//
//  Prefrences.swift
//  Concentration
//
//  Created by Lorenzo Baldassarri on 07.06.18.
//  Copyright © 2018 Lorenzo Baldassarri. All rights reserved.
//

import Foundation
import UIKit

struct Prefrences {
    
    static let defaults = UserDefaults.standard
    
    static var theme = "Light"
    static var backGroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    static var accentColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
    static var textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    static var emoji = ["😁","😆","😂","😍","😛","🤨","😭","😱"]
    static var emojiCategoryName = "Default"
    static var gameDifficulty = 0
    
    static func savePrefrences() {

        defaults.set(theme, forKey: "theme")
        defaults.set(emoji, forKey: "emoji")
        defaults.set(emojiCategoryName, forKey: "categoryName")
        defaults.set(gameDifficulty, forKey: "gameDifficulty")

        defaults.setColor(color: backGroundColor, forKey: "backGroundColor")
        defaults.setColor(color: accentColor, forKey: "accentColor")
        defaults.setColor(color: textColor, forKey: "textColor")
        
    }
    
    static func loadPrefrences() {
        theme = defaults.object(forKey: "theme") as! String
        emoji = defaults.object(forKey: "emoji") as! [String]
        emojiCategoryName = defaults.object(forKey: "categoryName") as! String
        gameDifficulty = defaults.object(forKey: "gameDifficulty") as! Int
    
        backGroundColor = defaults.colorForKey(key: "backGroundColor")!
        accentColor = defaults.colorForKey(key: "accentColor")!
        textColor = defaults.colorForKey(key: "textColor")!
    }
    
    static func getPrefrencesColor(colorKey key: String) -> UIColor? {
        return defaults.colorForKey(key: key)
    }
    
    static func getPrefrencesGeneral(forKey key: String) -> Any? {
        return defaults.object(forKey: key)
    }
    
    static func isAppAlreadyLaunchedOnce()->Bool{
        if let isAppAlreadyLaunchedOnce = defaults.string(forKey: "isAppAlreadyLaunchedOnce"){
            print("App already launched : \(isAppAlreadyLaunchedOnce)")
            return true
        }else{
            defaults.set(true, forKey: "isAppAlreadyLaunchedOnce")
            print("App launched first time")
            return false
        }
    }
}

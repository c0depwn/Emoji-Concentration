//
//  ThemeViewController.swift
//  Concentration
//
//  Created by Lorenzo Baldassarri on 06.06.18.
//  Copyright © 2018 Lorenzo Baldassarri. All rights reserved.
//

import UIKit

class ThemeViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    override func viewWillDisappear(_ animated: Bool) {
        Prefrences.savePrefrences()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.accentColorPicker.dataSource = self
        self.accentColorPicker.delegate = self
        
        updateUI()
        
        accentColorToolBar.isHidden = true
        accentColorPicker.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var themes = ["Dark", "Light"]
    var accentColors = [#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1), #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1), #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.4300057285, green: 0.309005808, blue: 1, alpha: 1), #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)]
    var accentColorNames = ["Red","Orange","Green","Blue", "Light Blue", "Purple", "Gray"]
    var selectedAccentColor = Int()
    @IBOutlet weak var themeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var accentColorPicker: UIPickerView!
    @IBOutlet weak var accentColorButton: UIButton!
    @IBOutlet weak var accentColorToolBar: UIToolbar!
    @IBOutlet weak var themeLabel: UILabel!
    @IBOutlet weak var accentColorLabel: UILabel!
    @IBOutlet weak var appIconLabel: UILabel!
    @IBOutlet weak var iconSegmentedControl: UISegmentedControl!
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attributedString = NSAttributedString(string: accentColorNames[row], attributes: [NSAttributedStringKey.foregroundColor : Prefrences.textColor])
        return attributedString
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return accentColorNames.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return accentColorNames[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedAccentColor = row
        
        // haptic feeedback
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
    
    @IBAction func confirmAccentColorChange(_ sender: UIBarButtonItem) {
        accentColorButton.setTitle( accentColorNames[selectedAccentColor], for: .normal)
        Prefrences.accentColor = accentColors[selectedAccentColor]
        accentColorPicker.isHidden = true
        accentColorToolBar.isHidden = true

        updateUI()
    }
    
    @IBAction func cancelAccentColorChange(_ sender: UIBarButtonItem) {
        accentColorPicker.isHidden = true
        accentColorToolBar.isHidden = true
    }
    
    @IBAction func themeChanged(_ sender: UISegmentedControl) {
        
        UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
        
        if sender.selectedSegmentIndex == 0 {
            //dark
            Prefrences.theme = "Dark"
            Prefrences.backGroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            Prefrences.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)            
        } else {
            //light
            Prefrences.theme = "Light"
            Prefrences.backGroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            Prefrences.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
        updateUI()
    }
    
    @IBAction func accentColorChange(_ sender: UIButton) {
        accentColorPicker.isHidden = false
        accentColorToolBar.isHidden = false
    }
    
    @IBAction func appIconChange(_ sender: UISegmentedControl) {
        
        UIImpactFeedbackGenerator(style: .heavy).impactOccurred()

        if sender.selectedSegmentIndex == 0 {
            //dark icon
            UIApplication.shared.setAlternateIconName("ConcentrationDarkIcon") { (error) in
                if let error = error {
                    print("App icon failed to due to \(error.localizedDescription)")
                }
            }
        } else {
            //light icon
            UIApplication.shared.setAlternateIconName(nil) { (error) in
                if let error = error {
                    print("App icon failed to due to \(error.localizedDescription)")
                }
            }
        }
    }
    
    func updateUI() {
        super.navigationController?.navigationBar.tintColor = Prefrences.accentColor
        super.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor : Prefrences.textColor]
        
        view.backgroundColor = Prefrences.backGroundColor
        view.tintColor = Prefrences.accentColor
        themeLabel.textColor = Prefrences.textColor
        themeSegmentedControl.tintColor = Prefrences.accentColor
        accentColorLabel.textColor = Prefrences.textColor
        accentColorButton.setTitle(accentColorNames[accentColors.index(of: Prefrences.accentColor)!], for: .normal)
        accentColorButton.tintColor = Prefrences.accentColor
        appIconLabel.textColor = Prefrences.textColor
        iconSegmentedControl.tintColor = Prefrences.accentColor
        
        for row in accentColorPicker.subviews {
            row.backgroundColor = Prefrences.backGroundColor
            row.tintColor = Prefrences.textColor
        }
        
        accentColorPicker.reloadAllComponents()
        
        if Prefrences.theme == "Light" {
            themeSegmentedControl.selectedSegmentIndex = 1
            accentColorToolBar.barStyle = .default
             super.navigationController?.navigationBar.barStyle = .default
        } else if Prefrences.theme == "Dark" {
            themeSegmentedControl.selectedSegmentIndex = 0
            accentColorToolBar.barStyle = .black
             super.navigationController?.navigationBar.barStyle = .black
        }
        
        if UIApplication.shared.alternateIconName != nil {
            iconSegmentedControl.selectedSegmentIndex = 0
        } else {
            iconSegmentedControl.selectedSegmentIndex = 1
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
    }
    

}

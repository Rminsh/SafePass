//
//  ViewController.swift
//  TossIt
//
//  Created by armin on 10/26/19.
//  Copyright © 2019 shalchian. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    let defaults: UserDefaults = UserDefaults.standard
    
    @IBOutlet weak var generatedPasswordStack: UIStackView!
    @IBOutlet weak var generatedPasswordLabel: UILabel!
    @IBOutlet weak var charLenghtLabel: UILabel!
    @IBOutlet weak var charLenghtSlider: UISlider!
    @IBOutlet weak var includeNumbersSwitch: UISwitch!
    @IBOutlet weak var includePunctuationSwitch: UISwitch!
    @IBOutlet weak var includeSymbolsSwitch: UISwitch!
    
    var lenghtChar: Int = 16
    var includeNumbers: Bool = true
    var includePunctuation: Bool = true
    var includeSymbols: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSettings()
        loadItems()
        generatedPasswordStack.isHidden = true
    }
    
    func loadItems() {
        includeNumbersSwitch.isOn = defaults.bool(forKey: SettingsKeys.includeNumbers)
        includePunctuationSwitch.isOn = defaults.bool(forKey: SettingsKeys.includePunctuation)
        includeSymbolsSwitch.isOn = defaults.bool(forKey: SettingsKeys.includeSymbols)
        
        charLenghtLabel.text = "Lenght: \(defaults.integer(forKey: SettingsKeys.lenghtChar))"
        charLenghtSlider.value = Float(defaults.integer(forKey: SettingsKeys.lenghtChar))
    }
    
    func loadSettings() {
        includeNumbers = defaults.bool(forKey: SettingsKeys.includeNumbers)
        includePunctuation = defaults.bool(forKey: SettingsKeys.includePunctuation)
        includeSymbols = defaults.bool(forKey: SettingsKeys.includeSymbols)
        lenghtChar = defaults.integer(forKey: SettingsKeys.lenghtChar)
    }
    
    @IBAction func characterSlider(_ sender: UISlider) {
        sender.setValue(round(sender.value), animated: false)
        lenghtChar = Int(sender.value)
        charLenghtLabel.text = "Lenght: \(lenghtChar)"
        defaults.set(lenghtChar, forKey: SettingsKeys.lenghtChar)
    }
    
    @IBAction func enableIncludeNumbers(_ sender: UISwitch) {
        defaults.set(sender.isOn, forKey: SettingsKeys.includeNumbers)
        loadSettings()
    }
    
    @IBAction func enableIncludePunctuation(_ sender: UISwitch) {
        defaults.set(sender.isOn, forKey: SettingsKeys.includePunctuation)
        loadSettings()
    }
    
    @IBAction func enableIncludeSymbols(_ sender: UISwitch) {
        defaults.set(sender.isOn, forKey: SettingsKeys.includeSymbols)
        loadSettings()
    }

    @IBAction func generate(_ sender: Any) {
        let password = PasswordGenerator.sharedInstance.generatePassword(
            includeNumbers: includeNumbers,
            includePunctuation: includePunctuation,
            includeSymbols: includeSymbols,
            length: lenghtChar)
        generatedPasswordLabel.text = password
        
        generatedPasswordStack.isHidden = false
    }
    
    @IBAction func copyPassword(_ sender: Any) {
        
        UIPasteboard.general.string = generatedPasswordLabel.text
        
        let hudInternet = MBProgressHUD.showAdded(to: self.view, animated: true)
        hudInternet.mode = MBProgressHUDMode.customView
        hudInternet.customView = UIImageView(image: #imageLiteral(resourceName: "ic_check"))
        hudInternet.label.text = "Copied to clipboard"
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            hudInternet.hide(animated: true)
        })
    }
}

//
//  ViewController.swift
//  FahrensiusConverter
//
//  Created by Sébastien Gaya on 13/11/2017.
//  Copyright © 2017 Sébastien Gaya. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    // MARK: Properties
    let pickerValues = ["Celsius => Fahrenheit", "Fahrenheit => Celsius"]
    
    // MARK: Outlets
    
    @IBOutlet weak var userValueField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var userDirectionPicker: UIPickerView!
    @IBOutlet weak var resultView: UIView!
    
    
    // MARK: Actions
    
    @IBAction func convertBtn(_ sender: UIButton) {
        
        // Vérifie que la valeur entrée est un nombre décimal
        guard let userValue = Float(userValueField.text!) else {
            // Vérifie si le champ est vide ou non
            if userValueField.text == "" {
                resultLabel.text = "Pas de valeur entrée."
            } else {
                resultLabel.text = "Valeur incorrecte."
            }
            return
        }
        
        // Vérifie que le sens de direction est bien choisi
        let selectedDirection = userDirectionPicker.selectedRow(inComponent: 0)
        if selectedDirection == -1 {
            resultLabel.text = "Sens de conversion incorrect."
        }
        
        // Initialisation du résultat
        var resultValue: Float = 0.0
        
        switch selectedDirection {
        case 0:
            // Choix : Celsius => Fahrenheit
            resultValue = toFahrenheit(from: userValue)
            // On change le texte du resultLabel
            resultLabel.text = resultValue.description + " °F"
            break
        case 1:
            // Choix : Fahrenheit => Celsius
            resultValue = toCelsius(from: userValue)
            // On change le texte du resultLabel
            resultLabel.text = resultValue.description + " °C"
            break
        default:
            resultLabel.text = "Erreur de direction"        }
    }
    
    // MARK: UIPickerViewDelegate Methods
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerValues.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerValues[row]
    }
    
    
    // MARK: Convert Methods
    
    func toFahrenheit(from celsiusValue: Float) -> Float {
        // Renvoie la valeur convertie
        return celsiusValue * 1.8 + 32
    }
    
    func toCelsius(from fahrenheitValue: Float) -> Float {
        return (fahrenheitValue - 32) / 1.8
    }
    
    // MARK : UITextFieldDelegate Methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    // MARK: Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set current ViewController as delegate & data source of the directionPicker
        userDirectionPicker.delegate = self
        userDirectionPicker.dataSource = self
        
        // Set border to result UIView
        resultView.layer.borderColor = UIColor.black.cgColor
        resultView.layer.borderWidth = 1
        
        // Set default text to empty value
        resultLabel.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


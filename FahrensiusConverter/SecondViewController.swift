//
//  SecondViewController.swift
//  FahrensiusConverter
//
//  Created by Sébastien Gaya on 13/11/2017.
//  Copyright © 2017 Sébastien Gaya. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: Outlets
    
    @IBOutlet weak var userValueField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var unitControl: UISegmentedControl!
    @IBOutlet weak var resultView: UIView!
    
    // MARK: Actions
    
    @IBAction func changeUnitControl(_ sender: UISegmentedControl) {
        processConversion()
    }
    
    // MARK: UITextFieldDelegate
    
    @objc func userValueDidChange(_ userValueField: UITextField) {
        processConversion()
    }
    
    // MARK: Conversion Methods
    
    func processConversion() {
        guard let userValue = Float(userValueField.text!) else {
            // Vérifie si l'utilisateur a entré quelque chose ou si le champ est vide
            if userValueField.text == "" {
                resultLabel.text = "Pas de valeur entrée."
            } else {
                resultLabel.text = "Valeur incorrecte."
            }
            return
        }
        
        let userUnit = unitControl.selectedSegmentIndex
        
        var resultValue: Float = 0.0
        
        switch userUnit {
        case 0:
            resultValue = toFahrenheit(from: userValue)
            resultLabel.text = resultValue.description + " °F"
            break
        case 1:
            resultValue = toCelsius(from: userValue)
            resultLabel.text = resultValue.description + " °C"
            break
        default:
            resultLabel.text = "Unité incorrecte"
        }
    }
    
    func toFahrenheit(from celsiusValue: Float) -> Float {
        // Renvoie la valeur convertie en degrés Fahrenheit
        return celsiusValue * 1.8 + 32
    }
    
    func toCelsius(from fahrenheitValue: Float) -> Float {
        // Renvoie la valeur convertie en degrés Celsius
        return (fahrenheitValue - 32) / 1.8
    }
    
    
    // MARK: Override Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        // Ajoute une méthode appelée à chaque fois que la valeur du champ change
        userValueField.addTarget(self, action: #selector(userValueDidChange(_:)), for: .editingChanged)
        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

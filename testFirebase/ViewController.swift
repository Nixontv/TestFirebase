//
//  ViewController.swift
//  testFirebase
//
//  Created by Nikita Velichko on 15/08/2019.
//  Copyright © 2019 Nikita Velichko. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController {
    
    let dateFormatter : DateFormatter = DateFormatter()
    var curentDate: String = ""
    var arrayOfTextFields: [UITextField] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        
        arrayOfTextFields = [siteTextField, userIdTextField, userLoginTextField, docNameTextField, userFirstNameTextField, userLastNameTextField, docTypeTextField, docTypeOtherTextField, docStatusTextField, qrCodeTextField, eventIdTextField]
    }

  
   
    @IBOutlet weak var siteTextField: UITextField!
    @IBOutlet weak var userIdTextField: UITextField!
    @IBOutlet weak var userLoginTextField: UITextField!
    @IBOutlet weak var docNameTextField: UITextField!
    @IBOutlet weak var userFirstNameTextField: UITextField!
    @IBOutlet weak var userLastNameTextField: UITextField!
    @IBOutlet weak var docTypeTextField: UITextField!
    @IBOutlet weak var docTypeOtherTextField: UITextField!
    @IBOutlet weak var docStatusTextField: UITextField!
    @IBOutlet weak var qrCodeTextField: UITextField!
    @IBOutlet weak var eventIdTextField: UITextField!
    
    
    @IBAction func sendButton(_ sender: Any) {
        
        getCurrentDate()
        
        for ind in arrayOfTextFields{
            if ind.text?.isEmpty == true{
                ind.text = "no_information"
            }
        }
       
        sendInfo(site: siteTextField.text!.lowercased(), userID: userIdTextField.text!.lowercased() , loginDate: curentDate , userLogin: userLoginTextField.text!, docName: docNameTextField.text! , userFirstName: userFirstNameTextField.text!, userLastName: userLastNameTextField.text!, docType: docTypeTextField.text!, docTypeOther: docTypeOtherTextField.text!, docDate: curentDate, docStatus: docStatusTextField.text!, qrCode: qrCodeTextField.text!, eventId: eventIdTextField.text!)
        
    }
    
    
    func sendInfo (site: String, userID: String, loginDate: String, userLogin: String, docName: String, userFirstName: String, userLastName: String, docType: String, docTypeOther: String, docDate: String, docStatus: String, qrCode: String, eventId: String) {
        
        let dict = ["loginDate": loginDate, "userLogin": userLogin, "docName": docName , "userFirstName": userFirstName, "userLastName": userLastName, "docType": docType, "docTypeOther": docTypeOther, "docDate": docDate, "docStatus": docStatus, "qrCode": qrCode, "eventId": eventId]
        
        Database.database().reference().child("Statistics").child(site).child(userID).child(curentDate).setValue(dict)
        
    }
    
    func getCurrentDate(){
        dateFormatter.dateFormat = "yyyy-MMM-dd HH:mm:ss"
        let date = Date()
        curentDate = dateFormatter.string(from: date)
    }
    
    
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

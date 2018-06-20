//
//  RegisterVCTableViewController.swift
//  RainyShinyApp
//
//  Created by Ondřej Svojše on 16.03.17.
//  Copyright © 2017 Ondřej Svojše. All rights reserved.
//

import UIKit

class RegisterVCTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userNameLabel: UITextField!
    @IBOutlet weak var userEmailLabel: UITextField!
    @IBOutlet weak var userPwLabel: UITextField!
    @IBOutlet weak var userCountryLabel: UITextField!
    
    var countryDict = [String]()
    var pickerView: UIPickerView!
    let networkingService = NetworkingService()
    let alertMsg = AlertMsg()
    
    override func viewDidLoad() {
        super.viewDidLoad()


        //rounded profile
        profileImage.setRounded()
        // Country picker
        initCountryDict()
        pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor = UIColor.black
        userCountryLabel.inputView = pickerView
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RegisterVCTableViewController.dismissController(gesture:)))
        tapGestureRecognizer.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tapGestureRecognizer)
        
        
    }

    //Country picking process
    
    func initCountryDict() {
        for code in NSLocale.isoCountryCodes as [String] {
         
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            let name = NSLocale(localeIdentifier: "cs_CZ").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found or code \(code)"
        
            countryDict.append(name)
            countryDict.sort(by: { (name1, name2) -> Bool in name2 > name1
                
            })
        }
    }
    
    func dismissController(gesture: UITapGestureRecognizer){
        self.view.endEditing(true)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countryDict[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        userCountryLabel.text = countryDict[row]
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countryDict.count
        
        
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        let title = NSAttributedString(string: countryDict[row], attributes: [NSForegroundColorAttributeName: UIColor.white])
        return title
        
    }
    
    
    // Choice of profile pic
    
    @IBAction func choosePicture(_ sender: Any) {
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        
        
        let alertController = UIAlertController(title: "Add a new picture", message: "Choose from", preferredStyle: .actionSheet)

        let camAction = UIAlertAction(title: "Camera", style: .default) {
            (action) in pickerController.sourceType = .camera
            self.present(pickerController, animated: true, completion: nil)
        }
        let albumAction = UIAlertAction(title: "Photos Library", style: .default) {
            (action) in pickerController.sourceType = .photoLibrary
            self.present(pickerController, animated: true, completion: nil)
        }
        let savedAlbAction = UIAlertAction(title: "Saved Photos", style: .default) {
            (action) in pickerController.sourceType = .savedPhotosAlbum
            self.present(pickerController, animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(camAction)
        alertController.addAction(albumAction)
        alertController.addAction(savedAlbAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated:true, completion:nil)
        

    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let Selectedphoto = info[UIImagePickerControllerEditedImage] as! UIImage
        profileImage.image = Selectedphoto
        self.dismiss(animated: true, completion: nil)
        
    }

    //Sign up processing
    
    @IBAction func signUpBtn(_ sender: Any) {
        
        if (userEmailLabel.text!.isEmail && userPwLabel.text!.isValidPassword) {
            
            let data = UIImageJPEGRepresentation(self.profileImage.image!, 0.8)
            
            networkingService.signUp(email: userEmailLabel.text!, username: userNameLabel.text!, password: userPwLabel.text!, country: userCountryLabel.text!, data: data as NSData!)
            
            clearUI()
            
        } else {
            
            clearUI()
        }
        
        
    }
    
        
    func clearUI() {
        
        userNameLabel.text! = ""
        userPwLabel.text! = ""
        userEmailLabel.text! = ""
        userCountryLabel.text = ""
        profileImage.image! = UIImage(named: "default-profile")!
        
        
    }

}









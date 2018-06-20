//
//  UserProfileVC.swift
//  RainyShinyApp
//
//  Created by Ondřej Svojše on 20.03.17.
//  Copyright © 2017 Ondřej Svojše. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class UserProfileVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userCountry: UITextField!
    @IBOutlet weak var userPW1: UITextField!
    @IBOutlet weak var userPW2: UITextField!
    
    
    var urlImage: String!
    var pickerView: UIPickerView!
    var countryDict = [String]()
    
    
    var databaseRef: FIRDatabaseReference! {
        return FIRDatabase.database().reference()
        
    }
    var storageRef: FIRStorage! {
        
        return FIRStorage.storage()
    }
    

    override func viewDidLoad() {
        
        if FIRAuth.auth()?.currentUser == nil {
            
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login")
            present(vc, animated: true, completion: nil)
        }
        else {
            databaseRef.child("users/\(FIRAuth.auth()!.currentUser!.uid)").observe(.value, with: { (snapshot) in
                DispatchQueue.main.async {
                    
                    let user = User(snapshot: snapshot)
                    self.userName.text = user.username
                    self.userCountry.text = user.country
                    self.userEmail.text = FIRAuth.auth()?.currentUser?.email
                    let profileImage = String(user.photoUrl)
                    
                   self.storageRef.reference(forURL: profileImage!).data(withMaxSize: 1 * 1024 * 1024, completion: { (data, error) in
                    
                    if error != nil {
                        print(error!.localizedDescription)
                      }else {
                       
                        self.profileImage.image = UIImage(data: data!)
                        }
                     })
                  
                    
                }
                
                
            }) { (error) in
                print(error.localizedDescription)
            }
        }
        
        profileImage.setRounded()
        // Country picker
        initCountryDict()
        pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor = UIColor.black
        userCountry.inputView = pickerView
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UserProfileVC.dismissController(gesture:)))
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
        userCountry.text = countryDict[row]
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
    
    @IBAction func choosePic2(_ sender: Any) {
        
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
    
        
    @IBAction func SaveChangesBtn(_ sender: Any) {
        
      
        
    }
    
    @IBAction func LogOut(_ sender: Any) {
        if FIRAuth.auth()?.currentUser != nil {

        do {
            
            try FIRAuth.auth()?.signOut()
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login")
            present(vc, animated: true, completion: nil)
            
        
        } catch let error as NSError {
            print(error.localizedDescription)
            
        }
        
    }
}
    
    
}
    

    
    
    
    




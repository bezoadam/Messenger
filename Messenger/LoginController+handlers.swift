//
//  LoginController+handlers.swift
//  Messenger
//
//  Created by Adam Bezák on 12.4.17.
//  Copyright © 2017 Adam Bezák. All rights reserved.
//

import UIKit
import Firebase

extension LoginController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func handleSelectProfileImageView() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage{
            selectedImageFromPicker = editedImage
        }
        else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            profileImage.image = selectedImage
        }
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func handleRegister() {
        guard let email = emailTextField.text, let password = passwordTextField.text, let name = nameTextField.text else {
            print("not valid")
            return
        }
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: {
            (user: FIRUser?, error) in
            
            if error != nil {
                print(error!)
                return
            }
            
            guard let uid = user?.uid else {
                return
            }
            
            let imageName = UUID().uuidString
            let storageRef = FIRStorage.storage().reference().child("profile_images").child("\(imageName).jpg")
            
            if let profilImage = self.profileImage.image, let uploadData = UIImageJPEGRepresentation(profilImage, 0.1) {
                
                storageRef.put(uploadData, metadata: nil, completion: { (metadata, error) in
                    if error != nil {
                        print(error!)
                        return
                    }
                    
                    if let profileImageUrl = metadata?.downloadURL()?.absoluteString {
                        let values = ["names": name, "email": email, "profileImageUrl":profileImageUrl]
                        self.registerUserIntoDatabaseWithUID(uid: uid, values: values)
                    }
                    
                })
            }
            
//            if let uploadData = UIImagePNGRepresentation(self.profileImage.image!) {
//                storageRef.put(uploadData, metadata: nil, completion: { (metadata, error) in
//                    if error != nil {
//                        print(error!)
//                        return
//                    }
//                    
//                    if let profileImageUrl = metadata?.downloadURL()?.absoluteString {
//                        let values = ["names": name, "email": email, "profileImageUrl":profileImageUrl]
//                        self.registerUserIntoDatabaseWithUID(uid: uid, values: values)
//                    }
//                    
//                })
//            }
            
            
        })
    }
    
    private func registerUserI3ntoDatabaseWithUID(uid: String, values: [String: Any]) {
        let ref = FIRDatabase.database().reference(fromURL: "https://messenger-e3c8c.firebaseio.com/")
        let usersReference = ref.child("users").child(uid)
        usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
            if err != nil {
                return
            }
            
//            self.messagesController?.navigationItem.title = values["names"] as? String
            let user = User()
            user.name = values["names"] as? String
            user.email = values["email"] as? String
            user.profileImageUrl = values["profileImageUrl"] as? String
            self.messagesController?.setupNavBarWithUser(user: user)
            
            self.dismiss(animated: true, completion: nil)
            print("Saved")
        })
    }
}

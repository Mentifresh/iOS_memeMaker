//
//  ViewController.swift
//  MemeMaker
//
//  Created by Daniel Kilders Díaz on 20.06.19.
//  Copyright © 2019 Daniel Kilders. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController {

    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var shareMemeButton: UIBarButtonItem!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    @IBOutlet weak var topToolbar: UIToolbar!
    
    @IBOutlet weak var firstMemeLineTextField: UITextField!
    @IBOutlet weak var secondMemeLineTextField: UITextField!
    
    var meme: Meme?
    var imagePickerController: UIImagePickerController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Init vars
        meme = Meme()
        
        // Enable cameraButton if there is a camera present
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        // Disable button until user adds a pic
        shareMemeButton.isEnabled = false
        
        applyTextFieldCustomization(to: firstMemeLineTextField)
        applyTextFieldCustomization(to: secondMemeLineTextField)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Unsubscribe to observers
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @IBAction func shareMeme(_ sender: Any) {
        let finalImage = generateMeme()
        
        let vc = UIActivityViewController(activityItems: [finalImage], applicationActivities: [])
        
        vc.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
            
            if completed {
                self.save(finalMeme: finalImage)
                self.dismiss(animated: true, completion: nil)
            }
        }
        
        present(vc, animated: true)
    }
    
    @IBAction func dismissView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pickAnImage(_ sender: Any) {
        checkPhotosPermissions({
            openImageSource(from: .photoLibrary)
        }())
    }
    
    @IBAction func OpenCamera(_ sender: Any) {
        openImageSource(from: .camera)
    }
    
    func openImageSource(from imageSource: UIImagePickerController.SourceType) {
        if imagePickerController == nil {
            imagePickerController = UIImagePickerController()
            imagePickerController!.delegate = self
        }
        imagePickerController!.sourceType = imageSource
        
        present(imagePickerController!, animated: true, completion: nil)
    }
    
    func generateMeme() -> UIImage {
        
        // Hide Toolbars
        topToolbar.isHidden = true
        bottomToolbar.isHidden = true
        
        // Generate meme
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        
        let memeImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // Show toolbars
        topToolbar.isHidden = false
        bottomToolbar.isHidden = false
        
        return memeImage
    }
    
    func save(finalMeme: UIImage) {
        // Create the meme
        let meme = Meme(
            bottomString: secondMemeLineTextField.text!,
            topString: firstMemeLineTextField.text!,
            originalImage: memeImageView.image,
            finalImage: finalMeme
        )
        
        // Add it to the memes array in the Application Delegate
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
    }
    
    func applyTextFieldCustomization(to textField: UITextField) {
        let memeTextAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.strokeColor: UIColor.black, //Outline Color
            NSAttributedString.Key.foregroundColor: UIColor.white, //Fill color
            .font: UIFont.boldSystemFont(ofSize: 40),
            .strokeWidth: -4.0
        ]
        
        textField.autocapitalizationType = .allCharacters
        textField.borderStyle = .none
        
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .center
        
        textField.delegate = self
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        print(secondMemeLineTextField.isEditing)
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
            secondMemeLineTextField.isFirstResponder {
            
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            view.frame.origin.y = keyboardHeight * (-1)
        }
    }
    
    @objc func keyboardDidHide(_ notification: Notification) {
        if secondMemeLineTextField.isFirstResponder {
            view.frame.origin.y = 0
        }
    }
}


extension ViewController: UIImagePickerControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.memeImageView.image = image
            self.meme?.originalImage = image
            
            // Enable sharing button
            self.shareMemeButton.isEnabled = true
        }
        dismiss(animated: true, completion: nil)
    }
    
    func checkPhotosPermissions(_ closure: () ) {
        let status = PHPhotoLibrary.authorizationStatus()
        
        switch status {
        case .authorized:
            print("Access granted by user")
        case .notDetermined:
            print("Not determined")
            PHPhotoLibrary.requestAuthorization { (status) in
                if status == PHAuthorizationStatus.authorized {
                    closure
                }
            }
        case .denied, .restricted:
            print("Denied / restricted")
        }
    }
}

extension ViewController: UINavigationControllerDelegate {
    
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == 1 {
            meme?.topString = textField.text
        } else if textField.tag == 2 {
            meme?.bottomString = textField.text
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

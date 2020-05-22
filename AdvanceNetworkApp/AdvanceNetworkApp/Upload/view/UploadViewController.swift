//
//  UploadViewController.swift
//  AdvanceNetworkApp
//
//  Created by Balu Naik on 5/22/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import UIKit
import CoreServices
import AVFoundation

class UploadViewController: UIViewController {
    
    @IBOutlet weak var textFiled: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var uploadButton: UIButton!
    @IBOutlet weak var brouseButton: UIButton!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    
    let imagePicker = UIImagePickerController()
    var fileContent: String?  // If server required binary than we have make Data type

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Uplaod"
    }
    
    @IBAction func ChooseSource() {
        self.chooseType()
    }
    
    
    
    @IBAction func uploadAction() {
        NetworkWrapper.sharedInstance.invokeUploadRequest(endPoint: ServiceURL.uploadUrl, parameters: ["file" : "jpg",
                                                                                                       "uploadFile": self.fileContent ?? "",
                                                                                                       "sub_id": "test_id123"], sucess: { (_) in
                                                                                                        print("sucess")
        }) { (error) in
            print(error)
        }
    }
    
    func chooseType() {
        let alert = UIAlertController(title: "Source", message: nil, preferredStyle:.actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (_) in
            self.openCamera()
        }
        let gallaryAction = UIAlertAction(title: "Gallery", style: .default) { (_) in
            self.openGallary()
        }
        let more = UIAlertAction(title: "Documents", style: .default) { (_) in
            self.moreDocumentBrowser()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .default) { (_) in }
        
        // Add the actions
        imagePicker.delegate = self
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(more)
        alert.addAction(cancel)
        
        // If it's iPad we have to show like popover
        if let popoverPresentationController = alert.popoverPresentationController {
            popoverPresentationController.sourceView = self.view
            popoverPresentationController.permittedArrowDirections = .left
            
            popoverPresentationController.sourceRect = CGRect(x: Double(self.view.bounds.size.width / 2.0), y: Double(self.view.bounds.size.height / 2.0), width: 1.0, height: 1.0)
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    func openCamera() {
        if(UIImagePickerController.isSourceTypeAvailable(.camera)) {
            imagePicker.sourceType = .camera
            imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .camera) ?? []
            //imagePicker.videoQuality = .type640x480
            imagePicker.videoQuality = .typeMedium
            imagePicker.videoMaximumDuration = 120
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title:"Error", message: "You dont have camera!!!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style:.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallary() {
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        if let mediaTypes = UIImagePickerController.availableMediaTypes(for: UIImagePickerController.SourceType.photoLibrary) {
         imagePicker.mediaTypes = mediaTypes
        }
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func moreDocumentBrowser(){
        let documentPicker = UIDocumentPickerViewController(documentTypes: [String(kUTTypeImage)], in: .import)
        documentPicker.delegate = self //as! UIDocumentPickerDelegate
        documentPicker.modalPresentationStyle = .formSheet
        self.present(documentPicker, animated: true, completion: nil)
    }
}


// MARK: UIImagePickerControllerDelegate

extension UploadViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true) {
            if let urlvideo = info[UIImagePickerController.InfoKey.mediaURL] as? NSURL {
                do{
                    if let path = urlvideo.path {
                        let fileAttributes = try FileManager.default.attributesOfItem(atPath: path)
                        let fileSize = fileAttributes[FileAttributeKey.size]
                        if  ((fileSize as? UInt64) ?? 0 > UInt64(20971520)) { // 20MB
                            let alert:UIAlertController=UIAlertController(title: "Error", message:"Attachment size exceeds 20 MB", preferredStyle: .alert)
                            let okayAction = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in
                                
                                return
                            }
                            alert.addAction(okayAction)
                            self.present(alert, animated: true, completion: nil)
                        }
                        
                    }
                    self.fileContent = try Data.init(contentsOf: urlvideo as URL, options:.mappedIfSafe).base64EncodedString()
                    self.typeLabel.text = "video/mp4"
                    let asset = AVURLAsset(url: urlvideo as URL , options: nil)
                    let imgGenerator = AVAssetImageGenerator(asset: asset)
                    imgGenerator.appliesPreferredTrackTransform = true
                    let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(value: 0, timescale: 1), actualTime: nil)
                    let thumbnail = UIImage(cgImage: cgImage)
                    self.thumbnailImageView.image = thumbnail
                    self.thumbnailImageView.contentMode = .scaleAspectFit
                } catch let error {
                    print("*** Error generating thumbnail: \(error.localizedDescription)")
                }
                
                // If New video is recorder we can store in gallery
                if let path = urlvideo.path,
                    UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(path) {
                    UISaveVideoAtPathToSavedPhotosAlbum(path, nil, nil, nil);
                }
            } else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                if let data = image.pngData() {
                    self.fileContent = data.base64EncodedString()
                    //self.thumbnailImageView.image = UIImage(data: data)
                    self.typeLabel.text = "image/jpeg"
                    let dispatchBlock = {
                        if let imageData = image.resizeImageWithSizeLimit(sizeInKB: 300) {
                            self.fileContent = data.base64EncodedString()
                            DispatchQueue.main.async {[weak self] in
                                self?.thumbnailImageView.image = UIImage(data: imageData)
                            }
                        }
                    }
                    DispatchQueue.global(qos:.userInitiated).async(execute: {
                        dispatchBlock()
                    })
                }
                
            }
            
        }
    }
           
   
    
}

// MARK: - UIDocumentPickerDelegate

extension UploadViewController: UIDocumentPickerDelegate {
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        if controller.documentPickerMode == UIDocumentPickerMode.import {
            do {
                let fileData = try Data(contentsOf: url, options: NSData.ReadingOptions())
                let image = UIImage(data: fileData as Data)
                let dispatchBlock = {
                    if let imageData = image?.resizeImageWithSizeLimit(sizeInKB: 100) {
                        DispatchQueue.main.async {[weak self] in
                            self?.thumbnailImageView.image = UIImage(data: imageData)
                            // here upload code will come
                        }
                    }
                }
                DispatchQueue.global(qos:.background).async(execute: {
                    dispatchBlock()
                })
            }catch {
                print(error)
            }
        }
    }
    
}


// MARK: - Extension

extension UIImage {
    
    func getSizeInBase64(data: Data) -> Int {
        
        return data.count
        //base64EncodedString(options:.lineLength64Characters ).count/1024
    }
    
    func resizeImageWithSizeLimit(sizeInKB size:Int) -> Data? {
        if let data = self.pngData() {
            var resizedData = data
            while getSizeInBase64(data: resizedData) >= size {
                let val_x = (Float(self.size.width)/100)*90
                let val_y = (Float(self.size.height)/100)*90
                let currentSize = CGSize(width: CGFloat(roundf(val_x)), height: CGFloat(roundf(val_y)))
                UIGraphicsBeginImageContext(currentSize)
                self.draw(in: CGRect(x:0, y:0, width:currentSize.width, height:currentSize.height))
                if let resizedImage = UIGraphicsGetImageFromCurrentImageContext(),
                    let newData = resizedImage.jpegData(compressionQuality: 0) {
                    resizedData = newData
                }
                UIGraphicsEndImageContext()
            }
            
            return resizedData
        }
        
        return nil
    }
}

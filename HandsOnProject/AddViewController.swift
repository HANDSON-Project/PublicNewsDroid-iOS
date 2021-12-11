//
//  AddViewController.swift
//  HandsOnProject
//
//  Created by Yundong Lee on 2021/11/15.
//

import UIKit
import PhotosUI


class AddViewController: UIViewController {

    @IBOutlet weak var newsTextView: UITextView!
    @IBOutlet weak var selectedImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func saveButtonClicked(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func addImagesButtonClicked(_ sender: UIBarButtonItem) {
        
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 1
        let pickerView = PHPickerViewController(configuration: configuration)
        pickerView.delegate = self
        present(pickerView, animated: true, completion: nil)
        
        
    }
}

extension AddViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        let itemProvider = results.first?.itemProvider
        if let itemProvider = itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) {(image, error) in
                
                guard let image = image as? UIImage else {
                    return
                }
                DispatchQueue.main.async {
                    self.selectedImageView.image = image
                }
            }
        }

        
        
        picker.dismiss(animated: true, completion: nil)
    }
}

//
//  AddViewController.swift
//  HandsOnProject
//
//  Created by Yundong Lee on 2021/11/15.
//

import UIKit
import Alamofire
import PhotosUI


class AddViewController: UIViewController {

    @IBOutlet weak var newsTextView: UITextView!
    @IBOutlet weak var selectedImageView: UIImageView!
    
    var jwt: String?
    var userIdx: Int?
    var location: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(jwt)
        print(userIdx)
        print(location)
    }
    
    @IBAction func saveButtonClicked(_ sender: UIBarButtonItem) {
        
        if let titleIndex = newsTextView.text.firstIndex(of: "\n"){
            let title = newsTextView.text[..<titleIndex]
            let content = newsTextView.text[titleIndex...]
            createNews(title: String(title), content: String(content))
        }
    }
    
    func createNews(title:String, content: String) {
                   let url = "https://sindy-nick.site/app/news/\(userIdx!)"
                   var request = URLRequest(url: URL(string: url)!)
                   request.httpMethod = "POST"
                   request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                   request.timeoutInterval = 10
            
            let headers: HTTPHeaders = [
                       "X-ACCESS-TOKEN":jwt!
                   ]
                   
     
                let parameters = [
                    "userIdx":userIdx!,
                    "title": title,
                    "context":content,
                    "image": "DSfasdf",
                    "location":location!] as [String : Any]

                   // httpBody 에 parameters 추가
                   do {
                       request.headers = headers
                       try request.httpBody = JSONSerialization.data(withJSONObject: parameters, options: [])
                   } catch {
                       print("http Body Error")
                   }
            
            
            AF.request(request).responseString { (response) in
                       switch response.result {
                       case .success:
                           print(request)
                           print("POST 성공")
                           print(response.result)
                       case .failure(let error):
                           print("🚫 Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
                       }
                   }
               }

    
    
    func post() {
                var url = "https://sindy-nick.site//app/news"
                var request = URLRequest(url: URL(string: url)!)
                request.httpMethod = "POST"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.timeoutInterval = 10
                
                // POST 로 보낼 정보
    //            let params = ["id":"아이디", "pw":"패스워드"] as Dictionary
                let params: [String: String] = [
                    "email": "abcdefghi@email.com",
                    "password": "pss",
                    "nickname" : "yll",
                    "location": "seoul"
                    
                ] as Dictionary

                // httpBody 에 parameters 추가
                do {
                    try request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])
                } catch {
                    print("http Body Error")
                }
                
                AF.request(request).responseString { (response) in
                    switch response.result {
                    case .success:
                        print("POST 성공")
                        print(response.result)
                    case .failure(let error):
                        print("🚫 Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
                    }
                }
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

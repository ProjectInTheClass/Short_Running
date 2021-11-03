//
//  ViewController.swift
//  Project_Photo
//
//  Created by 기태욱 on 2021/10/14.
//
import UIKit
import PhotosUI

class ViewController: UIViewController {
        
    @IBOutlet var myImage: UIImageView!
    
    var imageIndex = 0
    var img : [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //.   --------------------------------------------------------------- 글자 색상 변경 ~
        if #available(iOS 13.0, *) {
            let app = UIApplication.shared
            let statusBarHeight: CGFloat = app.statusBarFrame.size.height
            
            let statusbarView = UIView()
            statusbarView.backgroundColor = UIColor.black
            view.addSubview(statusbarView)
          
            statusbarView.translatesAutoresizingMaskIntoConstraints = false
            statusbarView.heightAnchor
                .constraint(equalToConstant: statusBarHeight).isActive = true
            statusbarView.widthAnchor
                .constraint(equalTo: view.widthAnchor, multiplier: 1.0).isActive = true
            statusbarView.topAnchor
                .constraint(equalTo: view.topAnchor).isActive = true
            statusbarView.centerXAnchor
                .constraint(equalTo: view.centerXAnchor).isActive = true
          
        } else {
            let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
            statusBar?.backgroundColor = UIColor.black
        }
        

    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        // 글자색을 흰색으로
        return .lightContent
        
        // 글자색을 검은색으로
        //return .darkContent
    }
    //   --------------------------------------------------------------- ~ 글자 색상 변경
    
    
    var itemProviders: [NSItemProvider] = []
    var iterator: IndexingIterator<[NSItemProvider]>?
    
    @IBAction func multiselect(_ sender: Any) {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 0
        configuration.filter = .any(of: [.images])
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)

    }
    
    @IBAction func right(_ sender: Any) {
        imageIndex = imageIndex + 1
        if( imageIndex >= img.count ){
            imageIndex = img.count - 1
        }
        myImage.image = img[imageIndex]
    }
    

    @IBAction func left(_ sender: Any) {
        imageIndex = imageIndex - 1
        if( imageIndex < 0 ){
            imageIndex = 0
        }
        myImage.image = img[imageIndex]
    }
    
}


extension ViewController: PHPickerViewControllerDelegate {
    @available(iOS 14, *)
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        itemProviders = results.map(\.itemProvider)
        iterator = itemProviders.makeIterator()


        while true {
            // iterator가 있을 때 까지 img 배열에 append
            if let itemProvider = iterator?.next(), itemProvider.canLoadObject(ofClass: UIImage.self) {
                itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                    guard let self = self, let image = image as? UIImage else {return}
                        self.img.append(image)
                        DispatchQueue.main.async {
                            self.myImage.image = self.img[self.imageIndex]
                        }
                    }
            } else {
                break
            }
        }
    }
}

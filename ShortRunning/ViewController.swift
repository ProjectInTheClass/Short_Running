//
//  ViewController.swift
//  Project_Photo
//
//  Created by 기태욱 on 2021/10/14.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var myImage: UIImageView!
    let picker = UIImagePickerController()
    
    @IBAction func addAction(_ sender: Any) {

        let alert =  UIAlertController(title: "원하는 타이틀", message: "원하는 메세지", preferredStyle: .actionSheet)

        let library =  UIAlertAction(title: "사진앨범", style: .default) { (action) in self.openLibrary()}

        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)

        alert.addAction(library)
        alert.addAction(cancel)

        present(alert, animated: true, completion: nil)
    }
    
    
    func openLibrary(){
        picker.sourceType = .photoLibrary
        present(picker, animated: false, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        picker.delegate = self
        
        
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
    

    
}



extension ViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info : [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            myImage.image = image
            
            print(info)
        }
        dismiss(animated: true, completion: nil)
    }
}

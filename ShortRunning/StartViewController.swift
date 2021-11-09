//
//  StartViewController.swift
//  ShortRunning
//
//  Created by 남영훈 on 2021/10/20.
//

import UIKit

class StartViewController: UIViewController {
    
    var goalRunning: Int = 0
    let imagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePickerController.delegate = self
        // Do any additional setup after loading the view.
    
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        print("StarViewController -> PageViewController")
        if segue.destination is PageViewController {
            let vc = segue.destination as? PageViewController
            vc?.goalRunning = goalRunning
        }
        
    }
    
    @IBAction func cameraButtonTapped(_ sender: Any) {
        self.imagePickerController.sourceType = .camera
        self.present(self.imagePickerController, animated: true, completion: nil)
    }
    
    
    @IBAction func calcelButtonTapped(_ sender: Any) {
        CustomLocationManager.shared.stopTracking()
        LocationService.shared.locationDataArray.removeAll()
        self.dismiss(animated: true) {
            self.parent?.navigationController?.popToRootViewController(animated: true)
        }
    }
    
}

extension StartViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(savedImage), nil)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    @objc
    func savedImage(image : UIImage, didFinishSavingWithError error: Error?, contenxtInfo: UnsafeMutableRawPointer?) {
        if let error = error {
            print(error)
            return
        }
        
        print("Success")
    }
}

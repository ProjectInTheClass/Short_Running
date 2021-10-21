//
//  RecordViewController.swift
//  ShortRunning
//
//  Created by 남영훈 on 2021/10/20.
//

import UIKit

class RecordViewController: UIViewController {

    @IBOutlet weak var goalMeterTextLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goalMeterTextLabel.text = String((self.parent as! PageViewController).goalRunning)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func stopButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }	
    
}

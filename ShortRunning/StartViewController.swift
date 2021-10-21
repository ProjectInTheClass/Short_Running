//
//  StartViewController.swift
//  ShortRunning
//
//  Created by 남영훈 on 2021/10/20.
//

import UIKit

class StartViewController: UIViewController {
    
    var goalRunning: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

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
    


    
  
}

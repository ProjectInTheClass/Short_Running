//
//  MainViewController.swift
//  ShortRunning
//
//  Created by 남영훈 on 2021/10/17.
//

import UIKit


class MainViewController: UIViewController {

    @IBOutlet weak var goalText: UILabel!

    var goalNumber = 10

    
    override func viewDidLoad() {
        super.viewDidLoad()

        goalText.text = String(goalNumber)
        
    }
    
    @IBAction func minusButtonTapped(_ sender: Any) {
        if(goalNumber > 0) {
            goalNumber -= 1
            goalText.text = String(goalNumber)
        } else {
            return
        }
    }
    
    @IBAction func plusButtonTapped(_ sender: Any) {
        goalNumber += 1
        goalText.text = String(goalNumber)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is StartViewController {
            print("MainViewController -> StartViewController")
            let vc = segue.destination as? StartViewController
            vc?.goalRunning = goalNumber
        }
    }

}



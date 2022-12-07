//
//  Result1ViewController.swift
//  navi
//
//  Created by student on 2019/11/27.
//  Copyright © 2019 student. All rights reserved.
//

import UIKit

class Result1ViewController: UIViewController {

    @IBOutlet weak var seikaiLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        seikaiLabel.text = String(appDelegate.seikaiCount)
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func back(_ sender: Any){
        //2つ前にもどる
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.seikaiCount = 0
        presentingViewController?.presentingViewController?.dismiss(animated: false, completion: nil)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

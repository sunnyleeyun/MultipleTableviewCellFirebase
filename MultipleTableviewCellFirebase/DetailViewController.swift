//
//  DetailViewController.swift
//  MultipleTableviewCellFirebase
//
//  Created by Mac on 2017/6/11.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class DetailViewController: UIViewController {

    @IBOutlet weak var foodImage: UIImageView!
    
    @IBOutlet weak var foodName: UITextField!
    
    @IBOutlet weak var cookTime: UITextField!
    
    @IBOutlet weak var cookHow: UITextView!
    
    var uid = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let user = FIRAuth.auth()?.currentUser {
            uid = user.uid
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  InitialViewController.swift
//  MultipleTableviewCellFirebase
//
//  Created by Mac on 2017/6/16.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class InitialViewController: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var passsword: UITextField!
    
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
    

    @IBAction func logIn(_ sender: Any) {
        
        if self.email.text != "" || self.passsword.text != ""{
            
            FIRAuth.auth()?.signIn(withEmail: self.email.text!, password: self.passsword.text!, completion: { (user, error) in
                
                if error == nil {
                    if let user = FIRAuth.auth()?.currentUser{
                        self.uid = user.uid
                    }
                    
                    FIRDatabase.database().reference(withPath: "Online-Status/\(self.uid)").setValue("ON")
                    
                    self.doneLogIn()
                }
                
            })
        }
        
    }

    @IBAction func signUp(_ sender: Any) {
        if self.email.text != "" || self.passsword.text != ""{
            
            FIRAuth.auth()?.createUser(withEmail: self.email.text!, password: self.passsword.text!, completion: { (user, error) in
                
                if error == nil {
                    if let user = FIRAuth.auth()?.currentUser{
                        
                        self.uid = user.uid
                        
                    }
                    
                    
                    FIRDatabase.database().reference(withPath: "ID/\(self.uid)/Profile/Safety-Check").setValue("ON")
                    FIRDatabase.database().reference(withPath: "Online-Status/\(self.uid)").setValue("ON")

                    self.doneSignUp()
                    
                    }
                
            })
        }
    }
    
    func doneLogIn(){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = storyboard.instantiateViewController(withIdentifier: "MainNavigationID") as! UINavigationController
        
        self.present(nextVC,animated:true,completion:nil)
        
    }
    
    func doneSignUp(){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = storyboard.instantiateViewController(withIdentifier: "SignUpViewControllerID")as! SignUpViewController
        self.present(nextVC,animated:true,completion:nil)
        

    }
    

}

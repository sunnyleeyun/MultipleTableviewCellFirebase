//
//  MainTableViewController.swift
//  MultipleTableviewCellFirebase
//
//  Created by Mac on 2017/6/11.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage

class MainTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var DishesTableView: UITableView!
    
    var refHandle: UInt!
    var databaseRef: FIRDatabaseReference!
    var storageRef: FIRStorageReference!
    
    var uid = ""
    
    
    var mealList = [Meals]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DishesTableView.delegate = self
        DishesTableView.dataSource = self
        
        if let user = FIRAuth.auth()?.currentUser {
            uid = user.uid
        }
        
        
        let rightButtonItem = UIBarButtonItem.init(
            title: "Add",
            style: .plain,
            target: self,
            action: "rightButtonAction:"
        )
        
        databaseRef = FIRDatabase.database().reference()
        storageRef = FIRStorage.storage().reference()
        


        fetchMealsList()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchMealsList(){
        
        //let uniqueString = NSUUID().uuidString

        refHandle = databaseRef.child("MealList").observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String : AnyObject]{
                print("dictionary is \(dictionary)")
                
                let mealDetail = Meals()
                
                mealDetail.setValuesForKeys(dictionary)
                self.mealList.append(mealDetail)
                
                DispatchQueue.main.async {
                    self.DishesTableView.reloadData()
                }
                
            }
            
        })
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mealList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DishesTableViewCell
        
        cell.nameMeal.text = mealList[indexPath.row].mealName
        cell.timeMeal.text = mealList[indexPath.row].mealTime
        
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goDetail()
    }
    
    
    func goDetail(){
        
    }
    
    
    func goDishes(){
        
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

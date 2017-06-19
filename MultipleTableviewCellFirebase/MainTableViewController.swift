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
    
    func done(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = storyboard.instantiateViewController(withIdentifier: "DishesViewControllerID") as! DishesViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DishesTableView.delegate = self
        DishesTableView.dataSource = self
        
        if let user = FIRAuth.auth()?.currentUser {
            uid = user.uid
        }
        
       
        
        let rightButtonItem = UIBarButtonItem.init(
            title: "新增",
            style: .done,
            target: self,
            action: #selector(done)
        )
        self.navigationItem.rightBarButtonItem = rightButtonItem
        
        
        databaseRef = FIRDatabase.database().reference()
        storageRef = FIRStorage.storage().reference()
        


        fetchMealsList()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchMealsList(){
        

        
        refHandle = databaseRef.child("Meal").observe(.childAdded, with: { (snapshot) in
            
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
        
        cell.cookNameMeal.text = mealList[indexPath.row].cookName
        cell.nameMeal.text = mealList[indexPath.row].FoodName
        cell.timeMeal.text = mealList[indexPath.row].cookTime

        if let profileImageUrl = mealList[indexPath.row].cookPic{
            let url = URL(string: profileImageUrl)
            URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                if error != nil{
                    print(error)
                    return
                }
                
                DispatchQueue.main.async {
                    cell.imageMeal.image = UIImage(data: data!)
                }
            
            }).resume()
            
        }
        
        cell.cookHowMeal.text = mealList[indexPath.row].cookhow
        
        
        return cell
        
        
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

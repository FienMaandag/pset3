//
//  ViewController.swift
//  FMaandag-pset3
//
//  Created by Fien Maandag on 21-04-17.
//  Copyright © 2017 Fien Maandag. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var movies: [String] {
        return UserDefaults.standard.array(forKey: "movies") as? [String] ?? []
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()
    }
    
    // TO DO add user delegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Your movies"
        self.navigationItem.hidesBackButton = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.allowsSelection = false 
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath)
        as! MovieCell
        
        URLSession.shared.dataTask(with: URL(string: movies[indexPath.row])!)  { (data, response, error) in
            if error != nil {
                print(error ?? "error")
            }
                
            else {
                do{
                    let parsedData = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
                    let title = parsedData["Title"] as! String?
                    let year = parsedData["Year"] as! String?
                    let img = parsedData["Poster"] as! String?
                    
                    let imgUrl = URL(string: img!)
                    let data = try? Data(contentsOf: imgUrl!)
                    
                    DispatchQueue.global().async {
                        DispatchQueue.main.async {
                            cell.movieTitle.text = title!
                            cell.movieYear.text = year!
                            cell.moviePoster.image = UIImage(data: data!)
                        }
                    }
                    
                } catch let error as NSError {
                    print(error)
                }
            }
            }.resume()
        
        return cell
    }
    
    // http://stackoverflow.com/questions/3309484/uitableviewcell-show-delete-button-on-swipe
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            var existing = UserDefaults.standard.array(forKey: "movies") as? [String] ?? []
            existing.remove(at: indexPath.row)
            UserDefaults.standard.set(existing, forKey: "movies")
            
            // delete the table view row
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

}


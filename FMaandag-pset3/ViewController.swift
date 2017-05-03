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

    // change into saved movies
    let movies = ["Lion King", "Alladin", "Tarzan"]
    let year = [
        "Lion King": "1994",
        "Alladin": "1992",
        "Tarzan": "1999"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Your movies"

        let url = URL(string: "https://omdbapi.com/?t=bean")
        
        URLSession.shared.dataTask(with:url!)  { (data, response, error) in
            if error != nil {
                print(error ?? "error")
            } else {
                do {
                    
                    let parsedData = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
                    let title = parsedData["Title"] as! String?
                print(title)
                    print("hey")
            } catch let error as NSError {
                print(error)
            }
        }
    }.resume()

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath)
        as! MovieCell
        
        cell.movieTitle.text = movies[indexPath.row]
        
        if let year = year[movies[indexPath.row]] {
            cell.movieYear.text = year
        }
        else{
            cell.movieYear.text = ""
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let indexPath = tableView.indexPathForSelectedRow
        
        if let movieVC = segue.destination as? MovieViewController{
            movieVC.movieTitle = movies[(indexPath?.row)!]
        }
    }

}


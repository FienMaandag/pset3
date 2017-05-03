//
//  AddMovieViewController.swift
//  FMaandag-pset3
//
//  Created by Fien Maandag on 21-04-17.
//  Copyright © 2017 Fien Maandag. All rights reserved.
//

import UIKit

class AddMovieViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var plotLabel: UITextView!
    @IBOutlet weak var posterImage: UIImageView!
    var url: URL?
    var movies = [URL?]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Add Movie"
        
        // Loaded late
        URLSession.shared.dataTask(with:url!)  { (data, response, error) in
            if error != nil {
                // TO DO add error messages
                print(error ?? "error")
            }
                
            else {
                do{
                    let parsedData = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
                    let title = parsedData["Title"] as! String?
                    let plot = parsedData["Plot"] as! String?
                    let year = parsedData["Year"] as! String?
                    let director = parsedData["Director"] as! String?
                    let img = parsedData["Poster"] as! String?
                    
                    let imgUrl = URL(string: img!)
                    let data = try? Data(contentsOf: imgUrl!)
                    
                    DispatchQueue.global().async {
                        DispatchQueue.main.async {
                            self.titleLabel.text = title!
                            self.yearLabel.text = year!
                            self.directorLabel.text = director!
                            self.plotLabel.text = plot!
                            self.posterImage.image = UIImage(data: data!)
                        }
                    }
                    
                } catch let error as NSError {
                    // TO DO error messages
                    print(error)
                }
            }
            }.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func addMovieButton(_ sender: UIButton) {
        // TO DO add movie to saved list
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let firstVC = segue.destination as? ViewController{
            movies.append(url)
            firstVC.movies = movies
        }
    }
}

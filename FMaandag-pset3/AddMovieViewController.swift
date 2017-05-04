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
    
    @IBAction func addButtonPressed(_ sender: Any) {
        var existing = UserDefaults.standard.array(forKey: "movies") as? [String] ?? []
        existing.append(url!.absoluteString)
        UserDefaults.standard.set(existing, forKey: "movies")
        
        self.navigationController?.popToRootViewController(animated: true)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Add Movie"

        URLSession.shared.dataTask(with:url!)  { (data, response, error) in
            if error != nil {
                guard let responseData = data else{
                    let alertController = UIAlertController(title: "Error", message: "This movie is not found, please try again", preferredStyle: UIAlertControllerStyle.alert)
                    
                    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> navigationController?.popToRootViewController(animated: true)
                        // Void in
                    }
                    
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                }
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
                    print(error)
                }
            }
            }.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

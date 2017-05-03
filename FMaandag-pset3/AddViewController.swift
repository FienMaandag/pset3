//
//  AddViewController.swift
//  FMaandag-pset3
//
//  Created by Fien Maandag on 21-04-17.
//  Copyright © 2017 Fien Maandag. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    var url: URL?
    
    @IBOutlet weak var inputTitle: UITextField!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Search"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addMovieVC = segue.destination as? AddMovieViewController{
            let searchTitle = inputTitle.text?.replacingOccurrences(of: " ", with: "+")
            let emptyUrl = "https://omdbapi.com/?t="
            let url = URL(string: emptyUrl + searchTitle!)
            addMovieVC.url = url
        }
    }
}

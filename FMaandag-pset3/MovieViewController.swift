//
//  MovieViewController.swift
//  FMaandag-pset3
//
//  Created by Fien Maandag on 21-04-17.
//  Copyright © 2017 Fien Maandag. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController {

    var movieTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = movieTitle
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

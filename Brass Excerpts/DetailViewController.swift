//
//  DetailViewController.swift
//  Brass Excerpts
//
//  Created by Thomas Swatland on 03/12/2017.
//  Copyright © 2017 Thomas Swatland. All rights reserved.
//

import UIKit
import PDFKit

class DetailViewController: UIViewController {

    @IBOutlet weak var pleaseSelectLabel: UILabel!
    @IBOutlet weak var detailDescriptionLabel: UILabel!

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let label = detailDescriptionLabel {
                label.text = detail.description
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var detailItem: NSDate? {
        didSet {
            // Update the view.
            configureView()
        }
    }

    @IBAction func shareButtonPressed(_ sender: Any) {

    }
    
}


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
    
    @IBOutlet weak var selectLabel: UILabel!
    let pdfView = PDFView(frame: UIScreen.main.bounds)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pdfView.clipsToBounds = true
        view.addSubview(pdfView)
    }

    @IBAction func shareButtonPressed(_ sender: Any) {

    }
}


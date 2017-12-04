//
//  MasterViewController.swift
//  Brass Excerpts
//
//  Created by Thomas Swatland on 03/12/2017.
//  Copyright © 2017 Thomas Swatland. All rights reserved.
//

import UIKit
import PDFKit

class MasterViewController: UITableViewController {
    
    @IBOutlet weak var instrumentPicker: UISegmentedControl!

    var detailViewController: DetailViewController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destVC = (segue.destination as! UINavigationController).topViewController as! DetailViewController

                destVC.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                destVC.navigationItem.leftItemsSupplementBackButton = true
                
                // REFACTOR THIS!!!
                var pdfTitle = String()
                pdfTitle = "Symphony no. 5 (Mahler) tenor"
                let subDir = "Test Blue"
                let url = Bundle.main.url(forResource: pdfTitle, withExtension: ".pdf", subdirectory: subDir)

                if let document = PDFDocument(url: url!) {
                    destVC.pdfView.document = document
                }
            }
        }
    }

    // MARK: - Table View Data Source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        switch instrumentPicker.selectedSegmentIndex {
        case 0: return trumpetExcerpts.count
        case 1: return tromboneExcerpts.count
        case 2: return tromboneExcerpts.count
        case 3: return tubaExcerpts.count
        default: fatalError()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch instrumentPicker.selectedSegmentIndex {
        case 0: return trumpetExcerpts[section].pieces.count
        case 1: return tromboneExcerpts[section].pieces.count
        case 2: return tromboneExcerpts[section].pieces.count
        case 3: return tubaExcerpts[section].pieces.count
        default: fatalError()
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        switch instrumentPicker.selectedSegmentIndex {
        case 0: cell.textLabel?.text = trumpetExcerpts[indexPath.section].pieces[indexPath.row]
        case 1: cell.textLabel?.text = tromboneExcerpts[indexPath.section].pieces[indexPath.row]
        case 2: cell.textLabel?.text = tromboneExcerpts[indexPath.section].pieces[indexPath.row]
        case 3: cell.textLabel?.text = tubaExcerpts[indexPath.section].pieces[indexPath.row]
        default: fatalError()
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch instrumentPicker.selectedSegmentIndex {
        case 0: return "\(trumpetExcerpts[section].composer.uppercased()), \(trumpetExcerpts[section].firstName)"
        case 1: return "\(tromboneExcerpts[section].composer.uppercased()), \(tromboneExcerpts[section].firstName)"
        case 2: return "\(tromboneExcerpts[section].composer.uppercased()), \(tromboneExcerpts[section].firstName)"
        case 3: return "\(tubaExcerpts[section].composer.uppercased()), \(tubaExcerpts[section].firstName)"
        default: return nil
        }
    }
    
    @IBAction func instrumentPickerChosen(_ sender: UISegmentedControl) {
        tableView.reloadData()
    }
}


//
//  MasterViewController.swift
//  Brass Excerpts
//
//  Created by Thomas Swatland on 03/12/2017.
//  Copyright © 2017 Thomas Swatland. All rights reserved.
//

import UIKit
import FirebaseDatabase

class MasterViewController: UITableViewController {
    
    @IBOutlet weak var instrumentPicker: UISegmentedControl!
    
    var database = Database()
    var databaseRef = DatabaseReference()
    
    var chosenComposer = String()
    var chosenPiece = String()
    var chosenInstrument = String()
    var detailViewController: DetailViewController? = nil
    var composers = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        database = Database.database()
        databaseRef = database.reference()
        
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        populateExcerptLists()
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destVC = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                
                destVC.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                destVC.navigationItem.leftItemsSupplementBackButton = true
                
                switch instrumentPicker.selectedSegmentIndex {
                case 0:
                    chosenInstrument = "Trumpet"
                    chosenComposer = trumpetExcerpts[indexPath.section].composer
                    chosenPiece = trumpetExcerpts[indexPath.section].pieces[indexPath.row]
                    break
                case 1:
                    chosenInstrument = "French Horn"
                    chosenComposer = frenchHornExcerpts[indexPath.section].composer
                    chosenPiece = frenchHornExcerpts[indexPath.section].pieces[indexPath.row]
                    break
                case 2:
                    chosenInstrument = "Trombone"
                    chosenComposer = tromboneExcerpts[indexPath.section].composer
                    chosenPiece = tromboneExcerpts[indexPath.section].pieces[indexPath.row]
                    break
                case 3:
                    chosenInstrument = "Tuba"
                    chosenComposer = tubaExcerpts[indexPath.section].composer
                    chosenPiece = tubaExcerpts[indexPath.section].pieces[indexPath.row]
                    break
                default: fatalError()
                }
                
                destVC.title = chosenPiece
                destVC.filePath = "\(chosenComposer)/\(chosenPiece) (\(chosenComposer)).pdf"
                destVC.instrument = chosenInstrument
            }
        }
    }
    
    func populateExcerptLists() {
        databaseRef.child("trumpet").observe(.childAdded) { snapshot in
            trumpetExcerpts.append(Excerpt.init(composer: snapshot.key, pieces: snapshot.value as! [String]))
            self.tableView.reloadData()
        }
        
        databaseRef.child("french_horn").observe(.childAdded) { snapshot in
            frenchHornExcerpts.append(Excerpt.init(composer: snapshot.key, pieces: snapshot.value as! [String]))
        }
        databaseRef.child("trombone").observe(.childAdded) { snapshot in
            tromboneExcerpts.append(Excerpt.init(composer: snapshot.key, pieces: snapshot.value as! [String]))
        }
        
        databaseRef.child("tuba").observe(.childAdded) { snapshot in
            tubaExcerpts.append(Excerpt.init(composer: snapshot.key, pieces: snapshot.value as! [String]))
        }
    }
    
    @IBAction func instrumentPickerChosen(_ sender: UISegmentedControl) {
        tableView.reloadData()
    }
    
    // MARK: - Table View Data Source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        switch instrumentPicker.selectedSegmentIndex {
        case 0: return trumpetExcerpts.count
        case 1: return frenchHornExcerpts.count
        case 2: return tromboneExcerpts.count
        case 3: return tubaExcerpts.count
        default: fatalError()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch instrumentPicker.selectedSegmentIndex {
        case 0: return trumpetExcerpts[section].pieces.count
        case 1: return frenchHornExcerpts[section].pieces.count
        case 2: return tromboneExcerpts[section].pieces.count
        case 3: return tubaExcerpts[section].pieces.count
        default: fatalError()
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        switch instrumentPicker.selectedSegmentIndex {
        case 0: cell.textLabel?.text = trumpetExcerpts[indexPath.section].pieces[indexPath.row]
        case 1: cell.textLabel?.text = frenchHornExcerpts[indexPath.section].pieces[indexPath.row]
        case 2: cell.textLabel?.text = tromboneExcerpts[indexPath.section].pieces[indexPath.row]
        case 3: cell.textLabel?.text = tubaExcerpts[indexPath.section].pieces[indexPath.row]
        default: fatalError()
        }
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor(displayP3Red: 14/255, green: 122/255, blue: 254/255, alpha: 1)
        cell.selectedBackgroundView = bgColorView

        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch instrumentPicker.selectedSegmentIndex {
        case 0: return "\(trumpetExcerpts[section].composer.uppercased())"
        case 1: return "\(frenchHornExcerpts[section].composer.uppercased())"
        case 2: return "\(tromboneExcerpts[section].composer.uppercased())"
        case 3: return "\(tubaExcerpts[section].composer.uppercased())"
        default: return nil
        }
    }
}


//
//  EntryViewController.swift
//  Journal X Simple
//
//  Created by Amogh Joshi on 2/1/20.
//  Copyright © 2020 Amogh Joshi. All rights reserved.
//

import UIKit
import CoreData

class EntryViewController: UIViewController , UITextFieldDelegate , UINavigationControllerDelegate    {

    @IBOutlet weak var noteInfoView: UIView!
    @IBOutlet weak var TitleLabel: UITextField!
    
    @IBOutlet weak var descriptionTextField: UITextView!
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    var managedObject: NSManagedObjectContext? {
        return(UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
    }
    
    var notesFetchedResultsController: NSFetchedResultsController<Note>!
    var notes = [Note]()
    var note: Note?
    var isExisting = false
    var indexPath: Int?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Loading Jornal's.....
        if let note = note {
            TitleLabel.text = note.noteTitle
            descriptionTextField.text = note.noteDescription
            let formatter = DateFormatter()
            if let date = note.noteDate{
                let myDateString = formatter.string(from: date)
                navigationItem.title = myDateString
            }
        }
        
        if TitleLabel.text != "" {
                isExisting = true
        }
        
        
        // Delegates
        
        
    }
    
    
    
    @IBOutlet weak var deleteButtonTap: UIBarButtonItem!
  
    @IBAction func backButtonTapped(_ sender: Any) {
    }
    
}

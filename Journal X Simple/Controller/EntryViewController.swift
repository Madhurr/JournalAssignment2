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
        
        TitleLabel.delegate = self
        descriptionTextField.delegate = self as? UITextViewDelegate
        
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if let firstVC = presentingViewController as? EntriesViewController {
            DispatchQueue.main.async {
                firstVC.tableView.reloadData()
                
            }
        }
    }
    
    
    @IBOutlet weak var deleteButtonTap: UIBarButtonItem!
  
    @IBAction func backButtonTapped(_ sender: Any) {
        if TitleLabel.text == "" || descriptionTextField.text == "    Start Writing Your Entry  Here"{
            
            let isPresentingInAddNoteMode = presentingViewController is UINavigationController
            if isPresentingInAddNoteMode{
                dismiss(animated: true, completion: nil)
            }else{
                navigationController!.popViewController(animated: true)
            }
        }else {
            if(isExisting == false){
                let noteTitle = TitleLabel.text
                let noteDescription = descriptionTextField.text
                
                if let moc = managedObject{
                    let note = Note(context: moc)
                    note.noteTitle = noteTitle
                    note.noteDescription = noteDescription
                    
                    saveToCoreData {
                        let isPresentingInAddNoteMode = self.presentingViewController is UINavigationController
                        
                        if isPresentingInAddNoteMode{
                            self.dismiss(animated: true, completion: nil)
                            
                        }else{
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                }
            }
            else if (isExisting == true){
                let note = self.note
                let managedObject = note
                managedObject?.setValue(TitleLabel.text, forKey: "noteTitle")
                managedObject?.setValue(descriptionTextField.text, forKey: "noteDescription")
                managedObject?.setValue(navigationItem.title, forKey: "noteDateStr")
                do {
                    try context.save()
                    
                    let isPresentingInAddNoteMode = self.presentingViewController is UINavigationController
                        
                    if isPresentingInAddNoteMode {
                        self.dismiss(animated: true, completion: nil)
                    }else{
                        self.navigationController!.popViewController(animated: true)
                    }
                }
                
                catch{
                    print("Failed to Update existing note.")
                }
                
            }
        }
    }
    
    
    // MARK: TextFiled Properties
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    func textView(_ textView: UITextView , shouldChangeTextIn range: NSRange, replcaementText text: String) -> Bool{
        if(text == "\n"){
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    private func textViewDidBeginEditing(_ textView: UITextView){
        if(textView.text == "Note Description..."){
            textView.text = ""
        }
    }
    
    
    // MARK: Core Date Setup
    
    func saveToCoreData(completion: @escaping () -> Void){
        managedObject?.perform {
            do {
                try self.managedObject?.save()
                completion()
                print("Your Data Saved in Core Data")
            }
            catch let error {
                print("Could not save data inside Core Data \(error.localizedDescription)")
            }
        }
    }
    
}

//
//  ViewController.swift
//  Journal X Simple
//
//  Created by Amogh Joshi on 2/1/20.
//  Copyright © 2020 Amogh Joshi. All rights reserved.
//

import UIKit
import CoreData
class EntriesViewController: UITableViewController {
    
    
    var notes = [Note]()
    var dateStr = ""
    var managedObjectContext: NSManagedObjectContext? {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retriveNotes()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        return retriveNotes()
    }
    
    
    @IBAction func addNoteTapped(_ sender: Any) {
    
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotesTableViewCell" , for: indexPath) as! noteTableViewCell
        // Configure The Cell
        
        let note : Note = notes[indexPath.row]
        cell.configureCell(note: note)
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCell.EditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            self.tableView.deleteRows(at: [(indexPath as IndexPath)], with: UITableView.RowAnimation.automatic)
       }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
          let delete = UITableViewRowAction(style: .destructive, title: "                    ") { (action, indexPath) in
              
              let note = self.notes[indexPath.row]
              context.delete(note)
              
              (UIApplication.shared.delegate as! AppDelegate).saveContext()
              do {
                  self.notes = try context.fetch(Note.fetchRequest())
              }
                  
              catch {
                  print("Failed to delete note.")
              }
              
              tableView.deleteRows(at: [indexPath], with: .fade)
              tableView.reloadData()

          }
          
//          delete.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "trashIcon"))
          
          return [delete]

      }
    
    func retriveNotes(){
        managedObjectContext?.perform {
            self.fetchNotesFromCoreData { (notes) in
                if let notes = notes{
                    self.notes = notes
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func fetchNotesFromCoreData(completion: @escaping ([Note]?) -> Void){
      managedObjectContext?.perform {
            var notes = [Note]()
            let request: NSFetchRequest<Note> = Note.fetchRequest()
            
            do{
                notes = try self.managedObjectContext!.fetch(request)
                completion(notes)
            }
            catch{
                print("Could Not Fetch Notes From Core Data: \(error.localizedDescription)")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                
                let noteDetailsViewController = segue.destination as! EntryViewController
                let selectedNote: Note = notes[indexPath.row]
                
                noteDetailsViewController.indexPath = indexPath.row
                //noteDetailsViewController.isExisting = false
                noteDetailsViewController.note = selectedNote
                self.tableView.reloadData()
                
            }
            
        }
            
        else if segue.identifier == "addItem" {
            print("User added a new note.")
            self.tableView.reloadData()

        }

    }
}



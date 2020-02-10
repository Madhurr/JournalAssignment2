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
    
    var mangedObjectContext: NSManagedObjectContext? {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        return retriveNotes()
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
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        tableView.reloadData()
    }
    
    
    func retriveNotes(){
        mangedObjectContext?.perform {
            self.fetchNotesFromCoreData { (notes) in
                if let notes = notes{
                    self.notes = notes
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func fetchNotesFromCoreData(completion: @escaping ([Note]?) -> Void){
        mangedObjectContext?.perform {
            var notes = [Note]()
            let request: NSFetchRequest<Note> = Note.fetchRequest()
            
            do{
                notes = try self.mangedObjectContext!.fetch(request)
                completion(notes)
            }
            catch{
                print("Could Not Fetch Notes From Core Data: \(error.localizedDescription)")
            }
        }
    }
}



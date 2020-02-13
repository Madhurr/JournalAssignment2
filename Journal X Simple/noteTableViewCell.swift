//
//  noteTableViewCell.swift
//  Journal X Simple
//
//  Created by ADM-12 on 10/02/20.
//  Copyright © 2020 Amogh Joshi. All rights reserved.
//

import UIKit
import CoreData
class noteTableViewCell: UITableViewCell {
    
    var notes = [Note]()
    var note: Note?
    var uiColorArray = [UIColor]()
    @IBOutlet weak var DescriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cellDivisorView: UIView!
    

    @IBOutlet weak var datePickerTextField: DesignableTextField!
    
    
    var managedObject: NSManagedObjectContext? {
        return(UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
    }
    var dateString : String = ""
    private var datePicker : UIDatePicker?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      datePicker = UIDatePicker()
      datePicker?.datePickerMode = .date
      datePicker?.addTarget(self, action: #selector(noteTableViewCell.dateChanged(datePicker:)), for: .valueChanged)
        
       
        let tapGestureRecognizer = UIGestureRecognizer(target: self, action: #selector(noteTableViewCell.viewTapped(gestureRecognizer:)) )
        addGestureRecognizer(tapGestureRecognizer)
      datePickerTextField.inputView = datePicker
        
    }

    
 
   
    
    @objc func dateChanged(datePicker: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM"
        datePickerTextField.text = dateFormatter.string(from: datePicker.date)
        dateString =  dateFormatter.string(from: datePicker.date)
        datePicker.inputView?.endEditing(true)
    }
    
    
    
   @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        
    }
   
    
    override func setSelected(_ selected: Bool, animated: Bool) {
         super.setSelected(selected, animated: animated)

         // Configure the view for the selected state
     }
    
    
    func configureCell(note: Note){
        self.titleLabel.text = note.noteTitle?.uppercased()
        self.DescriptionLabel.text = note.noteDescription
       let formatter = DateFormatter()
       if let date = note.noteDate{
           let myDateString = formatter.string(from: date)
        self.datePickerTextField.text = myDateString
       }
        self.datePickerTextField.backgroundColor = hexStringToUIColor(hex: K.randomEntriesColor.randomElement()!)
        self.cellDivisorView.backgroundColor = self.datePickerTextField.backgroundColor
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

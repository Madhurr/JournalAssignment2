//
//  noteTableViewCell.swift
//  Journal X Simple
//
//  Created by ADM-12 on 10/02/20.
//  Copyright © 2020 Amogh Joshi. All rights reserved.
//

import UIKit

class noteTableViewCell: UITableViewCell {

    @IBOutlet weak var DescriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cellDivisorView: UIView!
    

    @IBOutlet weak var datePickerTextField: DesignableTextField!
    
    
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
        dateFormatter.dateFormat = "dd/MMMM"
        datePickerTextField.text = dateFormatter.string(from: datePicker.date)
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
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: Date())
        let cellDateString = formatter.date(from: dateString)
        formatter.dateFormat = "dd-MM-yyyy"
        let myDateString = formatter.string(from: cellDateString!)
//        self.datePickerButton.titleLabel?.transform =  self.datePickerButton.titleLabel?.transform.rotated(by: CGFloat(M_PI_2)) ?? ""
//        self.datePickerButton.titleLabel?.text = myDateString
    }
}
extension UILabel {
@IBInspectable
var rotation: Int {
    get {
        return 0
    } set {
        let radians = CGFloat(CGFloat(Double.pi) * CGFloat(newValue) / CGFloat(180.0))
        self.transform = CGAffineTransform(rotationAngle: radians)
    }
    }
}
@IBDesignable
class DesignableView: UIView {
}

@IBDesignable
class DesignableButton: UIButton {
}

@IBDesignable
class DesignableLabel: UILabel {
}

@IBDesignable
class DesignableTextField: UITextField{
    
}

@IBDesignable
extension UIView {
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }

    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}
extension UITextField {
    @IBInspectable
    var rotation: Int {
        get {
            return 0
        } set {
            let radians = CGFloat(CGFloat(Double.pi) * CGFloat(newValue) / CGFloat(180.0))
            self.transform = CGAffineTransform(rotationAngle: radians)
        }
    }
}

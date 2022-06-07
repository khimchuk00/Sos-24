//
//  DatePickerViewController.swift
//  SOS24
//
//  Created by Valentyn Khimchuk on 09.03.2021.
//

import UIKit

class DatePickerViewController: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    var donePressed: ((Date) -> Void)!
    var cancelPressed: (() -> Void)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(cancelButtonDidTap))
        view.addGestureRecognizer(tapGestureRecognizer)
        configureButtons()
        configureView()
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        datePicker.minimumDate = Date()
    }
        
    func configureButtons() {
        doneButton.layer.cornerRadius = 10
        cancelButton.layer.cornerRadius = 10
        cancelButton.layer.borderWidth = 2
        cancelButton.layer.borderColor = Theme.Colors.themeBlack.cgColor
    }
    
    func configureView() {
        containerView.layer.cornerRadius = 10
    }
    
    @IBAction func cancelButtonDidTap() {
        dismiss(animated: false) {
            self.cancelPressed()
        }
    }
    
    @IBAction func pickButtonDidTap() {
        dismiss(animated: false) {
            self.donePressed(self.datePicker.date)
        }
    }
}

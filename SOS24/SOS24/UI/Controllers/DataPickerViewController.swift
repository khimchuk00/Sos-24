//
//  DataPickerViewController.swift
//  SOS24
//
//  Created by Valentyn Khimchuk on 09.03.2021.
//

import UIKit

class DataPickerViewController: UIViewController {
    @IBOutlet weak var dataPicker: UIPickerView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    var dataProvider: PickerDataProvider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(cancelButtonDidTap))
        view.addGestureRecognizer(tapGestureRecognizer)
        configureButtons()
        configurePicker()
        configureView()
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
    
    func configurePicker() {
        dataPicker.delegate = self
        dataPicker.dataSource = self
    }
    
    @IBAction func cancelButtonDidTap() {
        dismiss(animated: false) {
            self.dataProvider.cancelPressed()
        }
    }
    
    @IBAction func pickButtonDidTap() {
        dismiss(animated: false) {
            self.dataProvider.donePressed(with: self.dataPicker.selectedRow(inComponent: 0))
        }
    }
}

extension DataPickerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        dataProvider.rowsCount()
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        dataProvider.titleForRow(at: row)
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        35
    }
}



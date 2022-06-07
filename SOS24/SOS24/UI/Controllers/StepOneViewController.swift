//
//  StepOneViewController.swift
//  SOS24
//
//  Created by Valentyn Khimchuk on 05.03.2021.
//

import UIKit

class StepOneViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var stepLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var contentView: UIView!
    
    var application: Application?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButtons()
        configureLabels()
        configureViews()
        configureTextFields()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        nameTextField.text = ""
        numberTextField.text = ""
        addressTextField.text = ""
    }
    
    func configureButtons() {
        nextButton.layer.cornerRadius = 10
    }
    
    func configureViews() {
        headerView.layer.cornerRadius = 10
        contentView.layer.cornerRadius = 10
        contentView.layer.shadowColor = Theme.Colors.themeShadow.withAlphaComponent(0.15).cgColor
        contentView.layer.shadowOpacity = 1
        contentView.layer.shadowOffset = CGSize(width: 0, height: 6.05)
    }
    
    func configureTextFields() {
        nameTextField.delegate = self
        numberTextField.delegate = self
        addressTextField.delegate = self
        nameTextField.autocapitalizationType = .sentences
    }
    
    @objc func keyboardWillShow(notification:NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        var keyboardFrame: CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)

        var contentInset: UIEdgeInsets = scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height + 20
        scrollView.contentInset = contentInset
    }

    @objc func keyboardWillHide(notification:NSNotification) {
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
    
    func configureLabels() {
        let stepLabelAttrText = NSMutableAttributedString(string: "Шаг 1 ", attributes: [
                                                    .foregroundColor: Theme.Colors.themeOrange])
        stepLabelAttrText.append(NSAttributedString(string: "из 3", attributes: [.foregroundColor: Theme.Colors.themeBlack]))
        stepLabel.attributedText = stepLabelAttrText
        
        let starAttrText = NSAttributedString(string: "*", attributes: [
                                                    .foregroundColor: UIColor.red,
                                                    .baselineOffset: 2])
        
        let nameLabelAttrText = NSMutableAttributedString(string: "Ваше имя", attributes: [
                                                .foregroundColor: Theme.Colors.themeDarkGray])
        nameLabelAttrText.append(starAttrText)
        nameLabel.attributedText = nameLabelAttrText
        
        let numberLabelAttrText = NSMutableAttributedString(string: "Ваш телефон", attributes: [
                                                .foregroundColor: Theme.Colors.themeDarkGray])
        numberLabelAttrText.append(starAttrText)
        numberLabel.attributedText = numberLabelAttrText
        
        let addressLabelAttrText = NSMutableAttributedString(string: "Ваш адрес", attributes: [
                                                .foregroundColor: Theme.Colors.themeDarkGray])
        addressLabelAttrText.append(starAttrText)
        addressLabel.attributedText = addressLabelAttrText
    }
    
    func checkOperator() -> Bool {
        if let text = numberTextField.text, !text.isEmpty, text.count > 6 {
            let ind5 = text.index(text.startIndex, offsetBy: 4)
            let ind6 = text.index(text.startIndex, offsetBy: 5)
            let operators = ["39", "50", "63", "66", "67", "68", "91", "92", "93", "94", "95", "96", "97", "98", "99"]
            let phoneOperator = text[ind5...ind6]
            if operators.contains(String(phoneOperator)) {
                return true
            }
        }
        return false
    }
    //MARK: - Actions
    
    @IBAction func nextButtonDidTap() {
        if let name = nameTextField.text, !name.isEmpty, let number = numberTextField.text, number.validatePhoneNumber(), let address = addressTextField.text, !address.isEmpty, checkOperator() {
            application = Application(name: name, phoneNumber: number, address: address)
            let vc = MainStoryboard.stepTwoViewController
            vc.application = application
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false)
        } else {
            var message = "Заполните все поля"
            if !checkOperator(), let name = nameTextField.text, !name.isEmpty {
                message = "Неправильный номер телефона"
            }
            let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true)
        }
    }
}


extension StepOneViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        switch textField {
        case nameTextField:
            numberTextField.becomeFirstResponder()
        case numberTextField:
            addressTextField.becomeFirstResponder()
        default:
            break
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == numberTextField, let text = textField.text, text.isEmpty {
            numberTextField.text = "+380"
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let currentCharacterCount = textField.text?.count ?? 0
        if range.length + range.location > currentCharacterCount {
            return false
        }
        let newLength = currentCharacterCount + string.count - range.length
        return newLength <= 13
    }
}


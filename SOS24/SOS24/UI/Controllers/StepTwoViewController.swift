//
//  StepTwoViewController.swift
//  SOS24
//
//  Created by Valentyn Khimchuk on 05.03.2021.
//

import UIKit

class StepTwoViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var stepLabel: UILabel!
    @IBOutlet weak var orderTypeTextField: UITextField!
    @IBOutlet weak var serviceTypeTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var orderTypeLabel: UILabel!
    @IBOutlet weak var serviceTypeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var orderButton: UIButton!
    @IBOutlet weak var serviceButton: UIButton!
    @IBOutlet weak var dateButton: UIButton!
    @IBOutlet weak var contentView: UIView!
    
    var application: Application!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButtons()
        configureLabels()
        configureViews()
        configureFields()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func configureViews() {
        headerView.layer.cornerRadius = 10
        contentView.layer.cornerRadius = 10
        contentView.layer.shadowColor = Theme.Colors.themeShadow.withAlphaComponent(0.15).cgColor
        contentView.layer.shadowOpacity = 1
        contentView.layer.shadowOffset = CGSize(width: 0, height: 6.05)
    }
    
    func configureButtons() {
        nextButton.layer.cornerRadius = 10
        backButton.layer.cornerRadius = 10
        backButton.layer.borderWidth = 2
        backButton.layer.borderColor = Theme.Colors.themeBlack.cgColor
    }
    
    func configureFields() {
        let orderTap = UITapGestureRecognizer(target: self, action: #selector(orderButtonDidTap))
        orderTypeTextField.addGestureRecognizer(orderTap)
        let serviceTap = UITapGestureRecognizer(target: self, action: #selector(serviceButtonDidTap))
        serviceTypeTextField.addGestureRecognizer(serviceTap)
        let dateTap = UITapGestureRecognizer(target: self, action: #selector(dateButtonDidTap))
        dateTextField.addGestureRecognizer(dateTap)
        commentTextField.delegate = self
    }
    
    func configureLabels() {
        let stepLabelAttrText = NSMutableAttributedString(string: "Шаг 2 ", attributes: [
                                                            .foregroundColor: Theme.Colors.themeOrange])
        stepLabelAttrText.append(NSAttributedString(string: "из 3", attributes: [.foregroundColor: Theme.Colors.themeBlack]))
        stepLabel.attributedText = stepLabelAttrText
        
        let starAttrText = NSAttributedString(string: "*", attributes: [
                                                .foregroundColor: UIColor.red,
                                                .baselineOffset: 2])
        
        let orderTypeLabelAttrText = NSMutableAttributedString(string: "Тип заказа", attributes: [
                                                                .foregroundColor: Theme.Colors.themeDarkGray])
        orderTypeLabelAttrText.append(starAttrText)
        orderTypeLabel.attributedText = orderTypeLabelAttrText
        
        let serviceTypeLabelAttrText = NSMutableAttributedString(string: "Вид услуг", attributes: [
                                                                    .foregroundColor: Theme.Colors.themeDarkGray])
        serviceTypeLabelAttrText.append(starAttrText)
        serviceTypeLabel.attributedText = serviceTypeLabelAttrText
        
        let dateLabelAttrText = NSMutableAttributedString(string: "Дата выполнения", attributes: [
                                                            .foregroundColor: Theme.Colors.themeDarkGray])
        dateLabelAttrText.append(starAttrText)
        dateLabel.attributedText = dateLabelAttrText
    }
    @objc func
    keyboardWillShow(notification:NSNotification) {
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
    
    //MARK: - Actions
    
    @IBAction func nextButtonDidTap() {
        if let order = orderTypeTextField.text, !order.isEmpty, let service = serviceTypeTextField.text, !service.isEmpty, let date = dateTextField.text, !date.isEmpty {
            if let comment = commentTextField.text, !comment.isEmpty {
                application.comment = comment
            } else {
                application.comment = "--"
            }
            let vc = MainStoryboard.stepThreeViewController
            vc.application = application
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false)
        } else {
            let alert = UIAlertController(title: "Ошибка", message: "Заполните все поля", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    @IBAction func backButtonDidTap() {
        dismiss(animated: false)
    }
    
    @IBAction func orderButtonDidTap() {
        let vc = MainStoryboard.dataPickerViewController
        let dataProvider = OrderTypePickerDataProvider(orderTypes: ["Срочный ремонт", "Плановый ремонт", "Бесплатный выезд для оценки состояния коммуникаций"]) { data in
            self.orderTypeTextField.text = data
            self.application.orderType = data
        }
        vc.dataProvider = dataProvider
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
    
    @IBAction func serviceButtonDidTap() {
        let vc = MainStoryboard.dataPickerViewController
        let dataProvider = OrderTypePickerDataProvider(orderTypes: ["Сантехнические работы", "Электромонтажные работы", "Плотницкие работы", "Ремонт бытовой техники", "Другие услуги"]) { data in
            self.serviceTypeTextField.text = data
            self.application.serviceType = data
        }
        vc.dataProvider = dataProvider
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
    
    @IBAction func dateButtonDidTap() {
        let vc = MainStoryboard.datePickerViewController
        vc.donePressed = { date in
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            self.dateTextField.text = formatter.string(from: date)
            self.application.date = formatter.string(from: date)
        }
        vc.cancelPressed = {}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
}

extension StepTwoViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

//
//  StepThreeViewController.swift
//  SOS24
//
//  Created by Valentyn Khimchuk on 09.03.2021.
//

import UIKit

class StepThreeViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var stepLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var orderTypeLabel: UILabel!
    @IBOutlet weak var serviceTypeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var application: Application!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButtons()
        configureLabels()
        configureViews()
        setupActivityIndicator()
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
    
    func configureLabels() {
        let stepLabelAttrText = NSMutableAttributedString(string: "Шаг 3 ", attributes: [
                                                            .foregroundColor: Theme.Colors.themeOrange])
        stepLabelAttrText.append(NSAttributedString(string: "из 3", attributes: [.foregroundColor: Theme.Colors.themeBlack]))
        stepLabel.attributedText = stepLabelAttrText
        
        nameLabel.text = application.name
        numberLabel.text = application.phoneNumber
        dateLabel.text = application.date
        orderTypeLabel.text = application.orderType
        serviceTypeLabel.text = application.serviceType
        addressLabel.text = application.address
        commentLabel.text = application.comment
    }
    
    func startSpining() {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
    }
    
    func stopSpining() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    
    func setupActivityIndicator() {
        activityIndicator.style = .large
        activityIndicator.isHidden = true
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
    
    //MARK: - Actions
    
    @IBAction func nextButtonDidTap() {
        startSpining()
        NetworkManager.shared.sendData(application: application) {
            self.stopSpining()
            let vc = MainStoryboard.successedViewController
            vc.modalPresentationStyle = .overCurrentContext
            self.present(vc, animated: false)
        } failure: { error in
            self.stopSpining()
            let alert = UIAlertController(title: "Ошибка", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    @IBAction func backButtonDidTap() {
        dismiss(animated: false)
    }
}

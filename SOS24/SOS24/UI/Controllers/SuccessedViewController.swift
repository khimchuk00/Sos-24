//
//  SuccessedViewController.swift
//  SOS24
//
//  Created by Valentyn Khimchuk on 09.03.2021.
//

import UIKit

class SuccessedViewController: UIViewController {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButtons()
        configureViews()
    }
    
    func configureViews() {
        contentView.layer.cornerRadius = 10
        contentView.layer.shadowColor = Theme.Colors.themeShadow.withAlphaComponent(0.15).cgColor
        contentView.layer.shadowOpacity = 1
        contentView.layer.shadowOffset = CGSize(width: 0, height: 6.05)
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
    }
    
    func configureButtons() {
        backButton.layer.cornerRadius = 10
    }
    
    @IBAction func backButtonDidTap() {
        UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: true, completion: nil)
    }
}

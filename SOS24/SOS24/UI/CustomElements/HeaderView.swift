//
//  HeaderView.swift
//  SOS24
//
//  Created by Valentyn Khimchuk on 05.03.2021.
//

import UIKit

class HeaderView: UIView {
    
    @IBOutlet weak var callButton: UIButton!
    var contentView: UIView?
    @IBInspectable var nibName:String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        xibSetup()
        configureButton()
    }
    
    func xibSetup() {
        guard let view = loadViewFromNib() else { return }
        view.frame = bounds
        view.autoresizingMask =
            [.flexibleWidth, .flexibleHeight]
        view.layer.cornerRadius = 10
        addSubview(view)
        contentView = view
    }
    
    func loadViewFromNib() -> UIView? {
        guard let nibName = nibName else { return nil }
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(
            withOwner: self,
            options: nil).first as? UIView
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        xibSetup()
        contentView?.prepareForInterfaceBuilder()
    }
    
    private func configureButton() {
        callButton.layer.cornerRadius = 10
        callButton.backgroundColor = UIColor.clear
        callButton.layer.borderWidth = 2
        callButton.layer.borderColor = Theme.Colors.themeOrange.cgColor
    }
    
    @IBAction func callButtonDidTap() {
        let telephoneNumber = "tel://0800209209"
        UIApplication.shared.open(URL(string: telephoneNumber)!, completionHandler: nil)
    }
}

//
//  SOSStackView.swift
//  SOS24
//
//  Created by Valentyn Khimchuk on 05.03.2021.
//

import UIKit

class SOSStackView: UIView {
    
    @IBOutlet weak var stackView: UIStackView!
    
    var contentView: UIView?
    @IBInspectable var nibName:String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        xibSetup()
    }
    
    func xibSetup() {
        guard let view = loadViewFromNib() else { return }
        view.frame = bounds
        view.autoresizingMask =
            [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        contentView = view
        stackView.alignment = .center
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
    
    @IBAction func instagramButtonDidTap() {
        guard let url = URL(string: "https://www.instagram.com/service24sos"), UIApplication.shared.canOpenURL(url) else { return }
        
        UIApplication.shared.open(url, completionHandler: nil)
    }
    
    @IBAction func vkButtonDidTap() {
        guard let url = URL(string: "https://www.instagram.com/service24sos"), UIApplication.shared.canOpenURL(url) else { return }
        
        UIApplication.shared.open(url, completionHandler: nil)
    }
    
    @IBAction func facebookButtonDidTap() {
        guard let url = URL(string: "https://www.facebook.com/service24.sos"), UIApplication.shared.canOpenURL(url) else { return }
        
        UIApplication.shared.open(url, completionHandler: nil)
    }
    
    @IBAction func youtubeButtonDidTap() {
        guard let url = URL(string: "https://www.instagram.com/service24sos"), UIApplication.shared.canOpenURL(url) else { return }
        
        UIApplication.shared.open(url, completionHandler: nil)
    }
    
    @IBAction func twitterButtonDidTap() {
        guard let url = URL(string: "https://twitter.com/service24sos"), UIApplication.shared.canOpenURL(url) else { return }
        
        UIApplication.shared.open(url, completionHandler: nil)
    }
}

//
//  UIViewController+NameOfClass.swift
//  WayToMaster
//
//  Created by Valentyn Khimchuk on 04.03.2021.
//

import UIKit

extension UIViewController {
    static var controllerIdentifier: String {
        return String(describing: self)
    }
}

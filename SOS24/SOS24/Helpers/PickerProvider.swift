//
//  PickerProvider.swift
//  SOS24
//
//  Created by Valentyn Khimchuk on 09.03.2021.
//

import Foundation

protocol PickerDataProvider: class {
    var defaultSelectedIndex: Int { get }
    func rowsCount() -> Int
    func titleForRow(at index: Int) -> String
    // MARK: - Actions
    func donePressed(with index: Int)
    func cancelPressed()
    typealias PickerCancelAction = () -> Void
    var cancelAction: PickerCancelAction? { get set }
}


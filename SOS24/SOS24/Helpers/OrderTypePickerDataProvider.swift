//
//  OrderTypePickerDataProvider.swift
//  SOS24
//
//  Created by Valentyn Khimchuk on 09.03.2021.
//

import Foundation

class OrderTypePickerDataProvider: PickerDataProvider {

    typealias PickerSelectOrderTypeAction = (String) -> Void
    private var selectAction: PickerSelectOrderTypeAction
    var cancelAction: PickerCancelAction?
    
    private var orderTypes: [String] = []
    private var selectedType: String?
    
    init(orderTypes: [String], select: @escaping PickerSelectOrderTypeAction, cancel: PickerCancelAction? = nil) {
        self.orderTypes = orderTypes
        self.cancelAction = cancel
        self.selectAction = select
    }
    
    var defaultSelectedIndex: Int {
        if let orderType = selectedType {
            return orderTypes.firstIndex(of: orderType) ?? 0
        } else {
            return 0
        }
    }
    
    func rowsCount() -> Int {
        orderTypes.count
    }
    
    func titleForRow(at index: Int) -> String {
        orderTypes[index]
    }
    
    func donePressed(with index: Int) {
        selectAction(orderTypes[index])
    }
    
    func cancelPressed() {
        cancelAction?()
    }
}

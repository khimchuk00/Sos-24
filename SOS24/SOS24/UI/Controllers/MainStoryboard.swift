//
//  ViewController.swift
//  SOS24
//
//  Created by Valentyn Khimchuk on 05.03.2021.
//

import Foundation

struct MainStoryboard: StoryboardInstantiable {
    
    static var storyboard: Storyboard {
        .main
    }
    
    static var stepOneViewController: StepOneViewController {
        instantiateVC(type: StepOneViewController.self)
    }
    
    static var stepTwoViewController: StepTwoViewController {
        instantiateVC(type: StepTwoViewController.self)
    }
    
    static var stepThreeViewController: StepThreeViewController {
        instantiateVC(type: StepThreeViewController.self)
    }
    
    static var dataPickerViewController: DataPickerViewController {
        instantiateVC(type: DataPickerViewController.self)
    }
    
    static var datePickerViewController: DatePickerViewController {
        instantiateVC(type: DatePickerViewController.self)
    }
    
    static var successedViewController: SuccessedViewController {
        instantiateVC(type: SuccessedViewController.self)
    }
}

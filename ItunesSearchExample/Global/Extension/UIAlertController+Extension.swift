//
//  UIAlertController+Extension.swift
//  ItunesSearchExample
//
//  Created by Joon Baek on 2024/04/21.
//

import UIKit

extension UIAlertController {
    func showAlert(title: String, message: String, cancelButton: Bool = true, viewController: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "확인", style: .default)
        let cancel = UIAlertAction(title: "취소", style: .destructive)
        
        alertController.addAction(ok)
        
        if cancelButton {
            alertController.addAction(cancel)
        }
        
        viewController.present(alertController, animated: true)
    }
}

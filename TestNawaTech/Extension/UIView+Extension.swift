//
//  UIView+Extension.swift
//  TestNawaTech
//
//  Created by reyhan muhammad on 28/08/23.
//

import UIKit

extension UIView{
    func addTapGestureRecognizer(target: Any, selector: Selector){
        isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: target, action: selector)
        addGestureRecognizer(gestureRecognizer)
    }
}

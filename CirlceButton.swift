//
//  CirlceButton.swift
//  speechRec
//
//  Created by Fnu, Rohit on 9/4/16.
//  Copyright © 2016 Fnu, Rohit. All rights reserved.
//

import UIKit

@IBDesignable
class CirlceButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 30
    {
        didSet{
            setUpView()
        }
    }
    
    override func prepareForInterfaceBuilder()
    {
        setUpView()
    }
    
    func setUpView()
    {
        layer.cornerRadius = cornerRadius
    }
}

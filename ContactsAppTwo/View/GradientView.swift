//  GradientView.swift
//  ContactsAppTwo
//  Created by Eric Widjaja on 11/18/20.
//  Copyright © 2020 ericSwidjaja. All rights reserved.

import UIKit
//https://www.youtube.com/watch?v=1NhlrhQhK0A
//http://swiftquickstart.blogspot.com/2017/01/gradients.html

@IBDesignable

class GradientView: UIView {

    //MARK: - Properties
    @IBInspectable var firstColor: UIColor = UIColor.clear {
        didSet {
            updateView()
        }
    }
    @IBInspectable var secondColor: UIColor = UIColor.clear {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var thirdColor: UIColor = UIColor.clear {
        didSet {
            updateView()
        }
    }
    
    // default is layerClass, so we need to override it
    override class var layerClass: AnyClass {
        //only 'get' not a 'get set'
        get {
            return CAGradientLayer.self
        }
    }
    
    //MARK: - Methods
    
    func updateView() {
        // need to type cast it to CAGradientLayer
        let layer = self.layer as! CAGradientLayer
        layer.colors = [firstColor.cgColor, secondColor.cgColor, thirdColor.cgColor]
//        layer.locations = [0.1]
    }

}

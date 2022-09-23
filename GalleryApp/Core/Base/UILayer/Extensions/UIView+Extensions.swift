//  VIPCleanWorkingTemplate
//
//  Created by Umair Farid on 10/02/2021.
//  Copyright © 2021 Systems. All rights reserved.
//

import Foundation
import UIKit

enum AIEdge:Int {
    case
    Top,
    Left,
    Bottom,
    Right,
    Top_Left,
    Top_Right,
    Bottom_Left,
    Bottom_Right,
    All,
    None
}

extension UIView {
    

    @IBInspectable var topCornerRadius: CGFloat{
        get{
            return layer.cornerRadius
        }
        set{
            roundCorners([.topRight, .topLeft], radius: newValue)
        }
    }
    
    @IBInspectable var bottomCornerRadius: CGFloat{
        get{
            return layer.cornerRadius
        }
        set{
            roundCorners([.bottomRight, .bottomLeft], radius: newValue)
        }
    }
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        if #available(iOS 11.0, *) {
            clipsToBounds = true
            layer.cornerRadius = radius
            layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
        } else {
            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
    }
    
//    func roundCorners(top: Bool, cornerRadii: CGFloat){
//        let corners: UIRectCorner = top ? [.topLeft , .topRight] : [.bottomRight , .bottomLeft]
//        roundCorners(corners: corners, cornerRadii: cornerRadii)
//    }
//    
//    func roundAllCorners(cornerRadii: CGFloat) {
//        let corners: UIRectCorner = .allCorners
//        roundCorners(corners: corners, cornerRadii: cornerRadii)
//    }
    
    func show(animated: Bool) {
        let timeInterval: TimeInterval = animated ? 0.33 : 0
        UIView.animate(withDuration: timeInterval) {
            self.alpha = 1
        }
    }
    
    func hide(animated: Bool) {
        let timeInterval: TimeInterval = animated ? 0.33 : 0
        UIView.animate(withDuration: timeInterval) {
            self.alpha = 0
        }
    }
    
    func pinToSuperView() {
        NSLayoutConstraint.activate([
                self.topAnchor.constraint(equalTo: self.superview!.topAnchor),
                self.bottomAnchor.constraint(equalTo: self.superview!.bottomAnchor),
                self.leftAnchor.constraint(equalTo: self.superview!.leftAnchor),
                self.rightAnchor.constraint(equalTo: self.superview!.rightAnchor)
            ])
    }
    
    func pinToSuperView(inset: UIEdgeInsets) {
        let parent = self.superview!
        
        self.topAnchor.constraint(equalTo: parent.topAnchor, constant: inset.top).isActive = true
        self.bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: inset.bottom).isActive = true
        self.leftAnchor.constraint(equalTo: parent.leftAnchor, constant: inset.left).isActive = true
        self.rightAnchor.constraint(equalTo: parent.rightAnchor, constant: inset.right).isActive = true
    }
    
    //This method will add both corner radius and shadow to view
    func applyShadowWithCornerRadius(color:UIColor, opacity:Float, shadowRadius: CGFloat, edge:AIEdge, shadowSpace:CGFloat, cornerRadius: CGFloat)    {

        var sizeOffset:CGSize = CGSize.zero
        switch edge {
        case .Top:
            sizeOffset = CGSize(width: 0, height: -shadowSpace)
        case .Left:
            sizeOffset = CGSize(width: -shadowSpace, height: 0)
        case .Bottom:
            sizeOffset = CGSize(width: 0, height: shadowSpace)
        case .Right:
            sizeOffset = CGSize(width: shadowSpace, height: 0)


        case .Top_Left:
            sizeOffset = CGSize(width: -shadowSpace, height: -shadowSpace)
        case .Top_Right:
            sizeOffset = CGSize(width: shadowSpace, height: -shadowSpace)
        case .Bottom_Left:
            sizeOffset = CGSize(width: -shadowSpace, height: shadowSpace)
        case .Bottom_Right:
            sizeOffset = CGSize(width: shadowSpace, height: shadowSpace)


        case .All:
            sizeOffset = CGSize(width: 0, height: 0)
        case .None:
            sizeOffset = CGSize.zero
        }

        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true

        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = sizeOffset
        self.layer.shadowRadius = shadowRadius
        self.layer.masksToBounds = false

        self.layer.shadowPath = UIBezierPath(roundedRect:self.bounds, cornerRadius:self.layer.cornerRadius).cgPath
    }
    
    func addShadowView(color:UIColor, opacity:Float, shadowRadius: CGFloat, edge:AIEdge, shadowSpace:CGFloat) {
            //Remove previous shadow views
            superview?.viewWithTag(119900)?.removeFromSuperview()

            //Create frame on base of the AIEdge selection
            var shadowframe = CGRect.zero
            switch edge {
            case .Top, .Left, .Right, .Top_Left, .Top_Right, .Bottom_Left, .Bottom_Right, .All, .None:
                //Will be adjusted later on when time
                shadowframe = frame
            case .Bottom:
                shadowframe = CGRect.init(x: 0 , y: 0, width: frame.size.width, height: frame.size.height)
            }
    }
}

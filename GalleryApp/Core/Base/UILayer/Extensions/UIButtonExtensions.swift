import UIKit

extension UIButton {
    func roudedCoreners(_ color: UIColor) {
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 10.0
        self.layer.borderColor = color.cgColor
        self.clipsToBounds = true
    }
    
    func setSizeFont (sizeFont: Double) {
        self.titleLabel?.font =  UIFont(name: (self.titleLabel?.font.fontName)!, size: CGFloat(sizeFont))! //"Graphik-Medium"
        self.sizeToFit()
    }
    
    func setShadow(_ color: CGColor) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 4.0
        self.layer.shadowOffset = CGSize(width: 0, height: 4.0)
    }

    //For changing font to urdu
    
    @IBInspectable
    var urduCheck: Bool {
        set {
            if(newValue) {
                /*if(CoreLanguageManger.shared.isRightToLeft) {
                    //Checking if font assigned is regular or not
                    if self.titleLabel?.font.fontName.range(of:"-Regular") != nil {
                        self.titleLabel?.font = UIFont.notoNaskhArabic(ofSize: self.titleLabel?.font.pointSize ?? 12.0, weight: .regular)
                    }else{
                        self.titleLabel?.font = UIFont.notoNaskhArabic(ofSize: self.titleLabel?.font.pointSize ?? 12.0, weight: .bold)
                    }
                }*/
            }
        }
        get {
            return self.urduCheck
        }
    }
    
    var substituteFont: UIFont {
        get { return (self.titleLabel?.font)! }
        set {
            /*if(CoreLanguageManger.shared.isRightToLeft) {
                //Checking if font assigned is regular or not
                if newValue.fontName.range(of:"-Regular") != nil {
                    self.titleLabel?.font = UIFont.notoNaskhArabic(ofSize: self.titleLabel?.font.pointSize ?? 12.0, weight: .regular)
                }else{
                    self.titleLabel?.font = UIFont.notoNaskhArabic(ofSize: self.titleLabel?.font.pointSize ?? 12.0, weight: .bold)
                }
            }else{
                self.titleLabel?.font = newValue
            }*/
        }
    }
    
}

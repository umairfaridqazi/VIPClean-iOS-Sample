import UIKit

extension UIColor {
    static var lightGrayJazz: UIColor {
        return UIColor(red: 243/255.0, green: 243/255.0, blue: 243/255.0, alpha: 1)
    }
    
    static var redJazz: UIColor {
        return UIColor(red: 164/255.0, green: 2/255.0, blue: 0/255.0, alpha: 1)
    }
    
    static var onboardingJazz: UIColor {
        return UIColor(red: 111/255.0, green: 1/255.0, blue: 1/255.0, alpha: 1)
    }
    
    static var goldJazz: UIColor {
        return UIColor(hex: "#FFC20C")
    }
    
    static var grayJazz: UIColor {
        return UIColor(red: 76/255.0, green: 76/255.0, blue: 76/255.0, alpha: 1)
    }
    
    static var headerJazz: UIColor {
        return UIColor(hex: "#262626")
    }
    
    convenience init(hexString:String, alpha:CGFloat = 1.0) {
           var cString:String = hexString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
           var rgbValue:UInt32 = 10066329 //color #999999 if string has wrong format
           
           if (cString.hasPrefix("#")) {
               cString.remove(at: cString.startIndex)
           }
           
           if ((cString.count) == 6) {
               Scanner(string: cString).scanHexInt32(&rgbValue)
           }
           
           self.init(
               red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
               green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
               blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
               alpha: alpha
           )
       }
}

import UIKit

class Theme {
    
    struct Colors {
        static let themeWhite = UIColor(hex: "#FFFFFF")!
        static let themeOrange = UIColor(hex: "#FF7B1B")!
        static let themeBlack = UIColor(hex: "#000000")!
        static let themeGray = UIColor(hex: "#CECECE")!
        static let themeDarkGray = UIColor(hex: "#535353")!
        static let themeLightGray = UIColor(hex: "#F8F8F8")!
        static let themeShadow = UIColor(hex: "#9AAACF")!
    }
    
    struct Fonts {
        
        enum FontMode: String {
            case bold = "Bold"
            case regular = "Regular"
            case italic = "Italic"
            case semibold = "Semibold"
        }
        
        private static let titleFontName = "Monsterrat"
        
        static func themeTitleFont(size: CGFloat = 16, mode: FontMode = .regular) -> UIFont {
            UIFont(name: titleFontName + "-" + mode.rawValue, size: size)!
        }
    }
}

import Foundation

enum StepperSize {
    case small
    case medium
    case large
    
    var buttonSize: CGFloat {
        switch self {
        case .small:
            return 24
        case .medium:
            return 30
        case .large:
            return 40
        }
    }
    
    var labelSize: CGFloat {
        switch self {
        case .small:
            return buttonSize
        case .medium:
            return 20
        case .large:
            return 30
        }
    }
    
    var fontSize: CGFloat {
        switch self {
        case .small:
            return 12
        case .medium:
            return 16
        case .large:
            return 20
        }
    }
}

import Foundation

struct RegistrationSuccessModel: Model {
    let image: String
    let title: String
    let description: String
    let buttonTitle: String
    
    init(image: String,
         title: String,
         description: String,
         buttonTitle: String) {
        
        self.image = image
        self.title = title
        self.description = description
        self.buttonTitle = buttonTitle
    }
}

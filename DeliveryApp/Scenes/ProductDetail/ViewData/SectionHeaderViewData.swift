import Foundation

struct SectionHeaderViewData {
    let name: String
    let isRequired: Bool
    let limitOptions: Int
    
    init(name: String, limitOptions: Int, isRequired: Bool) {
        self.name = name
        self.limitOptions = limitOptions
        self.isRequired = isRequired
    }
    
    var requiredText: String {
        return "OBRIGATÓRIO"
    }
  
    var sectionOptionsLimit: String {
        "Escolha até \(limitOptions) opções."
    }
}

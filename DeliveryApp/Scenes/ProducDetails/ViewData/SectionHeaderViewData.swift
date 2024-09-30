import Foundation

class SectionHeaderViewData {
    private let section: Section
    
    init(section: Section) {
        self.section = section
    }
    
    var name: String {
        section.name
    }
    
    var limitOptions: String {
        "Escolha até \(section.limitOptions) opções."
    }
}

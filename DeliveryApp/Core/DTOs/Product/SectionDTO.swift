import Foundation

struct SectionDTO: Codable {
    let name: String
    let isActive: Bool
    let isRequired: Bool
    let isSideItem: Bool
    let isRemovable: Bool
    let limitOptions: Int
    let selectionOrder: Int
    var items: [ItemDTO]
}

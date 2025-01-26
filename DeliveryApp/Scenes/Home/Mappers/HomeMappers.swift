import Foundation

extension CategoryResponse {
    func toCategoryCellViewData() -> CategoryCellViewData {
        return CategoryCellViewData(
            id: self.id,
            name: self.name,
            image: self.image
        )
    }
}

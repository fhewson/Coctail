import UIKit

class FilterPresenter: ViewToPresenterFilterProtocol {
    
    var view: PresenterToViewFilterProtocol?
    var interactor: PresenterToInteractorFilterProtocol?
    var router: PresenterToRouterFilterProtocol?
    
    var categoryList: [Categories.Category] = []
    var selectedCategories: [Categories.Category] = []
    var newSelectedCategories: [Categories.Category] = []
    
    func categorySelectionDidUpdate(row: Int, selected: Bool) {
        let category = categoryList[row]
        newSelectedCategories.removeAll(where: { $0.strCategory == category.strCategory })
        if selected {
            newSelectedCategories.append(category)
        }
        
        let newSelected = newSelectedCategories.sorted(by: { $0.strCategory < $1.strCategory })
        let initialSelected = selectedCategories.sorted(by: { $0.strCategory < $1.strCategory })
        let applyButtonEnabled = (newSelectedCategories.count > 0) ? (newSelected != initialSelected) : false
        view?.updateApplyButton(enabled: applyButtonEnabled)
    }
    
    func applyFilter(from: UIViewController) {
        router?.applyFilter(from: from, selectedCategories: newSelectedCategories)
    }
}

extension FilterPresenter: InteractorToPresenterFilterProtocol {
    
}

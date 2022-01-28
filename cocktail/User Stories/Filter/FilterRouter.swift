import Foundation
import UIKit

class FilterRouter: PresenterToRouterFilterProtocol {
    
    var filterPassDelegate: FilterPassDelegate?
    
    class func createFilterModule(categoryList: [Categories.Category],
                                  selectedCategories: [Categories.Category] = [],
                                  filterPassDelegate: FilterPassDelegate) -> FilterViewController {
        
        let filterViewController = FilterViewController()
        let presenter: ViewToPresenterFilterProtocol & InteractorToPresenterFilterProtocol = FilterPresenter()
        
        filterViewController.presenter = presenter
        filterViewController.presenter?.router = FilterRouter()
        filterViewController.presenter?.router?.filterPassDelegate = filterPassDelegate
        filterViewController.presenter?.view = filterViewController
        filterViewController.presenter?.categoryList = categoryList
        filterViewController.presenter?.selectedCategories = selectedCategories
        filterViewController.presenter?.newSelectedCategories = selectedCategories
        filterViewController.presenter?.interactor = FilterInteractor()
        filterViewController.presenter?.interactor?.presenter = presenter
        
        return filterViewController
    }
    
    func applyFilter(from: UIViewController, selectedCategories: [Categories.Category]) {
        from.navigationController?.popViewController(animated: true)
        filterPassDelegate?.applyFilter(selectedCategories: selectedCategories)
    }
}

import Foundation
import UIKit

class ListRouter: PresenterToRouterListProtocol {
    
    class func createListModule() -> ListViewController {
        
        let listViewController = ListViewController()
        let presenter: ViewToPresenterListProtocol & InteractorToPresenterListProtocol = ListPresenter()
        
        listViewController.presenter = presenter
        listViewController.presenter?.router = ListRouter()
        listViewController.presenter?.view = listViewController
        listViewController.presenter?.interactor = ListInteractor()
        listViewController.presenter?.interactor?.presenter = presenter
        
        return listViewController
    }
    
    func loadFilterViewController(from: UIViewController,
                                  categoryList: [Categories.Category],
                                  selectedCategories: [Categories.Category],
                                  filterPassDelegate: FilterPassDelegate) {
        
        let filterViewController = FilterRouter.createFilterModule(categoryList: categoryList,
                                                                   selectedCategories: selectedCategories,
                                                                   filterPassDelegate: filterPassDelegate)
        from.navigationController?.pushViewController(filterViewController, animated: true)
        
    }
}

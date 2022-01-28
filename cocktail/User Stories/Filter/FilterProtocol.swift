import RxSwift

protocol FilterPassDelegate {
    func applyFilter(selectedCategories: [Categories.Category])
}

protocol ViewToPresenterFilterProtocol {
    
    var view: PresenterToViewFilterProtocol? { get set }
    var interactor: PresenterToInteractorFilterProtocol? { get set }
    var router: PresenterToRouterFilterProtocol? { get set }
    
    var categoryList: [Categories.Category] { get set }
    var selectedCategories: [Categories.Category] { get set }
    var newSelectedCategories: [Categories.Category] { get set }
    
    func categorySelectionDidUpdate(row: Int, selected: Bool)
    func applyFilter(from: UIViewController)
}

protocol PresenterToViewFilterProtocol  {
    
    func updateApplyButton(enabled: Bool)
    
}

protocol PresenterToRouterFilterProtocol  {
    
    var filterPassDelegate: FilterPassDelegate? { get set }
    
    static func createFilterModule(categoryList: [Categories.Category],
                                   selectedCategories: [Categories.Category],
                                   filterPassDelegate: FilterPassDelegate) -> FilterViewController
    
    func applyFilter(from: UIViewController, selectedCategories: [Categories.Category])
    
}

protocol PresenterToInteractorFilterProtocol {
    
    var presenter: InteractorToPresenterFilterProtocol? { get set }
    
}

protocol InteractorToPresenterFilterProtocol {
    
}

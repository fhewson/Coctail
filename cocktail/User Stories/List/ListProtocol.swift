import RxSwift

protocol ViewToPresenterListProtocol {
    
    var view: PresenterToViewListProtocol? { get set }
    var interactor: PresenterToInteractorListProtocol? { get set }
    var router: PresenterToRouterListProtocol? { get set }
    
    var categoryList: [Categories.Category] { get set }
    var selectedCategories: [Categories.Category] { get set }
    var drinksList: [String: [Drinks.Drink]] { get set }
    
    func fetchCategories()
    func fetchDrinks(category: String)
    
    func loadFilterViewControler(from: UIViewController)
}

protocol PresenterToViewListProtocol  {
    
    func onDrinksResponseSuccess()
    func onDrinksResponseFailed(error: String)
    func onCategoriesResponseFailed(error: String)
}

protocol PresenterToRouterListProtocol  {
    
    static func createListModule() -> ListViewController
    func loadFilterViewController(from: UIViewController,
                                  categoryList: [Categories.Category],
                                  selectedCategories: [Categories.Category],
                                  filterPassDelegate: FilterPassDelegate)
}

protocol PresenterToInteractorListProtocol: CocktailRepository  {
    
    var presenter: InteractorToPresenterListProtocol? { get set }
    
    func loadCategories()
    func loadDrinks(category: String)
}

protocol InteractorToPresenterListProtocol {
    
    func loadCategoriesSuccess(categoryList: [Categories.Category])
    func loadCategoriesFailed(error: String)
    
    func loadDrinksSuccess(categoryName: String, drinksList: [Drinks.Drink])
    func loadDrinksFailed(error: String)
}

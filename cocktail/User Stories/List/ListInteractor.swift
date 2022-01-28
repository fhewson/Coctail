import RxSwift

class ListInteractor: PresenterToInteractorListProtocol {
    
    var presenter: InteractorToPresenterListProtocol?
    
    func loadCategories() {
        _ = fetchCategories().subscribe { event in
            switch event {
            case .success(let categories):
                self.presenter?.loadCategoriesSuccess(categoryList: categories.drinks)
            case .failure(let error):
                self.presenter?.loadCategoriesFailed(error: error.localizedDescription)
            }
        }
    }
    
    func loadDrinks(category: String) {
        _ = fetchDrinks(category: category).subscribe { event in
            switch event {
            case .success(let drinks):
                self.presenter?.loadDrinksSuccess(categoryName: category.replacingOccurrences(of: "_", with: " "), drinksList: drinks.drinks)
            case .failure(let error):
                self.presenter?.loadDrinksFailed(error: error.localizedDescription)
            }
        }
    }
}

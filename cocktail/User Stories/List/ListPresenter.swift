import Foundation
import UIKit

class ListPresenter: ViewToPresenterListProtocol {
    
    var view: PresenterToViewListProtocol?
    var interactor: PresenterToInteractorListProtocol?
    var router: PresenterToRouterListProtocol?
    
    var categoryList: [Categories.Category] = []
    var selectedCategories: [Categories.Category] = []
    var drinksList: [String: [Drinks.Drink]] = [:]
    
    func fetchCategories() {
        interactor?.loadCategories()
    }
    
    func fetchDrinks(category: String) {
        interactor?.loadDrinks(category: category.replacingOccurrences(of: " ", with: "_"))
    }
    
    func loadFilterViewControler(from: UIViewController) {
        router?.loadFilterViewController(from: from,
                                         categoryList: categoryList,
                                         selectedCategories: selectedCategories,
                                         filterPassDelegate: self)
    }
}

extension ListPresenter: InteractorToPresenterListProtocol {
    
    func loadCategoriesSuccess(categoryList: [Categories.Category]) {
        self.categoryList = categoryList
        selectedCategories = categoryList
        if let firstCategory = selectedCategories.first {
            fetchDrinks(category: firstCategory.strCategory)
        }
    }
    
    func loadCategoriesFailed(error: String) {
        view?.onCategoriesResponseFailed(error: error)
    }
    
    func loadDrinksSuccess(categoryName: String, drinksList: [Drinks.Drink]) {
        self.drinksList[categoryName] = drinksList
        view?.onDrinksResponseSuccess()
    }
    
    func loadDrinksFailed(error: String) {
        view?.onDrinksResponseFailed(error: error)
    }
}

extension ListPresenter: FilterPassDelegate {
    func applyFilter(selectedCategories: [Categories.Category]) {
        self.selectedCategories = selectedCategories
        drinksList.removeAll()
        if let firstCategory = selectedCategories.first {
            fetchDrinks(category: firstCategory.strCategory)
        }
    }
}

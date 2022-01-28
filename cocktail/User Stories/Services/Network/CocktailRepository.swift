import Moya
import RxSwift

// MARK: - Repository

fileprivate let provider: MoyaProvider<CocktailService> = MoyaProvider<CocktailService>(plugins: [NetworkLoggerPlugin()])

protocol CocktailRepository {
    func fetchCategories() -> Single<Categories>
    func fetchDrinks(category: String) -> Single<Drinks>
}

extension CocktailRepository {
    func fetchCategories() -> Single<Categories> {
        return provider.rx
            .request(.getCategories)
            .filterSuccessfulStatusAndRedirectCodes()
            .map(Categories.self)
    }
    
    func fetchDrinks(category: String) -> Single<Drinks>{
        return provider.rx
            .request(.getCocktails(category: category))
            .filterSuccessfulStatusAndRedirectCodes()
            .map(Drinks.self)
    }
}

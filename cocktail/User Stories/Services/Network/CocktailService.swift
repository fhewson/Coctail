import Moya

// MARK: - Structs

struct Categories: Codable {
    
    var drinks: [Category]
    
    struct Category: Codable {
        var strCategory: String
    }
}

extension Categories.Category: Equatable {
    static func ==(lhs: Categories.Category, rhs: Categories.Category) -> Bool {
        return lhs.strCategory == rhs.strCategory
    }
}

struct Drinks: Codable {
    
    var drinks: [Drink]
    
    struct Drink: Codable {
        var strDrink: String
        var strDrinkThumb: String
    }
}

// MARK: - Service

enum CocktailService {
    case getCategories
    case getCocktails(category: String)
}

extension CocktailService: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://www.thecocktaildb.com/api/json/v1/1")!
    }
    
    var path: String {
        switch self {
        case .getCategories:
            return "/list.php"
        case .getCocktails(_):
            return "/filter.php"
        }
    }
    
    
    var method: Method {
        switch self {
        case .getCategories, .getCocktails(_):
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getCategories:
            return .requestParameters(parameters: ["c":"list"], encoding: URLEncoding.default)
        case .getCocktails(let category):
            return .requestParameters(parameters: ["c":category], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
    
    var sampleData: Data {
        return Data()
    }
    
}

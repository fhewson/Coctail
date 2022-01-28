import UIKit
import MBProgressHUD
import RxSwift
import SDWebImage
import SnapKit

class ListViewController: UIViewController {
    
    // MARK: - Properties
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    lazy var barButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(image: R.image.filterDefault(), style: .plain,
                               target: self, action: #selector(filterDidTapped))
    }()
    
    var presenter: ViewToPresenterListProtocol!
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        showHud(hudType: .loading)
        presenter.fetchCategories()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let filtersApplied = (presenter.selectedCategories.count != presenter.categoryList.count)
        barButtonItem.image = filtersApplied ? R.image.filterSelected() : R.image.filterDefault()
    }
}

// MARK: - UI Setup

extension ListViewController {
    
    private func setupUI() {
        
        title = "Drinks"
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = barButtonItem
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) -> Void in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc func filterDidTapped(){
        presenter.loadFilterViewControler(from: self)
    }
}

// MARK: - PresenterToViewListProtocol

extension ListViewController: PresenterToViewListProtocol {
    
    func onCategoriesResponseFailed(error: String) {
        showHud(hudType: .error(value: error))
    }
    
    func onDrinksResponseSuccess() {
        tableView.reloadData()
        hideHud()
    }
    
    func onDrinksResponseFailed(error: String) {
        showHud(hudType: .error(value: error))
    }
    
}

// MARK: - UITableView DataSource & Delegate

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.selectedCategories.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return presenter.selectedCategories[section].strCategory
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let category = presenter.selectedCategories[section]
        if let drinkList = presenter.drinksList[category.strCategory] {
            return drinkList.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListTableViewCell
        let category = presenter.selectedCategories[indexPath.section].strCategory
        cell.setup(drink: presenter.drinksList[category]![indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let section = indexPath.section
        let category = presenter.selectedCategories[section].strCategory
        let drinksCount = presenter.drinksList[category]?.count ?? 0
        
        guard section < presenter.selectedCategories.count - 1 else { return }
        let nextCategory = presenter.selectedCategories[section + 1].strCategory
        if drinksCount/2 < indexPath.row && presenter.drinksList[nextCategory] == nil {
            presenter?.fetchDrinks(category: nextCategory)
        }
    }
}

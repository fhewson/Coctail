import UIKit

class FilterViewController: UIViewController {
    
    // MARK: - Properties
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(FilterTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.contentInset = .init(top: 0, left: 0, bottom: 66, right: 0)
        return tableView
    }()
    
    lazy var applyButton: CustomButton = {
        let button = CustomButton()
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.setTitle("Apply Filter", for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(applyDidTapped), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    var presenter: ViewToPresenterFilterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

// MARK: - UI Setup

extension FilterViewController {
    private func setupUI() {
        
        title = "Filters"
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) -> Void in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        view.addSubview(applyButton)
        applyButton.snp.makeConstraints { (make) -> Void in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(view.snp.bottomMargin).inset(16)
            make.height.equalTo(50)
        }
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc func applyDidTapped(){
        presenter.applyFilter(from: self)
    }
}

// MARK: - PresenterToViewFilterProtocol

extension FilterViewController: PresenterToViewFilterProtocol {
    func updateApplyButton(enabled: Bool) {
        applyButton.isEnabled = enabled
    }
}

// MARK: - UITableView DataSource & Delegate

extension FilterViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.categoryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FilterTableViewCell
        let category = presenter.categoryList[indexPath.row]
        let isSelected = presenter.selectedCategories.contains(where: { $0.strCategory == category.strCategory })
        cell.setup(category: category)
        cell.updateSelection(selected: isSelected)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! FilterTableViewCell
        cell.updateSelection(selected: !cell.isTicked)
        presenter.categorySelectionDidUpdate(row: indexPath.row, selected: cell.isTicked)
    }
}

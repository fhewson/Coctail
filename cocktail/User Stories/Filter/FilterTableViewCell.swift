import UIKit

class FilterTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return titleLabel
    }()
    
    var isTicked: Bool {
        return iconImageView.image != nil
    }
    
    // MARK: - Lifecycle Methods
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        addSubview(iconImageView)
        iconImageView.snp.makeConstraints { make in
            make.height.equalTo(15)
            make.width.equalTo(15)
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(iconImageView.snp.leading).inset(10)
            make.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    
    func setup(category: Categories.Category){
        titleLabel.text = category.strCategory
    }
    
    func updateSelection(selected: Bool){
        iconImageView.image = (selected) ? UIImage(systemName: "checkmark") : nil
    }
}

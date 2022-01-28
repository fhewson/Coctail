import UIKit
import SnapKit
import SDWebImage

class ListTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    lazy var pictureView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return titleLabel
    }()
    
    // MARK: - Lifecycle Methods
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(pictureView)
        pictureView.snp.makeConstraints { make in
            make.height.equalTo(52)
            make.width.equalTo(52)
            make.leading.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(11)
            make.bottom.equalToSuperview().inset(11)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(pictureView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalTo(pictureView.snp.centerY)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    
    func setup(drink: Drinks.Drink){
        pictureView.sd_setImage(with: .init(string: drink.strDrinkThumb), placeholderImage: R.image.listCellPlaceholder(), options: .continueInBackground)
        titleLabel.text = drink.strDrink
    }
}


import UIKit
import Kingfisher
import UIColor_Hex_Swift
class ChatTableViewCell: UITableViewCell {
    
    
    private let avatarImageView = UIImageView()
    private let headerLabel = UILabel()
    private let bodyContainerView = UIView()
    private let bodyLabel = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        contentView.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1)
        // Order matters since views will be constrainted to one another.
        layoutAvatarImageView()
        layoutHeaderLabel()
        layoutBodyContainerView()
        layoutBodyLabel()
    }
    
    private func layoutAvatarImageView() {
        contentView.addSubview(avatarImageView)
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        
        avatarImageView.leadingAnchor.constraint(
            equalTo: contentView.leadingAnchor,
            constant: 16
        ).isActive = true
        
        avatarImageView.topAnchor.constraint(
            equalTo: contentView.topAnchor,
            constant: 16
        ).isActive = true
        
        let size: CGFloat = 44
        
        avatarImageView.heightAnchor.constraint(equalToConstant: size).isActive = true
        avatarImageView.widthAnchor.constraint(equalToConstant: size).isActive = true
        
        avatarImageView.layer.cornerRadius = size / 2
        avatarImageView.clipsToBounds = true
    }
    
    private func layoutHeaderLabel() {
        contentView.addSubview(headerLabel)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        headerLabel.topAnchor.constraint(
            equalTo: avatarImageView.topAnchor,
            constant: 4
        ).isActive = true
        headerLabel.leadingAnchor.constraint(
            equalTo: avatarImageView.trailingAnchor,
            constant: 7
        ).isActive = true
        
        headerLabel.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor,
            constant: -16
        ).isActive = true
        
        headerLabel.numberOfLines = 2
        
        headerLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        headerLabel.textColor = UIColor("#1B1E1F")
    }
    
    private func layoutBodyContainerView() {
        contentView.addSubview(bodyContainerView)
        bodyContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        bodyContainerView.leadingAnchor.constraint(equalTo: headerLabel.leadingAnchor).isActive = true
        bodyContainerView.topAnchor.constraint(
            equalTo: headerLabel.bottomAnchor,
            constant: 4
        ).isActive = true
        
        bodyContainerView.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor,
            constant: -36
        ).isActive = true
        
        bodyContainerView.bottomAnchor.constraint(
            equalTo: contentView.bottomAnchor,
            constant: -4
        ).isActive = true
        
        bodyContainerView.backgroundColor = .white
        bodyContainerView.layer.cornerRadius = 8
        bodyContainerView.layer.borderWidth = 1
        
        bodyContainerView.layer.borderColor = UIColor("#EFEFEF").cgColor
    }
    
    private func layoutBodyLabel() {
        bodyContainerView.addSubview(bodyLabel)
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        bodyLabel.leadingAnchor.constraint(
            equalTo: bodyContainerView.leadingAnchor,
            constant: 8
        ).isActive = true
        
        bodyLabel.trailingAnchor.constraint(
            equalTo: bodyContainerView.trailingAnchor,
            constant: -8
        ).isActive = true
        
        bodyLabel.topAnchor.constraint(
            equalTo: bodyContainerView.topAnchor,
            constant: 8
        ).isActive = true
        
        bodyLabel.bottomAnchor.constraint(
            equalTo: bodyContainerView.bottomAnchor,
            constant: -8
        ).isActive = true
        
        bodyLabel.numberOfLines = 0
        bodyLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        bodyLabel.textColor = UIColor("#1B1E1F")
    }
    
    func setCellData(message: Message) {
        headerLabel.text = message.username
        bodyLabel.text = message.text
        
        if let url = message.avatarURL {
            avatarImageView.kf.setImage(with: url)
        }
    }
}

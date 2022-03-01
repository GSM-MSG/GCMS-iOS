import UIKit
import SnapKit

final class GoogleSigninButton: UIButton {
    // MARK: - Properties
    let iv = UIImageView().then {
        $0.image = GCMSAsset.Images.gcmsGoogleLogo.image.withRenderingMode(.alwaysOriginal)
    }
    
    // MARK: - Init
    init(title: String) {
        super.init(frame: .zero)
        addSubViews(iv)
        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont(font: GCMSFontFamily.Inter.medium, size: 14)
        
        
        layer.cornerRadius = 9
        backgroundColor = GCMSAsset.Colors.gcmsMainColor.color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        iv.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.size.equalTo(23)
        }
    }
}

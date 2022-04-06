import UIKit
import SnapKit
import Service

final class ClubTypeCardButton: UIButton {
    // MARK: - Properties
    
    // MARK: - Init
    init(type: ClubType) {
        super.init(frame: .zero)
        switch type {
        case .major:
            setImage(GCMSAsset.Images.gcmsMajor.image, for: .normal)
        case .freedom:
            setImage(GCMSAsset.Images.gcmsFreedom.image, for: .normal)
        case .editorial:
            setImage(GCMSAsset.Images.gcmsEditorial.image, for: .normal)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

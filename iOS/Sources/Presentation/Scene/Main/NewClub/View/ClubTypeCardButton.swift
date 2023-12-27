import UIKit
import SnapKit
import Service

final class ClubTypeCardButton: UIButton {
    // MARK: - Properties
    private let type: ClubType
    // MARK: - Init
    init(type: ClubType, isGray: Bool = false) {
        self.type = type
        super.init(frame: .zero)
        switch type {
        case .major:
            setImage(isGray ? GCMSAsset.Images.gcmsMajorGray.image : GCMSAsset.Images.gcmsMajor.image, for: .normal)
        case .freedom:
            setImage(isGray ? GCMSAsset.Images.gcmsFreedomGray.image : GCMSAsset.Images.gcmsFreedom.image, for: .normal)
        case .editorial:
            setImage(isGray ? GCMSAsset.Images.gcmsEditorialGray.image : GCMSAsset.Images.gcmsEditorial.image, for: .normal)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setImageState(isGray: Bool) {
        switch type {
        case .major:
            setImage(isGray ? GCMSAsset.Images.gcmsMajorGray.image : GCMSAsset.Images.gcmsMajor.image, for: .normal)
        case .freedom:
            setImage(isGray ? GCMSAsset.Images.gcmsFreedomGray.image : GCMSAsset.Images.gcmsFreedom.image, for: .normal)
        case .editorial:
            setImage(isGray ? GCMSAsset.Images.gcmsEditorialGray.image : GCMSAsset.Images.gcmsEditorial.image, for: .normal)
        }
    }
}

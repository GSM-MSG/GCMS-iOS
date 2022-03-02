import UIKit

final class HeaderLabel: UILabel {
    init(title: String){
        super.init(frame: .zero)
        self.text = title
        self.textColor = GCMSAsset.Colors.gcmsGray1.color
        self.font = UIFont(font: GCMSFontFamily.Inter.semiBold, size: 16)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

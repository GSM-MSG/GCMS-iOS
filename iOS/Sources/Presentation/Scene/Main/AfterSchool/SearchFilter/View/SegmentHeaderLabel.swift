import UIKit

final class SegmentHeaderLabel: UILabel {
    init(title: String) {
        super.init(frame: .zero)
        self.text = title
        self.font = .systemFont(ofSize: 18, weight: .semibold)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

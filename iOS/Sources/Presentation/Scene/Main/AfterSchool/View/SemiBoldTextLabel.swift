import UIKit

final class SemiBoldTextLabel: UILabel {
    init(title: String, weight: UIFont.Weight) {
        super.init(frame: .zero)
        self.text = title
        self.font = .systemFont(ofSize: 13, weight: weight)
        self.textColor = .black
        self.textAlignment = .center
        self.numberOfLines = 0
        self.clipsToBounds = true
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

import UIKit
import SnapKit

protocol ClubTypeSegmentedControlDelegate: AnyObject {
    func segmentValueChanged(to index: Int)
}

final class ClubTypeSegmentedControl: UIView {
    weak var delegate: ClubTypeSegmentedControlDelegate?
    private var titles: [String] = []
    private var buttons: [UIButton] = []
    
    var unselectedTextColor: UIColor = .gray
    var selectedTextColor: UIColor = .white
    var unselectedBackgroundColor: UIColor = .clear
    var selectedBackgroundColor: UIColor = GCMSAsset.Colors.gcmsMainColor.color
    var selectedIndex: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(
        titles: [String]
    ) {
        self.titles = titles
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        updateView()
    }
    
}

fileprivate extension ClubTypeSegmentedControl {
    func updateView() {
        setButtons()
        configStack()
    }
    func setButtons() {
        self.buttons = []
        self.subviews.forEach{ $0.removeFromSuperview() }
        titles.forEach { title in
            let button = UIButton()
            button.setTitle(title, for: .normal)
            button.setTitleColor(.gray, for: .normal) // TODO: Color asset pull
            button.titleLabel?.font = UIFont(font: GCMSFontFamily.Inter.medium, size: 11)
            button.backgroundColor = .clear
            button.layer.cornerRadius = 11.5
            button.layer.masksToBounds = true
            self.buttons.append(button)
        }
    }
    func configStack() {
        let stack = UIStackView(arrangedSubviews: buttons)
        stack.axis = .horizontal
        stack.spacing = 33
        stack.alignment = .center
        stack.distribution = .fillEqually
        self.addSubViews(stack)
        stack.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    @objc func buttonDidTap(_ sender: UIButton) {
        buttons.enumerated().forEach { index, button in
            button.backgroundColor = .clear
            button.titleLabel?.font = UIFont(font: GCMSFontFamily.Inter.medium, size: 11)
            button.setTitleColor(.gray, for: .normal)
            if button == sender {
                button.backgroundColor = GCMSAsset.Colors.gcmsMainColor.color
                button.titleLabel?.font = UIFont(font: GCMSFontFamily.Inter.semiBold, size: 11)
                button.setTitleColor(.white, for: .normal)
                self.selectedIndex = index
                self.delegate?.segmentValueChanged(to: index)
            }
        }
    }
}

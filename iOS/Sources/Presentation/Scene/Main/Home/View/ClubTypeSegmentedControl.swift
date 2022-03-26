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
        self.init(frame: .zero)
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
            button.setTitleColor(GCMSAsset.Colors.gcmsGray3.color, for: .normal)
            button.titleLabel?.font = UIFont(font: GCMSFontFamily.Inter.medium, size: 14)
            button.backgroundColor = .clear
            button.layer.cornerRadius = 11.5
            button.layer.masksToBounds = true
            button.addTarget(self, action: #selector(buttonDidTap(_:)), for: .touchUpInside)
            self.buttons.append(button)
        }
        buttons[0].setTitleColor(.init(red: 0, green: 0.65, blue: 1, alpha: 0.99), for: .normal)
        buttons[0].setUnderline()
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
            button.setTitleColor(GCMSAsset.Colors.gcmsGray3.color, for: .normal)
            button.clearUnderline()
            if button == sender {
                button.setTitleColor(.init(red: 0, green: 0.65, blue: 1, alpha: 0.99), for: .normal)
                button.setUnderline()
                self.selectedIndex = index
                self.delegate?.segmentValueChanged(to: index)
            }
        }
    }
}


extension UIButton {
    func setUnderline() {
        guard let title = title(for: .normal) else { return }
        let attributedString = NSMutableAttributedString(string: title)
        attributedString.addAttribute(.underlineStyle,
                                      value: NSUnderlineStyle.single.rawValue,
                                      range: NSRange(location: 0, length: title.count)
        )
        setAttributedTitle(attributedString, for: .normal)
    }
    func clearUnderline() {
        guard let title = title(for: .normal) else { return }
        let attributedString = NSMutableAttributedString(string: title)
        setAttributedTitle(attributedString, for: .normal)
    }
}

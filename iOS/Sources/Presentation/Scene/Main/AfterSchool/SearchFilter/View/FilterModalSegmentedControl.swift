import UIKit

protocol FilterModalSegmentedControlDelegate: AnyObject {
    func segmentValueChanged(to index: Int, sender: FilterModalSegmentedControl)
}

final class FilterModalSegmentedControl: UIView {
    weak var delegate: FilterModalSegmentedControlDelegate?
    private var titles: [String] = []
    private var buttons: [UIButton] = []
    
    var unselectedTextColor: UIColor = GCMSAsset.Colors.gcmsGray1.color
    var selectedTextColor: UIColor = GCMSAsset.Colors.gcmsGray1.color
    var unselectedBackgroundColor: UIColor = .clear
    var selectedBackgroundColor: UIColor = GCMSAsset.Colors.gcmsMainColor.color
    var borderColor: UIColor = .white
    var selectedIndex: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init (
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
    
    fileprivate func updateView() {
        setButtons()
        configStack()
    }
    
    fileprivate func setButtons() {
        self.buttons = []
        self.subviews.forEach { $0.removeFromSuperview() }
        titles.forEach {
            let button = UIButton()
            button.setTitle($0, for: .normal)
            button.setTitleColor(unselectedTextColor, for: .normal)
            button.backgroundColor = unselectedBackgroundColor
            button.layer.borderWidth = 1
            button.layer.borderColor = borderColor.cgColor
            button.layer.cornerRadius = 6
            button.layer.masksToBounds = true
            button.addTarget(self, action: #selector(buttonDidTapped(_:)), for: .touchUpInside)
            if #available(iOS 15.0, *) {
                button.configuration = .filled()
                button.configuration?.contentInsets = .init(top: 10, leading: 0, bottom: 10, trailing: 0)
//                button.configuration?.
                button.configuration?.baseBackgroundColor = unselectedBackgroundColor
            } else {
                button.contentEdgeInsets = .init(top: 10, left: 0, bottom: 10, right: 0)
            }
            self.buttons.append(button)
        }
        initialState()
    }
    fileprivate func initialState() {
        let index = selectedIndex
        if #available(iOS 15.0, *) {
            buttons[index].configuration?.baseBackgroundColor = selectedBackgroundColor
            buttons[index].configuration?.baseForegroundColor = selectedTextColor
        } else {
            buttons[index].setBackgroundColor(selectedBackgroundColor, for: .normal)
        }
        buttons[index].setTitleColor(selectedTextColor, for: .normal)
        buttons[index].layer.borderColor = UIColor.clear.cgColor
    }
    fileprivate func configStack() {
           let stack = UIStackView(arrangedSubviews: buttons)
           stack.axis = .horizontal
           stack.alignment = .center
           stack.distribution = .fillEqually
           stack.spacing = 10
           self.addSubview(stack)
           stack.translatesAutoresizingMaskIntoConstraints = false
           stack.snp.makeConstraints {
               $0.edges.equalToSuperview()
           }
       }
    @objc private func buttonDidTapped(_ sender: UIButton) {
        buttons.enumerated().forEach{ index, button in
            if #available(iOS 15.0, *) {
                button.configuration?.baseBackgroundColor = unselectedBackgroundColor
                button.configuration?.baseForegroundColor = unselectedTextColor
            } else {
                button.setBackgroundColor(unselectedBackgroundColor, for: .normal)
            }
            button.titleLabel?.textColor = unselectedTextColor
            button.layer.borderColor = borderColor.cgColor
            if button == sender {
                if #available(iOS 15.0, *) {
                    button.configuration?.baseBackgroundColor = selectedBackgroundColor
                    button.configuration?.baseForegroundColor = selectedTextColor
                } else {
                    button.setBackgroundColor(selectedBackgroundColor, for: .normal)
                }
                button.setTitleColor(selectedTextColor, for: .normal)
                button.layer.borderColor = UIColor.clear.cgColor
                self.selectedIndex = index
                self.delegate?.segmentValueChanged(to: index, sender: self)
            }
        }
    }
}

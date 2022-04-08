import UIKit
import SnapKit

final class NewClubStepView: UIView {
    private let levelLabel = UILabel().then {
        $0.font = UIFont(font: GCMSFontFamily.Inter.medium, size: 16)
    }
    private let titleLabel = UILabel().then {
        $0.font = UIFont(font: GCMSFontFamily.Inter.bold, size: 12)
    }
    private let underBar = UIView().then {
        $0.backgroundColor = GCMSAsset.Colors.gcmsGray5.color
        $0.layer.cornerRadius = 2
    }
    private let shape = CAShapeLayer()
    
    var selectedBackgroundColor = GCMSAsset.Colors.gcmsMainColor.color
    var unSelectedBackgroundColor = GCMSAsset.Colors.gcmsGray4.color
    var selectedLevelTintColor = GCMSAsset.Colors.gcmsGray1.color
    var unSelectedLevelTintColor = GCMSAsset.Colors.gcmsGray5.color
    var selectedTitleLabelTintColor = GCMSAsset.Colors.gcmsMainColor.color
    var unSelectedTitleLabelTintColor = GCMSAsset.Colors.gcmsGray4.color
    var isSelected: Bool = false {
        didSet { update() }
    }
    
    init(
        level: Int,
        title: String
    ) {
        super.init(frame: .zero)
        addView()
        setLayout()
        configure()
        self.levelLabel.text = "\(level)"
        self.titleLabel.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        drawPath(rect: rect)
    }
    
}

private extension NewClubStepView {
    func drawPath(rect: CGRect) {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: rect.width/2, y: rect.maxY + 5))
        path.addLine(to: CGPoint(x: rect.width/2 - 4, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.width/2 + 4, y: rect.maxY))
        path.close()
        
        shape.fillColor = isSelected ? selectedBackgroundColor.cgColor : unSelectedBackgroundColor.cgColor
        shape.path = path.cgPath
        self.layer.addSublayer(shape)
    }
    func addView() {
        addSubViews(levelLabel, titleLabel, underBar)
    }
    func setLayout() {
        levelLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.snp.bottom).offset(20)
        }
        underBar.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.snp.bottom).offset(10)
            $0.height.equalTo(3)
            $0.width.equalTo(11)
        }
    }
    func configure() {
        levelLabel.textColor = isSelected ? selectedLevelTintColor : unSelectedLevelTintColor
        titleLabel.textColor = isSelected ? selectedTitleLabelTintColor : unSelectedTitleLabelTintColor
        backgroundColor = isSelected ? selectedBackgroundColor : unSelectedBackgroundColor
        underBar.isHidden = !isSelected
    }
    func update() {
        shape.fillColor = isSelected ? selectedBackgroundColor.cgColor : unSelectedBackgroundColor.cgColor
        levelLabel.textColor = isSelected ? selectedLevelTintColor : unSelectedLevelTintColor
        titleLabel.textColor = isSelected ? selectedTitleLabelTintColor : unSelectedTitleLabelTintColor
        backgroundColor = isSelected ? selectedBackgroundColor : unSelectedBackgroundColor
        underBar.isHidden = !isSelected
    }
}

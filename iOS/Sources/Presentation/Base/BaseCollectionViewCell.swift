import UIKit
import RxSwift
import Reusable

class BaseCollectionViewCell<T>: UICollectionViewCell, Reusable {
    let bound = UIScreen.main.bounds
    lazy var disposeBag: DisposeBag = .init()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addView()
        setLayout()
        configureCell()
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        setLayoutSubviews()
    }
    func addView(){}
    func setLayout(){}
    func setLayoutSubviews(){}
    func configureCell(){}
    var model: T? {
        didSet { if let model = model { bind(model) } }
    }
    func bind(_ model: T){}
}

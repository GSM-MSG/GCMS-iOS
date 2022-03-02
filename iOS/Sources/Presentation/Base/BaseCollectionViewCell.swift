import UIKit
import RxSwift

class BaseCollectionViewCell<T>: UICollectionViewCell{
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
    func addView(){}
    func setLayout(){}
    func configureCell(){}
    var model: T? {
        didSet { if let model = model { bind(model) } }
    }
    func bind(_ model: T){}
}

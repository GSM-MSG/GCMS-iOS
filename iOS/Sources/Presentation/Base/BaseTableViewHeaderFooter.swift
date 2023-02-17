import UIKit
import Reusable
import RxSwift

class BaseTableViewHeaderFooterView<T>: UITableViewHeaderFooterView, Reusable {

    var disposeBag = DisposeBag()
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addView()
        setLayout()
        configureCell()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var model: T? {
        didSet { if let model = model { bind(model) } }
    }

    func addView() {}
    func setLayout() {}
    func configureCell() {}
    func bind(_ model: T) {}
}

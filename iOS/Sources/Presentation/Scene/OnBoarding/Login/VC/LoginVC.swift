import UIKit
import Then
import SnapKit
import RxCocoa
import AuthenticationServices
import Service
import RxSwift

final class LoginVC : BaseVC<LoginReactor> {
    
    private let titleasdf = UILabel().then {
        $0.text = "?SDFafiquwhefojaisojfiodsjfjsoif"
    }
    
    override func addView() {
        view.addSubViews(titleasdf)
    }
    
    override func setLayout() {
        titleasdf.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    override func configureVC() {
        view.backgroundColor = GCMSAsset.Colors.gcmsBackgroundColor.color
    }
    
}

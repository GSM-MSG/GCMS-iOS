import UIKit

extension UINavigationItem {
    func configTitle(
        title: String,
        font: UIFont = UIFont(font: GCMSFontFamily.Inter.semiBold, size: 16) ?? .init()
    ) {
        let lb = UILabel()
        lb.font = font
        lb.textColor = .white
        lb.text = title
        self.titleView = lb
    }
    func configTitleImage() {
        let iv = UIImageView()
        iv.image = GCMSAsset.Images.gcmsWhaleLogo.image.withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFit
        self.titleView = iv
    }
    func configBack(){
        let back = UIBarButtonItem(title: "돌아가기", style: .plain, target: nil, action: nil)
        back.tintColor = GCMSAsset.Colors.gcmsGray1.color
        self.backBarButtonItem = back
    }
}

extension UINavigationBar {
    func setClear() {
        self.setBackgroundImage(UIImage(), for: .default)
        self.shadowImage = UIImage()
        self.backgroundColor = .clear
    }
}

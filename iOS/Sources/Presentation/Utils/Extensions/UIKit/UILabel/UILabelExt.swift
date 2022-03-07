import UIKit

extension UILabel {
    func appendRequired() {
        let str = NSMutableAttributedString(string: "\(self.text ?? "")(필수)")
        str.setFontForText(textToFind: "(필수)", withFont: .init(font: GCMSFontFamily.Inter.semiBold, size: 13) ?? .init())
        str.setColorForText(textToFind: "(필수)", withColor: GCMSAsset.Colors.gcmsGray4.color)
        self.attributedText = str
    }
}

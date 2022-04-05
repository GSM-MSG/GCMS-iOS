import UIKit

extension UILabel {
    func appendSelection() {
        let str = NSMutableAttributedString(string: "\(self.text ?? "") [선택]")
        str.setFontForText(textToFind: "[선택]", withFont: .init(font: GCMSFontFamily.Inter.semiBold, size: 11) ?? .init())
        str.setColorForText(textToFind: "[선택]", withColor: GCMSAsset.Colors.gcmsGray1.color)
        self.attributedText = str
    }
}

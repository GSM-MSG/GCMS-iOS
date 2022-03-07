import UIKit
import Hero

extension UIViewController {
    
    
    @objc func leftSwipeDismiss(gestureRecognizer: UIPanGestureRecognizer) {
        let translation = gestureRecognizer.translation(in: nil)
        let progress = translation.x / 2 / view.bounds.width
        let gestureView = gestureRecognizer.location(in: self.view)
        
        switch gestureRecognizer.state {
        case .began:
            if gestureView.x <= 30 {
                hero.dismissViewController()
            }
            
        case .changed:
            let translation = gestureRecognizer.translation(in: nil)
            let progress = translation.x / 2 / view.bounds.width
            Hero.shared.update(progress)
            
        default:
            if progress + gestureRecognizer.velocity(in: nil).x / view.bounds.width > 0.3 {
                Hero.shared.finish()
                return
            }
            Hero.shared.cancel()
        }
        
    }
}

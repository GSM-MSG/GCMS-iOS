import UIKit
import Foundation

final class WaveView: UIView {
    enum Direction {
        case left, right
    }
    private weak var displayLink: CADisplayLink?
    private var startTime: TimeInterval = 0
    
    var customLayer = CAShapeLayer()
    
    var speed: Double = 10
    var frequency = 27.0
    var parameterA = 1.5
    var parameterB = 13.5
    var phase = 0.0
    
    var preferredColor = UIColor.cyan
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        customLayer.frame = rect
        
        let width = Double(self.frame.width)
        let height = Double(self.frame.height)
        
        let mid = height * 1
        
        let waveLength = width / self.frequency
        let waveHeightCoef = Double(self.frequency)
        path.move(to: CGPoint(x: 0, y: frame.minY))
        path.addLine(to: CGPoint(x: 0, y: mid))
        
        for x in stride(from: 0, through: width, by: width/7) {
            let actualX = x/waveLength
            let since = -cos(self.parameterA*(actualX + self.phase)) * sin((actualX + self.phase)/self.parameterB)
            let y = waveHeightCoef * since + mid
            path.addLine(to: CGPoint(x: x, y: y))
        }
        path.addLine(to: CGPoint(x: CGFloat(width), y: self.frame.minY))
        path.addLine(to: CGPoint(x: 0, y: self.frame.minY))
        
        customLayer.path = path.cgPath
        customLayer.fillColor = preferredColor.cgColor
        customLayer.strokeColor = preferredColor.cgColor
        self.layer.addSublayer(customLayer)
    }
    
    
    func animationStart(direction: Direction, speed: Double) {
        if direction == .right {
            self.speed = -speed
        } else {
            self.speed = speed
        }
        self.startDisplayLink()
    }
    
    
}

private extension WaveView {
    func startDisplayLink() {
        startTime = CACurrentMediaTime()
        self.displayLink?.invalidate()
        let displayLink = CADisplayLink(target: self, selector:#selector(handleDisplayLink(_:)))
        displayLink.add(to: .main, forMode: .common)
        self.displayLink = displayLink
    }
    func stopDisplayLink() {
        displayLink?.invalidate()
    }
    @objc func handleDisplayLink(_ displayLink: CADisplayLink) {
        self.phase = (CACurrentMediaTime() - startTime) * self.speed
        self.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        self.setNeedsDisplay()
    }
}

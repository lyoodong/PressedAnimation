//
//  PressedButton.swift
//  PressedAnimation
//
//  Created by Dongwan Ryoo on 11/24/24.
//

import UIKit

class PressedButton: UIButton {
    
    // MARK: - Properties
    
    private var isAnimating = false
    private let duration: TimeInterval = 0.2
    private let pressedScale: CGFloat = 0.95
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Touch Events
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        handleTouchBegan()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        handleTouchEnded()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        animate(isPressed: false)
    }
    
    // MARK: - Private Methods
    
    private func handleTouchBegan() {
        animate(isPressed: true)
        isAnimating = true
        
        print("handleTouchBegan 호출")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration / 4) { [weak self] in
            self?.isAnimating = false
        }
    }
    
    private func handleTouchEnded() {
        print("handleTouchEnded 호출")
        if isAnimating {
            DispatchQueue.main.asyncAfter(deadline: .now() + duration / 4) { [weak self] in
                self?.animate(isPressed: false)
                self?.isAnimating = false
            }
        } else {
            animate(isPressed: false)
        }
    }
    
    private func animate(isPressed: Bool) {
        let transform = isPressed ?
        CGAffineTransform(scaleX: pressedScale, y: pressedScale) : .identity
        let backgroundColor = isPressed ?
        UIColor.black.withAlphaComponent(0.1) : .white
        
        UIView.animate(withDuration: duration) { [weak self] in
            guard let self = self else { return }
            self.transform = transform
            self.backgroundColor = backgroundColor
        }
    }
    
}

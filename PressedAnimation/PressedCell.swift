//
//  PressedCell.swift
//  PressedAnimation
//
//  Created by Dongwan Ryoo on 11/24/24.
//

import UIKit

final class PressedCell: UITableViewCell {
    
    // MARK: - Properties
    
    private var isAnimating = false
    private let duration: TimeInterval = 0.2
    private let pressedScale: CGFloat = 0.95
    
    // MARK: - UI Components
    
    private let bgView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        return view
    }()
    
    private let logoView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        return view
    }()
    
    private let title: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .darkGray
        return label
    }()
    
    private let subTitle: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        configure()
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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration / 4) { [weak self] in
            self?.isAnimating = false
        }
    }
    
    private func handleTouchEnded() {
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
            UIColor.black.withAlphaComponent(0.1) : .clear
        
        UIView.animate(withDuration: duration) { [weak self] in
            guard let self = self else { return }
            self.bgView.transform = transform
            self.bgView.backgroundColor = backgroundColor
        }
    }
    
    private func setupUI() {
        contentView.addSubview(bgView)
        [logoView, title, subTitle].forEach { bgView.addSubview($0) }
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        bgView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        logoView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(30)
        }
        
        title.snp.makeConstraints {
            $0.top.equalTo(logoView.snp.top)
            $0.leading.equalTo(logoView.snp.trailing).offset(6)
        }
        
        subTitle.snp.makeConstraints {
            $0.bottom.equalTo(logoView.snp.bottom)
            $0.leading.equalTo(logoView.snp.trailing).offset(6)
        }
    }
    
    private func configure() {
        selectionStyle = .none
    }
    
    // MARK: - Public Methods
    
    func setDataSource(_ model: Model) {
        logoView.backgroundColor = model.logoColor
        title.text = model.title
        subTitle.text = model.subTitle
    }
}

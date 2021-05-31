//
//  NavBar.swift
//  quotebook
//
//  Created by Shyam Kumar on 5/30/21.
//

import UIKit

class NavBar: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    lazy var outerStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(buttonStackView)
        return stack
    }()
    
    lazy var buttonStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 20
        
        stack.addArrangedSubview(plusButton)
        stack.addArrangedSubview(pencilButton)
        return stack
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "chelsea"
        label.font = Fonts.bold.withSize(20)
        label.textColor = .white
        return label
    }()
    
    lazy var plusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var pencilButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "pencil"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(pencilButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var checkButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "checkmark"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var plusButtonCompletion: () -> Void = { return }
    var pencilButtonCompletion: () -> Void = { return }
    var checkButtonCompletion: () -> Void = { return }
    
    @objc func pencilButtonTapped() {
        pencilButtonCompletion()
    }
    
    @objc func plusButtonTapped() {
        plusButtonCompletion()
    }
    
    @objc func checkButtonTapped() {
        checkButtonCompletion()
    }
    
    override func layoutSubviews() {
        setupConstraints()
    }
    
    func setupConstraints() {
        addSubview(outerStackView)
        
        outerStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        outerStackView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        outerStackView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        outerStackView.heightAnchor.constraint(equalToConstant: frame.height).isActive = true
    }
    
    func addQuoteScreen() {
        for sub in buttonStackView.arrangedSubviews { sub.removeFromSuperview() }
        buttonStackView.insertArrangedSubview(checkButton, at: 0)
    }
    
    func resetAddQuoteScreen() {
        for sub in buttonStackView.arrangedSubviews { sub.removeFromSuperview() }
        buttonStackView.insertArrangedSubview(plusButton, at: 0)
        buttonStackView.insertArrangedSubview(pencilButton, at: 1)
    }

}

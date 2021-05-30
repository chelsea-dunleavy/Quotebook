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
        label.text = "quotebook"
        label.font = Fonts.bold.withSize(20)
        label.textColor = .white
        return label
    }()
    
    lazy var plusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    lazy var pencilButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "pencil"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
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

}

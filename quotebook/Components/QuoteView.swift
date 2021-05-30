//
//  QuoteView.swift
//  quotebook
//
//  Created by Shyam Kumar on 5/30/21.
//

import UIKit

class QuoteView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var quote = "If you don't have room to fail, you don't have room to grow"
    var desc = "Nelson Mandela"
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillProportionally
        stack.spacing = 0
        
        stack.addArrangedSubview(quoteLabel)
        stack.addArrangedSubview(descLabel)
        return stack
    }()
    
    lazy var quoteLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.font = Fonts.regular.withSize(25)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.text = quote
        label.setLineHeight(lineHeight: 1.2)
        return label
    }()
    
    lazy var quoteTextField: UITextView = {
        let tv = UITextView()
        tv.adjustsFontForContentSizeCategory = true
        tv.isScrollEnabled = false
        tv.textColor = .white
        tv.font = Fonts.regular.withSize(25)
        tv.backgroundColor = .clear
        return tv
    }()
    
    lazy var descLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = .gray
        label.font = Fonts.regular
        label.adjustsFontSizeToFitWidth = true
        label.text = desc
        return label
    }()
    
    override func layoutSubviews() {
        setupConstraints()
    }
    
    func setupConstraints() {
        addSubview(stackView)
        
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    func addQuoteScreen() {
        stackView.arrangedSubviews[0].removeFromSuperview()
        stackView.insertArrangedSubview(quoteTextField, at: 0)
        quoteTextField.becomeFirstResponder()
    }
    
    func resetAddQuoteScreen() {
        quoteTextField.resignFirstResponder()
        UIView.animate(withDuration: 0.3, animations: {
            self.stackView.alpha = 0
        }, completion: {fin in
            self.stackView.arrangedSubviews[0].removeFromSuperview()
            self.stackView.insertArrangedSubview(self.quoteLabel, at: 0)
            UIView.animate(withDuration: 0.3, animations: {
                self.stackView.alpha = 1
            })
        })
    }
    
    func getQuoteInTextField() -> Quote? {
        if quoteTextField.hasText {
            let newQuote = Quote(quote: quoteTextField.text)
            quoteTextField.text = ""
            return newQuote
        }
        return nil
    }

}

extension UILabel {
    func setLineHeight(lineHeight: CGFloat) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 1.0
        paragraphStyle.lineHeightMultiple = lineHeight
        paragraphStyle.alignment = self.textAlignment

        let attrString = NSMutableAttributedString()
        if (self.attributedText != nil) {
            attrString.append( self.attributedText!)
        } else {
            attrString.append( NSMutableAttributedString(string: self.text!))
            attrString.addAttribute(NSAttributedString.Key.font, value: self.font as Any, range: NSMakeRange(0, attrString.length))
        }
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        self.attributedText = attrString
    }
}

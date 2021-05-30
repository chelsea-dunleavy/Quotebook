//
//  ViewController.swift
//  quotebook
//
//  Created by Shyam Kumar on 5/29/21.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var purpleCircleView: Circle = {
        let v = Circle()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var navBar: NavBar = {
        let nb = NavBar()
        nb.translatesAutoresizingMaskIntoConstraints = false
        nb.backgroundColor = .clear
        nb.plusButtonCompletion = plusButtonTapped
        nb.pencilButtonCompletion = pencilButtonTapped
        nb.checkButtonCompletion = checkButtonTapped
        return nb
    }()
    
    lazy var quoteView: QuoteView = {
        let qv = QuoteView()
        qv.translatesAutoresizingMaskIntoConstraints = false
        qv.backgroundColor = .clear
        qv.alpha = 0
        return qv
    }()
    
    lazy var rightSwipeGesture: UISwipeGestureRecognizer = {
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(ySwipe))
        swipe.direction = .right
        return swipe
    }()
    
    lazy var leftSwipeGesture: UISwipeGestureRecognizer = {
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(ySwipe))
        swipe.direction = .left
        return swipe
    }()
    
    var circles: [Circle] = []
    
    var quotes: [Quote] = []
    
    var index = 0
    
    var yConstraint: NSLayoutConstraint? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        DataOps.checkFirstLaunch()
        quotes = DataOps.retrieveData() ?? []
        quotes.shuffle()
        setupView()
        setupConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        for circle in circles {
            circle.animateCircle()
        }
    }
    
    func setupView() {
        view.backgroundColor = Colors.darkBackground
        setupCircles()
        setupQuoteView(quote: quotes[0])
        
        view.addGestureRecognizer(leftSwipeGesture)
        view.addGestureRecognizer(rightSwipeGesture)
    }
    
    func setupConstraints() {
        view.addSubview(navBar)
        view.addSubview(quoteView)
        
        navBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        navBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        navBar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        navBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        yConstraint = quoteView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        yConstraint!.isActive = true
        quoteView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        quoteView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        quoteView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
    }
    
    func setupCircles() {
        addCircleView(color: Colors.purple, topAnchor: 125, rightAnchor: 50, widthAnchor: 100, heightAnchor: 100, ySide: .right, xSide: .top)
        addCircleView(color: Colors.yellow, topAnchor: -50, rightAnchor: -80, widthAnchor: 70, heightAnchor: 70, ySide: .right, xSide: .top)
        addCircleView(color: Colors.orange, bottomAnchor: -20, leftAnchor: -45, widthAnchor: 80, heightAnchor: 80, ySide: .left, xSide: .bottom)
        addCircleView(color: UIColor.red.withAlphaComponent(0.9), bottomAnchor: -130, rightAnchor: 5, widthAnchor: 40, heightAnchor: 40, ySide: .right, xSide: .bottom)
        addCircleView(color: Colors.purple, bottomAnchor: -30, rightAnchor: -80, widthAnchor: 20, heightAnchor: 20, ySide: .right, xSide: .bottom)
        addCircleView(color: UIColor.darkGray, topAnchor: 100, leftAnchor: 50, widthAnchor: 30, heightAnchor: 30, ySide: .left, xSide: .top)
    }
    
    func setupQuoteView(quote: Quote) {
        UIView.animate(withDuration: 0.3, animations: {
            self.quoteView.alpha = 0
        }, completion: {fin in
            self.quoteView.quoteLabel.text = quote.quote
            self.quoteView.descLabel.text = quote.desc
            UIView.animate(withDuration: 0.3, animations: {
                self.quoteView.alpha = 1
            })
        })
    }
    
    @objc func ySwipe(_ sender: UISwipeGestureRecognizer) {
        switch sender.direction {
        case .left:
            index = (index + 1) % (quotes.count)
            setupQuoteView(quote: quotes[index])
        case .right:
            index = index - 1
            if index < 0 {
                index = quotes.count - 1
            }
            setupQuoteView(quote: quotes[index])
        default:
            return
        }
    }

    
    enum ySide {
        case right
        case left
    }
    
    enum xSide {
        case top
        case bottom
    }
    
    func addCircleView(color: UIColor, topAnchor: CGFloat = 0, bottomAnchor: CGFloat = 0, rightAnchor: CGFloat = 0, leftAnchor: CGFloat = 0, widthAnchor: CGFloat, heightAnchor: CGFloat, ySide: ySide, xSide: xSide) {
        let circleView: Circle = {
            let v = Circle()
            v.color = color
            v.width = widthAnchor
            v.height = heightAnchor
            v.translatesAutoresizingMaskIntoConstraints = false
            return v
        }()
        
        view.addSubview(circleView)
        circleView.widthAnchor.constraint(equalToConstant: widthAnchor).isActive = true
        circleView.heightAnchor.constraint(equalToConstant: heightAnchor).isActive = true
        
        switch ySide {
        case .left:
            circleView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: leftAnchor).isActive = true
        default:
            circleView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: rightAnchor).isActive = true
        }
        
        switch xSide {
        case .top:
            circleView.topAnchor.constraint(equalTo: view.topAnchor, constant: topAnchor).isActive = true
        default:
            circleView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottomAnchor).isActive = true
        }
        
        circles.append(circleView)
    }


}

extension ViewController {
    func plusButtonTapped() {
        for circle in circles { circle.scaleDown() }
        quoteView.addQuoteScreen()
        moveUpQuoteView()
        navBar.addQuoteScreen()
    }
    
    func moveUpQuoteView() {
        UIView.animate(withDuration: 0.3, animations: {
            self.yConstraint?.constant = -100
        })
    }
    
    func resetAddQuoteScreen() {
        for circle in circles { circle.scaleUp() }
        self.yConstraint?.constant = 0
        quoteView.resetAddQuoteScreen()
    }
    
    func pencilButtonTapped() {
    }
    
    func checkButtonTapped() {
        resetAddQuoteScreen()
        navBar.resetAddQuoteScreen()
        guard let newQuote = quoteView.getQuoteInTextField() else { return }
        quotes.append(newQuote)
        DataOps.replaceData(quotes: quotes)
        setupQuoteView(quote: newQuote)
        index = quotes.count - 1
    }
}


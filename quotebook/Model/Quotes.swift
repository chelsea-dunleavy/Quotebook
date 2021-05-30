//
//  Quotes.swift
//  quotebook
//
//  Created by Shyam Kumar on 5/29/21.
//

import Foundation

public class Quotes: NSObject, NSCoding {
    var quotes: [Quote] = []
    
    enum Key: String {
        case quotesArr = "quotesArr"
    }
    
    init(quotesArr: [Quote]) {
        self.quotes = quotesArr
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(quotes, forKey: Key.quotesArr.rawValue)
    }
    
    public required convenience init?(coder: NSCoder) {
        let intermQuotes = coder.decodeObject(forKey: Key.quotesArr.rawValue) as! [Quote]
        
        self.init(quotesArr: intermQuotes)
    }
}

public class Quote: NSObject, NSCoding {
    
    public var quote: String = ""
    public var desc: String = ""
    
    enum Key: String {
        case quote = "quote"
        case desc = "description"
    }
    
    init(quote: String, desc: String) {
        self.quote = quote
        self.desc = desc
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(quote, forKey: Key.quote.rawValue)
        coder.encode(desc, forKey: Key.desc.rawValue)
    }
    
    public required convenience init?(coder: NSCoder) {
        let interQuote = coder.decodeObject(forKey: Key.quote.rawValue) as! String
        let interDesc = coder.decodeObject(forKey: Key.desc.rawValue) as! String
        
        self.init(quote: interQuote, desc: interDesc)
    }
}

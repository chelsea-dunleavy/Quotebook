//
//  DataOps.swift
//  quotebook
//
//  Created by Shyam Kumar on 5/29/21.
//

import Foundation
import UIKit
import CoreData

public class DataOps {
    
    enum Key: String {
        case quotesArr = "quotesArr"
    }
    
    static func checkFirstLaunch() {
        let quotes = retrieveData()
        if quotes == nil {
            replaceData(quotes: startingQuotes)
        }
    }
    
    static func replaceData(quotes: [Quote]) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        guard let userEntity = NSEntityDescription.entity(forEntityName: "QuoteBook", in: managedContext) else { return }
        
        let qb = NSManagedObject(entity: userEntity, insertInto: managedContext) as! QuoteBook
        let interVal = Quotes(quotesArr: quotes)
        print(interVal.quotes.count)
        
        qb.setValue(interVal, forKey: Key.quotesArr.rawValue)
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("\(error)")
            return
        }
    }
    
    static func retrieveData() -> [Quote]? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "QuoteBook")
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            
            if let res = result as? [NSManagedObject] {
                if res.count == 0 { return nil }
                let data = res.last
                let quotes = data?.value(forKey: Key.quotesArr.rawValue) as! Quotes
                return quotes.quotes
            }
            
        } catch {
            print("Failed.")
        }
        
        return nil
    }
}

public var startingQuotes = [
    Quote(quote: "No one knows what they are doing most of the time"),
    Quote(quote: "Comparison is the thief of joy"),
    Quote(quote: "Your perception is your reality"),
    Quote(quote: "There is great strength in vulnerability"),
    Quote(quote: "Bruised heels still crush the heads of serpents"),
    Quote(quote: "The 7 people you spend the most time with are the people you become like"),
    Quote(quote: "1/7 of your life is a Tuesday"),
    Quote(quote: "Whether you believe you can or can't, you're right"),
    Quote(quote: "You must do what 95% won't to be in the 5%"),
    Quote(quote: "Let yourself be a walking testimonial"),
    Quote(quote: "One of the most important qualities a person can have is curiosity"),
    Quote(quote: "Christianity cannot be separated from civic engagement"),
    Quote(quote: "People rarely listen to your words when you speak, but they listen to your tone"),
    Quote(quote: "No one can make you feel inferior without your consent"),
    Quote(quote: "Hurt people hurt people"),
    Quote(quote: "If you say you're going to do something, do it"),
    Quote(quote: "Commit to a mission, philosophy, or goal; not a person, place or thing"),
    Quote(quote: "Self care can be ugly"),
    Quote(quote: "To feel greatly can be a blessing and a curse, but to feel is the crux of your humanity"),
    Quote(quote: "Always be nice to the workers around you; treat the janitor and the president with the same respect"),
    Quote(quote: "Show your friends you love them on Valentine's Day"),
    Quote(quote: "Make friends with people who are good at what you're not"),
    Quote(quote: "Have the courage to fully live your life"),
    Quote(quote: "You are worth the $7 cheese"),
    Quote(quote: "There is a sliding scale when it comes to control over your life"),
    Quote(quote: "Someone else's perception doesn't have to be your reality"),
    Quote(quote: "You can be ugly and beautiful on the same day, it just depends on who you're with"),
    Quote(quote: "Be the person you want to be"),
    Quote(quote: "Don't wait for someone to be a better person"),
    Quote(quote: "Never apologize for advocating for yourself")
]

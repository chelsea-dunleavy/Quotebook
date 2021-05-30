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
    
    static func replaceData(quotes: [Quote]) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        guard let userEntity = NSEntityDescription.entity(forEntityName: "QuoteBook", in: managedContext) else { return }
        
        let qb = NSManagedObject(entity: userEntity, insertInto: managedContext) as! QuoteBook
        let interVal = Quotes(quotesArr: quotes)
        
        qb.setValue(interVal, forKey: Key.quotesArr.rawValue)
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("\(error)")
            return
        }
        print("Success!")
    }
    
    static func retrieveData() -> [Quote]? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "QuoteBook")
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            assert(result.count == 1)
            
            for data in result as! [NSManagedObject] {
                let quotes = data.value(forKey: Key.quotesArr.rawValue) as! Quotes
                return quotes.quotes
            }
            
        } catch {
            print("Failed.")
        }
        
        return nil
    }
}

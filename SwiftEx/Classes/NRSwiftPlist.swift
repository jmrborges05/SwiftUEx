
import UIKit

enum NRSimplePlistError: ErrorType {
     case Fatal(String)
}

public func plistGet(key: String, forPlistNamed: String) throws -> AnyObject? {
     let formats: UnsafeMutablePointer<NSPropertyListFormat> = nil
     if let path: String = NSBundle.mainBundle().pathForResource(forPlistNamed, ofType: "plist") {
          if let plistData = NSData(contentsOfFile: path) {
               do {
                    let plist = try NSPropertyListSerialization.propertyListWithData(plistData, options: .Immutable, format: formats) as! NSDictionary
                    if (path=="") {
                         NSLog("NRSimplePlist - Errore LETTURA file plist '\(path)'")
                         NSLog("NRSimplePlist - Error READING plist file '\(path)'")
                         throw NRSimplePlistError.Fatal("NRSimplePlist - Error READING plist file '\(path)'")
                    }
                    if let tipo = plist.valueForKey(key) {
                         return tipo
                    }
               } catch let error1 as NSError {
                    NSLog("NRSimplePlist - Errore LETTURA file plist '\(path)', errore = '\(error1.localizedDescription)'")
                    NSLog("NRSimplePlist - Error READING plist file '\(path)', error = '\(error1.localizedDescription)'")
                    throw error1
               } catch {
                    NSLog("NRSimplePlist - Errore LETTURA file plist '\(path)'")
                    NSLog("NRSimplePlist - Error READING plist file '\(path)',")
                    throw NRSimplePlistError.Fatal("NRSimplePlist - Error READING plist property")
               }
               return nil
          }
     } else {
          print("File '\(forPlistNamed)' not found")
     }
     return nil
}

public func plistSet(newValue: AnyObject, forKey: String, inPlistNamed: String) throws {
     let formats: UnsafeMutablePointer<NSPropertyListFormat> = nil
     var array: NSMutableDictionary = NSMutableDictionary()
     let fileManager: NSFileManager = NSFileManager.defaultManager()
     if let path: NSString = NSBundle.mainBundle().pathForResource(inPlistNamed, ofType: "plist") {
          if fileManager.fileExistsAtPath(path as String) {
               if let plistData = NSData(contentsOfFile: path as String) {
                    do {
                         let plist = try NSPropertyListSerialization.propertyListWithData(plistData, options: .MutableContainers, format: formats) as! NSMutableDictionary
                         if (path=="") {
                              NSLog("NRSimplePlist - Errore LETTURA file plist '\(path)'")
                              NSLog("NRSimplePlist - Error READING plist file '\(path)'")
                              throw NRSimplePlistError.Fatal("NRSimplePlist - Error READING plist file '\(path)'")
                         }
                         array = plist.mutableCopy() as! NSMutableDictionary
                         print(path)
                         array.setObject(newValue, forKey: forKey)
                         array.writeToFile(path as String, atomically: true)
                    } catch let error1 as NSError {
                         NSLog("NRSimplePlist - Errore LETTURA file plist '\(path)', errore = '\(error1.localizedDescription)'")
                         NSLog("NRSimplePlist - Error READING plist file '\(path)', error = '\(error1.localizedDescription)'")
                         throw error1
                    }
               }
          } else {
               print("File '\(inPlistNamed)' not found setting value \(newValue) for key \(forKey)")
          }
     } else {
          print("NRswiftPlist - The file in the path doesn't exists")
     }
}

//
//  ViewController.swift
//  StringHelpers
//
//  Created by Tabish on 5/4/21.
//

import UIKit

class ViewController: UIViewController {
    
    var dataArray = "tabishgul.com/operations/play.php?_channel=_kkn&_token=_006a79366195&_lat=31.471391&_lng=74.277735"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let StringArr = turnToArray()

        print("<< Array Elements >>")
        for text in StringArr.enumerated() {
            print("'\(text.element)' at index: \(text.offset)")
        }

        print("\n<< Reversed Array >>")
        for element in StringArr.reversed() {
            print(element)
        }

        print("\n<< Find In Between >>")
        /// Contains check if the array contain index number
        if StringArr.indices.contains(2) && StringArr[2].contains("lat") && StringArr[2].contains("lng") {
            getLatitudeLongitude(lastPart: StringArr[2])
        }

        print("\n<< IndexExists >>")
        if let index = StringArr.firstIndex(where: {$0 == "operations"}) {
            print("\(StringArr[index]) exists at index: \(index)")
        }

        print("\n<< Map Array >>")
        let urlArray = StringArr.map({ return $0 })
        for directory in urlArray {
            print(directory)
        }

        print("\n<< Filter >>")
        let result = StringArr.filter{($0.contains("operations"))}
        print(result)
        
        print("\n<< Array Sum >>")
        let numbers = [1,2,3,4]
        let reducedNumberSum = numbers.reduce(0,+)
        print("Numbers sum is: ", reducedNumberSum)
    }
}

extension ViewController {
    
    /// Find Lat, Long from last element of string array
    func getLatitudeLongitude(lastPart: String) {
        var lastPart = lastPart
        
        lastPart = lastPart + "~"
        
        guard let lat = lastPart.slice(from: "lat=", to: "&_lng") else {
            return
        }
        print("Latitude is: \(lat)")
        
        guard let lng = lastPart.slice(from: "lng=", to: "~") else {
            return
        }
        print("Longitude is: \(lng)")
    }
    
    /// Convert string to string array based on '/'
    func turnToArray() -> [String] {
        let slashSepArray = dataArray.components(separatedBy: "/")
        return slashSepArray
    }
}

// MARK: - String Extension
extension String {
    
    /// Helps in finding the element in between strings
    func slice(from: String, to: String) -> String? {
        guard let rangeFrom = range(of: from)?.upperBound else { return nil }
        guard let rangeTo = self[rangeFrom...].range(of: to)?.lowerBound else { return nil }
        return String(self[rangeFrom..<rangeTo])
    }
}

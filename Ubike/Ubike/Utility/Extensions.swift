//
//  Extensions.swift
//  Ubike
//
//  Created by kidnapper on 2019/11/24.
//  Copyright © 2019 kidnapper. All rights reserved.
//

import Foundation
import CoreLocation

extension KeyedDecodingContainer {
    
    func decodeToLocation(latKey: Key, logKey: Key) throws -> CLLocation {
        let lat: CLLocationDegrees
        let log: CLLocationDegrees
        
        if let latValue: CLLocationDegrees = try? decode(CLLocationDegrees.self, forKey: latKey) {
            lat = latValue
        } else if let latString: String = try? decode(String.self, forKey: latKey) {
            let trimmedString: String = latString.trimmingCharacters(in: .whitespaces)
            if let result: CLLocationDegrees = CLLocationDegrees(trimmedString) {
                lat = result
            } else {
                throw DecodingError.typeMismatch(CLLocationDegrees.self,
                                                 DecodingError.Context(codingPath: codingPath,
                                                                       debugDescription: "Wrong type for \(latKey) in \(CLLocationDegrees.self)."))
            }
        } else {
            throw DecodingError.typeMismatch(CLLocationDegrees.self,
                                             DecodingError.Context(codingPath: codingPath,
                                                                   debugDescription: "Wrong type for \(latKey) in \(CLLocationDegrees.self)."))
        }
        
        if let logValue: CLLocationDegrees = try? decode(CLLocationDegrees.self, forKey: logKey) {
            log = logValue
        } else if let logString: String = try? decode(String.self, forKey: logKey) {
            let trimmedString: String = logString.trimmingCharacters(in: .whitespaces)
            if let result: CLLocationDegrees = CLLocationDegrees(trimmedString) {
                log = result
            } else {
                throw DecodingError.typeMismatch(CLLocationDegrees.self,
                                                 DecodingError.Context(codingPath: codingPath,
                                                                       debugDescription: "Wrong type for \(logKey) in \(CLLocationDegrees.self)."))
            }
        } else {
            throw DecodingError.typeMismatch(CLLocationDegrees.self,
                                             DecodingError.Context(codingPath: codingPath,
                                                                   debugDescription: "Wrong type for \(logKey) in \(CLLocationDegrees.self)."))
        }
        return CLLocation(latitude: lat, longitude: log)
    }
    
    func decodeToDate(forKey: Key) throws -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
        
        if let stringValue: String = try? decode(String.self, forKey: forKey) {
            let trimmedString: String = stringValue.trimmingCharacters(in: .whitespaces)
            if let date: Date = dateFormatter.date(from: trimmedString) {
                return date
            }
        }
        throw DecodingError.typeMismatch(Date.self,
                                         DecodingError.Context(codingPath: codingPath,
                                                               debugDescription: "Wrong type for \(forKey) in \(Date.self)."))
        
    }
    
    func decodeToTimeInterval(forKey: Key) throws -> TimeInterval {
        if let timeInterval: TimeInterval = try? decode(TimeInterval.self, forKey: forKey) {
            return timeInterval
        } else if let timeIntervalString: String = try? decode(String.self, forKey: forKey) {
            let trimmedString: String = timeIntervalString.trimmingCharacters(in: .whitespaces)
            if let result: TimeInterval = TimeInterval(trimmedString) {
                return result
            }
        }
        throw DecodingError.typeMismatch(TimeInterval.self,
                                         DecodingError.Context(codingPath: codingPath,
                                                               debugDescription: "Wrong type for \(forKey) in \(TimeInterval.self)."))
    }
    
    func decodeToInt(forKey: Key) throws -> Int {
        if let intValue: Int = try? decode(Int.self, forKey: forKey) {
            return intValue
        } else if let double: Double = try? decode(Double.self, forKey: forKey) {
            return Int(double)
        } else if let string: String = try? decode(String.self, forKey: forKey) {
            let trimmedString: String = string.trimmingCharacters(in: .whitespaces)
            if let intValue: Int = Int(trimmedString) {
                return intValue
            } else if let doubleValue: Double = Double(trimmedString) {
                return Int(doubleValue)
            }
        }
        throw DecodingError.typeMismatch(Int.self,
                                         DecodingError.Context(codingPath: codingPath,
                                                               debugDescription: "Wrong type for \(forKey) in \(Int.self)."))
    }
    
    func decodeToBool(forKey: Key) throws -> Bool {
        if let boolValue: Bool = try? decode(Bool.self, forKey: forKey) {
            return boolValue
        } else if let doubleValue: Double = try? decode(Double.self, forKey: forKey) {
            return doubleValue != 0
        } else if let stringValue: String = try? decode(String.self, forKey: forKey) {
            let trimmedString: String = stringValue.trimmingCharacters(in: .whitespaces)
            if let doubleValue: Double = Double(trimmedString) {
                // "0", "0.0"
                return doubleValue != 0
            } else if let boolValue: Bool = Bool(trimmedString) {
                // "true"
                return boolValue
            }
        }
        throw DecodingError.typeMismatch(Bool.self,
                                         DecodingError.Context(codingPath: codingPath,
                                                               debugDescription: "Wrong type for \(forKey) in \(Bool.self)."))
        
    }
}

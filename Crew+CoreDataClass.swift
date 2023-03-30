//
//  Crew+CoreDataClass.swift
//  CoreDataCodable-Part2
//
//  Created by Danjuma Nasiru on 24/02/2023.
//
//

import Foundation
import CoreData


public class Crew: NSManagedObject, Codable {
    enum CodingKeys : CodingKey{
        case name, role
    }
    
    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else{
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        self.init(context: context)
        
        var container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name = try container.decode(String.self, forKey: .name)
        self.role = try container.decode(String.self, forKey: .role)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(role, forKey: .role)
    }
    
    
}

//
//  Mission+CoreDataClass.swift
//  CoreDataCodable-Part2
//
//  Created by Danjuma Nasiru on 24/02/2023.
//
//

import Foundation
import CoreData


public class Mission: NSManagedObject, Codable {
    enum CodingKeys : String, CodingKey{
        case id = "id"
        case launchDate = "launchDate"
        case desc = "description"
        case crew = "crew"
    }
    
    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else{
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        self.init(context: context)
        
        var container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int16.self, forKey: .id)
        self.desc = try container.decode(String.self, forKey: .desc)
        self.launchDate = try container.decode(Date.self, forKey: .launchDate)
        self.crew = try container.decode(Set<Crew>.self, forKey: .crew) as NSSet
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(desc, forKey: .desc)
        try container.encode(launchDate, forKey: .launchDate)
        try container.encode(crew as! Set<Crew>, forKey: .crew)
    }
    
    
}

//
//  NSManagedClasses.swift
//  CoreDataCodable-Part2
//
//  Created by Danjuma Nasiru on 24/02/2023.
//
import CoreData
import Foundation

class TodoItem: NSManagedObject, Codable {
    enum CodingKeys: CodingKey {
        case id, label, completions
      }
    
    required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
              throw DecoderConfigurationError.missingManagedObjectContext
            }

            self.init(context: context)

            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.id = try container.decode(Int64.self, forKey: .id)
            self.label = try container.decode(String.self, forKey: .label)
            self.completions = try container.decode(Set<TodoCompletion>.self, forKey: .completions) as NSSet
          
      }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(label, forKey: .label)
        try container.encode(completions as! Set<TodoCompletion>, forKey: .completions)
      }
}

class TodoCompletion: NSManagedObject, Codable {
    enum CodingKeys: CodingKey {
        case completionDate
      }
    
    required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
              throw DecoderConfigurationError.missingManagedObjectContext
            }

            self.init(context: context)

            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.completionDate = try container.decode(Date.self, forKey: .completionDate)
          
      }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(completionDate, forKey: .completionDate)
      }
}

class User : NSManagedObject, Codable{
    enum CodingKeys : CodingKey{
        case id, name, about, email, company, tags, friends, address, registered, age, isActive
    }
    
    required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else{
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        self.init(context: context)
        
        var container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.isActive = try container.decode(Bool.self, forKey: .isActive)
        self.age = try container.decode(Int16.self, forKey: .age)
        self.company = try container.decode(String.self, forKey: .company)
        self.about = try container.decode(String.self, forKey: .about)
        self.registered = try container.decode(Date.self, forKey: .registered)
        self.email = try container.decode(String.self, forKey: .email)
        self.address = try container.decode(String.self, forKey: .address)
        let decodedTags = try container.decode([String].self, forKey: .tags)
        self.tags = decodedTags.joined(separator: ", ")
        self.friends = try container.decode(Set<Friend>.self, forKey: .friends) as NSSet
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(isActive, forKey: .isActive)
        try container.encode(address, forKey: .address)
        try container.encode(company, forKey: .company)
        try container.encode(email, forKey: .email)
        let toEncodeTag = tags?.components(separatedBy: ", ")
        try container.encode(toEncodeTag, forKey: .tags)
        try container.encode(registered, forKey: .registered)
        try container.encode(age, forKey: .age)
        try container.encode(about, forKey: .about)
        try container.encode(friends as! Set<Friend>, forKey: .friends)
    }
}

class Friend : NSManagedObject, Codable{
    enum CodingKeys : CodingKey{
        case id, name, user
    }
    
    required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else{
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        
        self.init(context: context)
        
        var container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(UUID.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.user = try container.decode(User.self, forKey: .user)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = try encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(user, forKey: .user)
    }
}



class MissionXX: NSManagedObject, Codable {
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
        self.crewX = try container.decode(Set<CrewXX>.self, forKey: .crew) as NSSet
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(desc, forKey: .desc)
        try container.encode(launchDate, forKey: .launchDate)
        try container.encode(crewX as! Set<Crew>, forKey: .crew)
    }
    
    
}



class CrewXX: NSManagedObject, Codable {
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




extension CodingUserInfoKey {
  static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")!
}


enum DecoderConfigurationError: Error {
  case missingManagedObjectContext
}

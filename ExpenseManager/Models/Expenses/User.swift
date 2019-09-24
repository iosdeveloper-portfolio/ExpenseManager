//
//  User.swift
//  ExpenseManager
//

import Foundation

struct User: Codable {
    
	let firstName: String?
	let lastName: String?
	let email: String?

	enum CodingKeys: String, CodingKey {

		case firstName = "first"
		case lastName = "last"
		case email
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
		lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
		email = try values.decodeIfPresent(String.self, forKey: .email)
	}
    
    func fullName() -> String {
        guard let firstName = self.firstName, firstName.isValid else {
            return self.lastName ?? ""
        }
        guard let lastName = self.lastName, lastName.isValid else {
            return firstName
        }
        
        return firstName + " " + lastName
    }
    
    func initials() -> String {
        var initials = String()
        
        if let firstNameFirstChar = firstName?.first {
            initials.append(firstNameFirstChar)
        }
        
        if let lastNameFirstChar = lastName?.first {
            initials.append(lastNameFirstChar)
        }
        return initials
    }
}

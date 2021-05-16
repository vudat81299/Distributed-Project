//
//  User.swift
//  MyMapKit
//
//  Created by Vũ Quý Đạt  on 27/12/2020.
//

import Foundation

struct User: Codable { // NoSQL structure.
    let _id: String
    let idOnRDBMS: UUID
    
    let name: String
    let username: String
    
    let lastName: String?
    let bio: String?
    var profilePicture: String?
    
    let privacy: PrivacyType?
    let defaultAvartar: DefaultAvartar?
    let personalData: PrivateUserData
    
    let followings: [String]
    let boxes: [String]
    let followers: [String]
}

struct PrivateUserData: Codable {
    let email: String
    let dob: String
    let block: [String]
    let gender: Gender
    let phoneNumber: String
}



// MARK: - Enumeration.
enum PrivacyType: Int, Codable {
    case publicState, privateState
}

enum Gender: Int, Codable {
    case nonee, male, female, other
}

enum DefaultAvartar: Int, Codable {
    case nonee, engineer, pianist, male, female, other
}


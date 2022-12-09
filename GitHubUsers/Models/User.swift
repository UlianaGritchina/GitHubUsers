
import Foundation

struct User: Hashable, Codable {
    let login: String?
    let avatar_url: String?
    let html_url: String?
    let repos_url: String?
    let name: String?
    let location: String?
    let bio: String?
    let public_repos: Int?
    let followers: Int?
    let following: Int?
    let created_at: String?
    var avatarImageData: Data?
    var isPinned: Bool?
}


import Foundation

struct Repository: Decodable, Hashable {
    let name: String?
    let html_url: String?
    let stargazers_count: Int?
    let language: String?
    let visibility: String?
}

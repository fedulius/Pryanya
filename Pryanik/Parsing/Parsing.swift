import Foundation

struct Value: Decodable {
    let data: [Main]
    let view: [String]
}

struct Main: Decodable {
    let name: String
    let data: Datas
}

struct Datas: Decodable {
    let text: String?
    let url: String?
    let selectedId: Int?
    let variants: [Variants]?
}

struct Variants: Decodable {
    let id: Int
    let text: String
}

class MethodOfPars {
    static func parsing(completition: @escaping (Value) -> Void) {
        let jsonUrl = "https://pryaniky.com/static/json/sample.json"
        guard let url = URL(string: jsonUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data = data else { return }
            if err != nil { return }
            do {
                let course = try JSONDecoder().decode(Value.self, from: data)
                DispatchQueue.main.async {
                    completition(course)
                }
            } catch { print(err as Any) }
        }.resume()
    }
}

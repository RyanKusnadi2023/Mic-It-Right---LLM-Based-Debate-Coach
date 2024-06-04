import Foundation

// OpenAI Network Manager
class OpenAINetworkManager {
    static let shared = OpenAINetworkManager()
    private let apiKey = "API KEY HERE"
    private let baseURL = URL(string: "https://api.openai.com/v1/chat/completions")!

    private init() {}

    func sendSingleMessage(systemPrompt: String, userMessage: String, completion: @escaping (String?) -> Void) {
        var request = URLRequest(url: baseURL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")

        let body: [String: Any] = [
            "model": "gpt-3.5-turbo",
            "messages": [
                ["role": "system", "content": systemPrompt],
                ["role": "user", "content": userMessage]
            ]
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }

            if let result = try? JSONDecoder().decode(OpenAIResponse.self, from: data) {
                completion(result.choices.first?.message.content)
            } else {
                completion(nil)
            }
        }

        task.resume()
    }

    func sendMessagesSequentially(systemPrompt: String, userMessages: [String], completion: @escaping ([String?]) -> Void) {
        var responses = [String?]()

        func sendNextMessage(index: Int) {
            guard index < userMessages.count else {
                completion(responses)
                return
            }

            sendSingleMessage(systemPrompt: systemPrompt, userMessage: userMessages[index]) { response in
                responses.append(response)
                sendNextMessage(index: index + 1)
            }
        }

        sendNextMessage(index: 0)
    }
}

struct OpenAIResponse: Codable {
    let choices: [Choice]
}

struct Choice: Codable {
    let message: Message
}

struct Message: Codable {
    let content: String
}

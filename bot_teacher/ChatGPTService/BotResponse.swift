//
//  BotResponse.swift
//  ChatTest
//
//  Created by Federico on 20/11/2021.
//

import Foundation
import OpenAISwift

public func getGPTCompletionResponse(client: OpenAISwift, input: String, completion: @escaping (String) -> Void) {
    client.sendCompletion(with: input,model: .gpt3(.davinci), maxTokens: 100, completionHandler: { result in
        switch result {
        case .success(let model):
            let output = model.choices.first?.text ?? ""
            print("ChatGPT: \(output)")
            completion(output)
        case .failure(let error):
            let output = error.localizedDescription
            completion(output)
        }
    })

}

public func getGPTChatResponse(client: OpenAISwift, input: [ChatMessage], completion: @escaping(String) -> Void) {
    client.sendChat(with: input, model: .chat(.chatgpt)) { result in
            switch result {
            case .success(let model):
                let output = model.choices.first?.message.content ?? ""
                print("ChatGPT: \(output)")
                completion(output)
            case .failure(let error):
                let output = error.localizedDescription
                completion(output)
            }
    }
    
}

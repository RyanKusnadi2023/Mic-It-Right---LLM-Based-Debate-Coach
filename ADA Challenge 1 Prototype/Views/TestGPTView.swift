//
//  TestGPTView.swift
//  ADA Challenge 1 Prototype
//
//  Created by Ryan Kusnadi on 03/04/24.
//
import SwiftUI
// TestGPTView
struct TestGPTView: View {
    let prompts = feedbackPrompts()
    let userMessages = [
        feedbackPrompts().dummyPrompt,
        feedbackPrompts().dummySpeech,
        feedbackPrompts().gradingPromptAssertion,
        feedbackPrompts().gradingPromptReasoning,
        feedbackPrompts().gradingPromptExample,
        feedbackPrompts().gradingPromptLinkback,
        feedbackPrompts().feedbackPromptAssertion,
        feedbackPrompts().feedbackPromptReasoning,
        feedbackPrompts().feedbackPromptExample,
        feedbackPrompts().feedbackPromptLinkback
    ]
    @State private var responses = [String?]()

    var body: some View {
        

        ScrollView {
            VStack {
                Button("Analyze Speech") {
                    OpenAINetworkManager.shared.sendMessagesSequentially(systemPrompt: feedbackPrompts().systemPrompt, userMessages: userMessages) { responseArray in
                        DispatchQueue.main.async {
                            responses = responseArray
                        }
                    }
                }

                ForEach(responses.indices, id: \.self) { index in
                    if let response = responses[index] {
                        Text("Response \(index + 1): \(response)")
                            .padding()
                    }
                }
            }
        }
    }
}

// Preview
struct TestGPTView_Previews: PreviewProvider {
    static var previews: some View {
        TestGPTView()
    }
}

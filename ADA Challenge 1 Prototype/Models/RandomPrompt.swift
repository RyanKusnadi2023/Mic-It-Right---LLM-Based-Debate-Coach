//
//  RandomPrompt.swift
//  ADA Challenge 1 Prototype
//
//  Created by Rio Ikhsan on 02/04/24.
//

import Foundation

class RandomPrompt: ObservableObject {
    let randomTexts: [String:String] = ["Why we should ban homeworks":"Homeworks are all forms of tasks that students have to do at home. Banning in this case means prohibiting teachers from giving homeworks, and punishing those who still does so.", " Why we should ban the use of unethically obtained data in scientific research":"Unethically obtained data are data that are gathered through unethical means (i.e Nazi inhumane researches) or are gathered without proper scientific ethical clearance.", "Why anonymity have produced more harm than good in social media":"Anonimity means the ability to stay hidden/incognito in the digital sphere.", "Why we should oppose data driven policing":"Data driven policing is the integration of datascience and analytics technique in law enforecement.", "Why we should support the decline of nationalism":"Nationalism is the feeling of loyalty and devotion to the nation.", "Why we should legalize recreational drugs":"Recreational drugs are narcotics that has halucinogenic or neuroactive effects that are still considered mild in long term impact (i.e marijuana, cocaine). To make it legal means that the government will decriminalize its sales and consumption, as well as regulate its distribution and production."]
    
    @Published var prompt: String = ""
    @Published var contextSlide: String = ""
    
    init() {
        updateRandomText()
    }
    
    func updateRandomText() {
        let dictionaryKeys = Array(randomTexts.keys)
        let randomIndex = Int.random(in: 0..<randomTexts.keys.count)
        prompt = dictionaryKeys[randomIndex]
        contextSlide = randomTexts[prompt]!
    }
}

//
//  ContentView.swift
//  loadingPage
//
//  Created by Rangga Yudhistira Brata on 02/04/24.
//

import SwiftUI
import Lottie

struct LoadingView: View {
    @State private var isAnimating = false
    @State var loadingDone = false
    @State var text = ""
    @State var userPrompt: String
    @State var systemPrompt = ""
    
    let userMessages = [
        Prompts().restructurePrompt,
        Prompts().feedbackAssertion,
        Prompts().feedbackReasoning,
        Prompts().feedbackExample,
        Prompts().feedbackLinkback,
        Prompts().gradeSpeech
    ]
    
    @State private var responses = [String?]()
    
    
    let audioRecorder: AudioRecorder
    
    var body: some View {
        ZStack {
            Color(hex: 0x3D5EAB).ignoresSafeArea()
            
            VStack {
                LottieView(animation: .named("StarAnimation.json"))
                    .playbackMode(.playing(.toProgress(1, loopMode: .loop)))
                    .padding()
                
                // Text dengan efek animasi
                AnimatedText(text: "Processing your speech...", isAnimating: $isAnimating)
                    .font(Font.custom("SF Pro", size: 17).weight(.semibold))
                    .foregroundColor(.white)
                    .onAppear {
                        withAnimation(Animation.easeInOut(duration: 1.0).repeatForever()) {
                            isAnimating.toggle()
                        }
                    }
            }.onAppear(perform: {
                //add logic yang diproses selama loading disini
                
                systemPrompt = Prompts().systemPromptPlain + "\n" + "The prompt that the user defends in this practice is" + Prompts().dummyPrompt + "\n" + "The transcript of the user's speech is as follows:" + Prompts().dummySpeech
                
                //systemPrompt = Prompts().systemPromptPlain + "\n" + "The prompt that the user defends in this practice is" + userPrompt + "\n" + "The transcript of the user's speech is as follows:" + text
                
                //transcribe speech and save to text
                audioRecorder.transcribeAudio { transcript in
                    DispatchQueue.main.async {
                        text = transcript
                    }
                }
                
                //call GPT api
                OpenAINetworkManager.shared.sendMessagesSequentially(systemPrompt: systemPrompt, userMessages: userMessages) { responseArray in
                    DispatchQueue.main.async {
                        responses = responseArray
                    }
                }
                
                
                
            })
            if responses.count == userMessages.count {
                FeedbackView(speechText: responses[0] ?? "",
                             recScore: responses[5] ?? "",
                             asertionFeedback: responses[1] ?? "",
                             reasoningFeedback: responses[2] ?? "",
                             exampleFeedback: responses[3] ?? "",
                             linkingFeedback: responses[4] ?? "")
            }
        }
    }
}

struct AnimatedText: View {
    let text: String
    @Binding var isAnimating: Bool
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(Array(text.enumerated()), id: \.offset) { index, character in
                Text(String(character))
                    .opacity(isAnimating ? 1.0 : 0.0)
                    
            }
        }
    }
}





extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}

struct Prompts{
    let systemPromptPlain = """
        You will act as a debate coach that gets a transcript of a user's speech. The speech contains an argument that defends a prompt. A prompt is an imperative sentence that asks the user to make an argument in favor of something. For instance, a prompt can be "Make an argument to ban zoos". You will be asked to do several things, just follow the instruction and act as a coach. Keep explanations simple, concise, and to the point.
"""
    let restructurePrompt = """
        Restructure the transcription of an argumentative speech that you receive into 4 parts.

        First part is the Assertion (the title of the argument), Second part is the Reasoning (the logical proofs of the argument), Third part is the Example (references to real world examples that supports the reasoning), and the fourth is Linkback (tying up the reasoning and concluding the argument).

        Make a tidy output text that looks like this

        Assertion: ...
        (new line)
        Reasoning: ... (can be several, so number it up)
        (new line)
        Example: ... (can be several, so number it up, IF the reasoning is tied to one of the reasons - then make it a Reasoning+Example: ...)
        (new line)
        Linkback: ...

"""
    let feedbackAssertion = """
        Assertion is the main proposition or the main idea of the arguments. Ideally, it should be specific, clear, represents the whole argument well, and most importantly be inline with the supposed stance that is assigned to a speaker. A good reasoning should be clear and specific. It should give the listener a clear idea of the direction of the overall argument and the end goal that the speaker wants to convey.

        For instance: in the prompt “make an argument why homework should be banned” - a good assertion that specific, clear, and represents the argument well can look like “banning homework will help students by giving them a room to breathe and explore non-academic endeavors ”. Assertion should not be general like “this will help students” or “this will improve the education system. Assertion should always be placed before reasoning and other parts of argument.

        Given this information, make a concise 2 sentence feedback for the user's assertion that should contain what to fix and how to fix it.

"""
    let feedbackReasoning = """
        Reasoning is the part where a speaker logically proves the claim (in the assertion). The reasoning should contain step by step analysis that convinces the judge that the assertion is true. Reasoning should answer the logical questions that an average reasonable person asks when they evaluate the logical truth value of the argument. A good reasoning should be strong, layered (have a plethora of linearly independent but complementary reasonings), comparative (aware of how prompt changes status quo or is different with other alternatives), and relevant. An example IS NOT A SUBSTITUTE for logical reasoning.

        For instance: A good reason to ban homeworks is that - one, it makes students have less time at home to have fun like bond with their families or do their hobbies - which are important for student’s personal development. two, it makes teachers lazy in classroom teaching because they can just delegate a lot of their learning process to the students and parents in the form of “afterschool learning”. This reasoning is simple enough to be understood by the average reasonable person, but is logically coherent enough to convince them as well. Furthermore the reasoning has a logical flow that is step by step and layered.

        Reasonings like “we should ban homework because it makes students tired” or “homeworks are often ineffective” might work as well, what you have to grade is not the direction of the case, rather the extent of logical proofs provided.
        
        Given this information, make a concise 3-5 sentence feedback for the user's reasoning that should contain what to fix and how to fix it.

"""
    let feedbackExample = """
        Example is the part where speakers use real world cases as a complementary substantive to support their logical reasoning. A good example is ones that are relevant in supporting the reasoning, and ones that make the argument more intuitive and compelling for an average reasonable person. A good example should be explained in depth, as if the speaker is telling a story to a stranger.

        Given this information, make a concise 2 sentence feedback for the user's examples that should contain what to fix and how to fix it.

"""
    let feedbackLinkback = """
       Link back is the part where speakers tie their reasoning to the assertion and prompt. A good linkback concludes the argument in a way that convinces an average reasonable person that the logical analysis provided in the reasoning has answered the burden of proof of the prompt.

       For instance: a good linkback for the previous prompt and reasoning would be - “the government and education system bans things that are counterproductive for learning like toys and irrelevant gadgets in school. Hence, by the same principle, homework should be banned as well since it interferes negatively with student’s learning processes”. Link backs are not repetition of prompt and argument, it should tie the reasoning and assertion together - and convince an average reasonable person that it proves the prompt.
      
    Given this information, make a concise 2-3 sentence feedback for the user's linkback that should contain what to fix and how to fix it.
"""
    let gradeSpeech = """
        Based on the user's speech, give the user a grade (C, B, or A) based on the strength and clarity of the argument. ONLY OUTPUT ONE WORD, THE GRADE (A,B, or C), NOTHING ELSE.

"""
    let dummyPrompt = "Make an argument to support the legalization of recreational drug"
    
    let dummySpeech = """

The legalization of recreational drugs will mitigate the overall harm of drug abuse by providing people with safer alternatives and important information in which they need. I think the reason is simple. Whether or not you criminalize the consumption of drugs, people will consume it regardless. Perhaps it's for a coping mechanism, escapism, peer pressure, or trauma response, and therefore we posit that they will consume it regardless. So as the government, your main obligation is to legalize that, to make it better in tricky ways. The first is that people will not have to buy drugs from gangs that often do not have proper quality control in comparison to the big pharma, for instance. They now can buy from the government or authorized drug dealers, which means that the quality of drugs, its addictive and neuroactive chemical doses, and the processing chemical residue that oftentimes causes a lot of health issues associated with the consumption of drugs will be regulated and supervised by an accountable body. Secondly, I think people will not buy dangerous drugs like fentanyl. I think the reason why people buy fentanyl in status quo is because safer drugs like cocaine or marijuana are expensive due to the cartel's extortive incentive, and therefore, as a comparative, when the government and big pharma produce marijuana at scale, they will be able to be sold at a cheap price, hence providing people with safer alternatives than a drug that will literally kill them. Thirdly, I think that things like overdose or long-term health impact due to drug addiction often occurs due to people's lack of understanding regarding the good or safer drug consumption practice. I think legalization means that the government will also provide people who want to buy drugs things like consultation or more oversight in the process of the consumption. I think these policies have worked. For instance, in Portugal, once the heroin capital of Europe now has been rehabilitated and significantly reduced the number of drug-related deaths in that nation, we're providing people in need, people who are addicted with legal heroin, which are cheap and safe in comparison to the alternative, which comes as well with medical supervision and guidance on how to consume it safely. I think doing that is done since the legalization of recreational drugs reduces the net negative impact of drug abuse, and it is the obligation of the government to protect their people. Within that, as an extension to that, the government should legalize recreational drugs.

"""
    
}

#Preview {
    LoadingView(userPrompt: "", audioRecorder: AudioRecorder())
}

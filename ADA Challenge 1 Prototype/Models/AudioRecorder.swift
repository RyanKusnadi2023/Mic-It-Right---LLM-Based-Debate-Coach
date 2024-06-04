import AVFoundation
import Foundation

class AudioRecorder: ObservableObject {
    var audioRecorder: AVAudioRecorder?
    var audioPlayer: AVAudioPlayer?
    @Published var isRecording = false
    @Published var hasRecording = false
    @Published var audioLevel: Float = 0.0
    @Published var speechTranscript: String = "Transcription Error"
    
    func setupAudioSession() {
        
        //TAMBAHIN PERMISSION HANDLING/CONSENT!!!!
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default)
            try audioSession.setActive(true)
        } catch {
            print("Failed to set up audio session: \(error)")
        }
    }
    
    func startRecording(){
        let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.wav")
        
        let settings: [String: Any] = [
            AVFormatIDKey: Int(kAudioFormatLinearPCM),
            AVSampleRateKey: 44100,
            AVNumberOfChannelsKey: 1,
            AVLinearPCMBitDepthKey: 16,
            AVLinearPCMIsBigEndianKey: false,
            AVLinearPCMIsFloatKey: false,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder?.record()
            isRecording = true
            hasRecording = false
        } catch {
            print("Failed to start recording: \(error)")
        }
    }
    
    func stopRecording() {
        audioRecorder?.stop()
        isRecording = false
        hasRecording = true
    }
    
    func playRecording() {
        let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.wav")
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioFilename)
            audioPlayer?.play()
        } catch {
            print("Failed to play recording: \(error)")
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func transcribeAudio(completion: @escaping (String) -> Void) {
        let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.wav")
        let apiUrl = "https://api.openai.com/v1/audio/transcriptions"
        
        var request = URLRequest(url: URL(string: apiUrl)!)
        request.httpMethod = "POST"
        request.setValue("Bearer API KEY HERE", forHTTPHeaderField: "Authorization")
        
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var body = Data()
        
        // Add the audio file
        let audioData = try? Data(contentsOf: audioFilename)
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"file\"; filename=\"recording.wav\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: audio/wav\r\n\r\n".data(using: .utf8)!)
        body.append(audioData ?? Data())
        body.append("\r\n".data(using: .utf8)!)
        
        // Add the model name
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"model\"\r\n\r\n".data(using: .utf8)!)
        body.append("whisper-1\r\n".data(using: .utf8)!)
        
        
        // Add the language
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"language\"\r\n\r\n".data(using: .utf8)!)
        body.append("en\r\n".data(using: .utf8)!)  
        
        // End of the body
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        request.httpBody = body
        
        // Make the API request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Error in API request: \(error?.localizedDescription ?? "Unknown error")")
                completion("Transcription Error")
                return
            }
            
            // Print the raw JSON response for debugging
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Raw JSON response: \(jsonString)")
            }
            
            do {
                // Parse the JSON response to extract the transcription
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let transcript = json["text"] as? String {
                    completion(transcript)
                } else {
                    print("Failed to parse JSON response")
                    completion("Transcription Error - Parsing Fail")
                }
            } catch {
                print("Error parsing JSON: \(error)")
                completion("Transcription Error - Parsing Fail")
            }
        }
        task.resume()
    }

    
}

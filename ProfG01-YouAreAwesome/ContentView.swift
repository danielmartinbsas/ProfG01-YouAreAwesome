import SwiftUI
import AVFAudio

struct ContentView: View {
    @State private var message: String = ""
    @State private var imageName: String = ""
    @State private var soundName: String = ""
    @State private var lastMessageNumber: Int = -1
    @State private var lastImageNumber: Int = -1
    @State private var lastSoundNumber: Int = -1
    @State private var audioPlayer: AVAudioPlayer!
    
    let numberOfImages = 9
    
    var body: some View {
        VStack {
            Text(message)
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundStyle(.red)
                .multilineTextAlignment(.center)
                .minimumScaleFactor(0.5)
                .frame(height: 100)
            
            Spacer()
            
            Image(imageName)
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .shadow(radius: 30)
                .animation(.default, value: imageName)
                        
            Spacer()
            
            Button("Click me!") {
                let messages = [
                    "You are Great",
                    "You are Awesome",
                    "You are Perfect",
                    "You are Amazing",
                    "You are the Coolest"
                ]
                
                var messageNumber: Int
                repeat {
                    messageNumber = Int.random(in: 0...messages.count-1)
                } while messageNumber == lastMessageNumber
                message = messages[messageNumber]
                lastMessageNumber = messageNumber
                
                var imageNumber: Int
                repeat {
                    imageNumber = Int.random(in: 0...numberOfImages)
                } while imageNumber == lastImageNumber
                imageName = "image\(imageNumber)"
                lastImageNumber = imageNumber
                
                var soundNumber: Int
                repeat {
                    soundNumber = Int.random(in: 0...5)
                } while soundNumber == lastSoundNumber
                soundName = "sound\(soundNumber)"
                lastSoundNumber = soundNumber
                
                guard let soundFile = NSDataAsset(name: soundName) else {
                    print("😡 Could nor read \(soundName)")
                    return
                }
                
                do {
                    audioPlayer = try AVAudioPlayer(data: soundFile.data)
                    audioPlayer.play()
                } catch {
                    print("😡 ERROR: \(error.localizedDescription)")
                }
            }
            .buttonStyle(.borderedProminent)
            .font(.title2)
            .tint(.orange)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

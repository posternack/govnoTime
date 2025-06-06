import UIKit
import Foundation
import AVFoundation

class ViewwController: UIViewController {
    
    let eggTimes = ["Soft": 5, "Medium": 420, "Hard": 720]
    var timer = Timer()
    var timeLeft: Int = 0
    var totalTime: Float = 0
    var player: AVAudioPlayer!
    @IBOutlet weak var label: UILabel!
    
    func playSound(soundName: String) {
        if let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") {
            do {
                player = try AVAudioPlayer(contentsOf: url)
                player.play()
            } catch {
                print("Ошибка при воспроизведении звука: \(error.localizedDescription)")
            }
        } else {
            print("Файл звука не найден.")
        }
    }

    
    @IBOutlet weak var progress: UIProgressView!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        progress.progress = 0.0
        timer.invalidate()
        
        guard let title = sender.currentTitle else{
            print("нету")
            return
        }
        guard let time = eggTimes[title] else{
            print("кнопка без текста")
            return
        }
        totalTime = Float(time)
        timeLeft = time
        
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0,repeats: true){ timer in
            self.label.text = "How do you like your eggs?"
            let sum = self.timeLeft - 1
            self.timeLeft = sum
            let chisla = (self.totalTime - Float(self.timeLeft)) / self.totalTime

            
            if sum <= 0{
                timer.invalidate()
                self.label.text = "Done!"
                self.playSound(soundName: "alarm_sound")
                self.progress.progress = 1
                
                
            } else {
                print("\(sum)")
                self.progress.progress = chisla
                
            }
        }
    }
}

                    

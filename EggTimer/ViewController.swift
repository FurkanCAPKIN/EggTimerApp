
import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    /*
     Main Tasarımı hakkındaki notlarım:
     1-)İçinde "How do you like your eggs?" yazan label küçük ekranlarda kaybolmaması
     için 1. yol : lines=0 yapıyoruz böylece yazının tamamı küçük ekranda da okunabilecek.
     2. yol : Autoshrink -> minimum font size=15 yazpıyoruz böylece metin çoğalsa bile font
     küçülür ve kullanıcı bütün yazıyı görebilir.
     */
    
    /*let softTime=5
    let mediumTime=7
    let hardTime=12
    //yumurtaların sertlik ayarına göre zamanlarını tanımladım.
    */
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    var player:AVAudioPlayer!
    
    
    let eggTimes = ["Soft":3,"Medium":5,"Hard":7]
    //bir dictionary oluşturdum ve key-value eşleşmesi ile artık zamanlara daha rahat erişelebilecek.
    
    var totalTime=0
    var  secondsPassed=0
    
    var timer = Timer()
    //Timer sınıfından bir nesne oluşturdum
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressBar.progress=0.0
        /*viewDidLoad fonksiyonu görünüm belleğe yükledikten sonra çalışır bu sayede burada yapılan
          
        */
    }
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        //3 butonuda buraya bağladım
        
        //progressBar.progress = 1.0
        //bar, düğmeler bastiğimizda full gözükecek.
        
        timer.invalidate()
        //timer'ı durdurur iptal eder.
        
        //print(sender.currentTitle)
        //3 butondan hangisine tıklarsak onun başlığını yazar.
        let hardness = sender.currentTitle!
        
        totalTime = eggTimes[hardness]!
        progressBar.progress = 0.0
        secondsPassed=0
        titleLabel.text = hardness
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        /*zamanlayıcı kodu. timeInterval->kaç saniyede çalışması gerektiğini söyküyor.
         selector->buradaki metod zamanlayıcı kodu her çalıştığında çalışacak ve @objc olmalı.
         */
        
    }
    
    
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            progressBar.progress = Float(secondsPassed) / Float(totalTime)
            print(Float(secondsPassed) / Float(totalTime))
        } else {
            timer.invalidate()
            titleLabel.text = "DONE!!!"
            
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
        }
    }
    

    
    
}

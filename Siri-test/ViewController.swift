//
//  ViewController.swift
//  Siri-test
//
//  Created by oahgnehzoul on 2016/11/2.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

import UIKit
import Speech

class ViewController: UIViewController, SFSpeechRecognizerDelegate {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var microPhoneButton: UIButton!
    
    // 声明 speechRecognizer 变量,
    //en-US  英文
    
    /*
     
     //        NSLocale.isoCountryCodes
     //        print("\(NSLocale.isoCountryCodes)")
     //["AC", "AD", "AE", "AF", "AG", "AI", "AL", "AM", "AO", "AQ", "AR", "AS", "AT", "AU", "AW", "AX", "AZ", "BA", "BB", "BD", "BE", "BF", "BG", "BH", "BI", "BJ", "BL", "BM", "BN", "BO", "BQ", "BR", "BS", "BT", "BV", "BW", "BY", "BZ", "CA", "CC", "CD", "CF", "CG", "CH", "CI", "CK", "CL", "CM", "CN", "CO", "CP", "CR", "CU", "CV", "CW", "CX", "CY", "CZ", "DE", "DG", "DJ", "DK", "DM", "DO", "DZ", "EA", "EC", "EE", "EG", "EH", "ER", "ES", "ET", "FI", "FJ", "FK", "FM", "FO", "FR", "GA", "GB", "GD", "GE", "GF", "GG", "GH", "GI", "GL", "GM", "GN", "GP", "GQ", "GR", "GS", "GT", "GU", "GW", "GY", "HK", "HM", "HN", "HR", "HT", "HU", "IC", "ID", "IE", "IL", "IM", "IN", "IO", "IQ", "IR", "IS", "IT", "JE", "JM", "JO", "JP", "KE", "KG", "KH", "KI", "KM", "KN", "KP", "KR", "KW", "KY", "KZ", "LA", "LB", "LC", "LI", "LK", "LR", "LS", "LT", "LU", "LV", "LY", "MA", "MC", "MD", "ME", "MF", "MG", "MH", "MK", "ML", "MM", "MN", "MO", "MP", "MQ", "MR", "MS", "MT", "MU", "MV", "MW", "MX", "MY", "MZ", "NA", "NC", "NE", "NF", "NG", "NI", "NL", "NO", "NP", "NR", "NU", "NZ", "OM", "PA", "PE", "PF", "PG", "PH", "PK", "PL", "PM", "PN", "PR", "PS", "PT", "PW", "PY", "QA", "RE", "RO", "RS", "RU", "RW", "SA", "SB", "SC", "SD", "SE", "SG", "SH", "SI", "SJ", "SK", "SL", "SM", "SN", "SO", "SR", "SS", "ST", "SV", "SX", "SY", "SZ", "TA", "TC", "TD", "TF", "TG", "TH", "TJ", "TK", "TL", "TM", "TN", "TO", "TR", "TT", "TV", "TW", "TZ", "UA", "UG", "UM", "US", "UY", "UZ", "VA", "VC", "VE", "VG", "VI", "VN", "VU", "WF", "WS", "XK", "YE", "YT", "ZA", "ZM", "ZW"]
     
     //        print("\(NSLocale.isoLanguageCodes)")
     //["aa", "ab", "ace", "ach", "ada", "ady", "ae", "aeb", "af", "afh", "agq", "ain", "ak", "akk", "akz", "ale", "aln", "alt", "am", "an", "ang", "anp", "ar", "arc", "arn", "aro", "arp", "arq", "ars", "arw", "ary", "arz", "as", "asa", "ase", "ast", "av", "avk", "awa", "ay", "az", "ba", "bal", "ban", "bar", "bas", "bax", "bbc", "bbj", "be", "bej", "bem", "bew", "bez", "bfd", "bfq", "bg", "bgn", "bho", "bi", "bik", "bin", "bjn", "bkm", "bla", "bm", "bn", "bo", "bpy", "bqi", "br", "bra", "brh", "brx", "bs", "bss", "bua", "bug", "bum", "byn", "byv", "ca", "cad", "car", "cay", "cch", "ce", "ceb", "cgg", "ch", "chb", "chg", "chk", "chm", "chn", "cho", "chp", "chr", "chy", "ckb", "co", "cop", "cps", "cr", "crh", "cs", "csb", "cu", "cv", "cy", "da", "dak", "dar", "dav", "de", "del", "den", "dgr", "din", "dje", "doi", "dsb", "dtp", "dua", "dum", "dv", "dyo", "dyu", "dz", "dzg", "ebu", "ee", "efi", "egl", "egy", "eka", "el", "elx", "en", "enm", "eo", "es", "esu", "et", "eu", "ewo", "ext", "fa", "fan", "fat", "ff", "fi", "fil", "fit", "fj", "fo", "fon", "fr", "frc", "frm", "fro", "frp", "frr", "frs", "fur", "fy", "ga", "gaa", "gag", "gan", "gay", "gba", "gbz", "gd", "gez", "gil", "gl", "glk", "gmh", "gn", "goh", "gom", "gon", "gor", "got", "grb", "grc", "gsw", "gu", "guc", "gur", "guz", "gv", "gwi", "ha", "hai", "hak", "haw", "he", "hi", "hif", "hil", "hit", "hmn", "ho", "hr", "hsb", "hsn", "ht", "hu", "hup", "hy", "hz", "ia", "iba", "ibb", "id", "ie", "ig", "ii", "ik", "ilo", "inh", "io", "is", "it", "iu", "izh", "ja", "jam", "jbo", "jgo", "jmc", "jpr", "jrb", "jut", "jv", "ka", "kaa", "kab", "kac", "kaj", "kam", "kaw", "kbd", "kbl", "kcg", "kde", "kea", "ken", "kfo", "kg", "kgp", "kha", "kho", "khq", "khw", "ki", "kiu", "kj", "kk", "kkj", "kl", "kln", "km", "kmb", "kn", "ko", "koi", "kok", "kos", "kpe", "kr", "krc", "kri", "krj", "krl", "kru", "ks", "ksb", "ksf", "ksh", "ku", "kum", "kut", "kv", "kw", "ky", "la", "lad", "lag", "lah", "lam", "lb", "lez", "lfn", "lg", "li", "lij", "liv", "lkt", "lmo", "ln", "lo", "lol", "loz", "lrc", "lt", "ltg", "lu", "lua", "lui", "lun", "luo", "lus", "luy", "lv", "lzh", "lzz", "mad", "maf", "mag", "mai", "mak", "man", "mas", "mde", "mdf", "mdh", "mdr", "men", "mer", "mfe", "mg", "mga", "mgh", "mgo", "mh", "mi", "mic", "min", "mis", "mk", "ml", "mn", "mnc", "mni", "moh", "mos", "mr", "mrj", "ms", "mt", "mua", "mul", "mus", "mwl", "mwr", "mwv", "my", "mye", "myv", "mzn", "na", "nan", "nap", "naq", "nb", "nd", "nds", "ne", "new", "ng", "nia", "niu", "njo", "nl", "nmg", "nn", "nnh", "no", "nog", "non", "nov", "nqo", "nr", "nso", "nus", "nv", "nwc", "ny", "nym", "nyn", "nyo", "nzi", "oc", "oj", "om", "or", "os", "osa", "ota", "pa", "pag", "pal", "pam", "pap", "pau", "pcd", "pdc", "pdt", "peo", "pfl", "phn", "pi", "pl", "pms", "pnt", "pon", "prg", "pro", "ps", "pt", "qu", "quc", "qug", "raj", "rap", "rar", "rgn", "rif", "rm", "rn", "ro", "rof", "rom", "rtm", "ru", "rue", "rug", "rup", "rw", "rwk", "sa", "sad", "sah", "sam", "saq", "sas", "sat", "saz", "sba", "sbp", "sc", "scn", "sco", "sd", "sdc", "sdh", "se", "see", "seh", "sei", "sel", "ses", "sg", "sga", "sgs", "shi", "shn", "shu", "si", "sid", "sk", "sl", "sli", "sly", "sm", "sma", "smj", "smn", "sms", "sn", "snk", "so", "sog", "sq", "sr", "srn", "srr", "ss", "ssy", "st", "stq", "su", "suk", "sus", "sux", "sv", "sw", "swb", "swc", "syc", "syr", "szl", "ta", "tcy", "te", "tem", "teo", "ter", "tet", "tg", "th", "ti", "tig", "tiv", "tk", "tkl", "tkr", "tl", "tlh", "tli", "tly", "tmh", "tn", "to", "tog", "tpi", "tr", "tru", "trv", "ts", "tsd", "tsi", "tt", "ttt", "tum", "tvl", "tw", "twq", "ty", "tyv", "tzm", "udm", "ug", "uga", "uk", "umb", "und", "ur", "uz", "vai", "ve", "vec", "vep", "vi", "vls", "vmf", "vo", "vot", "vro", "vun", "wa", "wae", "wal", "war", "was", "wbp", "wo", "wuu", "xal", "xh", "xmf", "xog", "yao", "yap", "yav", "ybb", "yi", "yo", "yrl", "yue", "za", "zap", "zbl", "zea", "zen", "zgh", "zh", "zu", "zun", "zxx", "zza"]
     
     
     */
    
    // languageCode-countryCode
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "zh-CN"))
    
    //给语音识别提供语音输入
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    //语音识别结果
    private var recognitionTask: SFSpeechRecognitionTask?
    //语音引擎，负责用户语音输入
    private let audioEngine = AVAudioEngine()
    
    // 开启语音识别然后聆听麦克风
    func startRecording() {
        // 检测 recognitionTask 是否在运行
        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        // 创建一个 AVAudioSession 来记录语音，类别为 recording,模式为 measurement,然后激活，因为属性可能异常，放入 try catch
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryRecord)
            try audioSession.setMode(AVAudioSessionModeMeasurement)
            try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
        } catch  {
            print("audioSession properties weren't set because of an error")
        }
        
        //实例化 recognitionRequest,把语音数据传到苹果后台
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        //检测 audioEngine(设备)是否有做录音功能作为语音输入
        guard let inputNode = audioEngine.inputNode else { fatalError("Audio engine has no input node") }
        //检测 recognitionRequest 对象是否被实例化和不是 nil
        guard let recognitionRequest = recognitionRequest else { fatalError("Unable to create an SFSpeechAudioBufferRecognitionReques object") }
        //用户说话的时候让recognitionRequest 报告语音识别的部分结果
        recognitionRequest.shouldReportPartialResults = true
        //调用来开启语音识别,
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
            var isFinal = false
            //如果结果 result 不是nil, 把 textView.text 的值设置为我们的最优文本。如果结果是最终结果，设置 isFinal为true。
            if result != nil {
                self.textView.text = result?.bestTranscription.formattedString
                isFinal = (result?.isFinal)!
            }
            //如果没有错误或者结果是最终结果，停止 audioEngine(语音输入)并且停止 recognitionRequest 和 recognitionTask.同时，使Start Recording按钮有效
            if error != nil || isFinal {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                self.recognitionRequest = nil
                self.recognitionTask = nil
                self.microPhoneButton.isEnabled = true
            }
        })
        //向 recognitionRequest增加一个语音输入。注意在开始了recognitionTask之后增加语音输入是OK的。Speech Framework 会在语音输入被加入的同时就开始进行解析识别
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat, block: {
            (buffer, when) in
            self.recognitionRequest?.append(buffer)
        })
        //准备并且开始audioEngine
        audioEngine.prepare()
        
        do {
            try audioEngine.start()
        } catch  {
            print("audioEngine couldn't start because of an error")
        }
        
        textView.text = "Say something, I'm listening"
    }
    
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            microPhoneButton.isEnabled = true
        } else {
            microPhoneButton.isEnabled = false
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        
        microPhoneButton.isEnabled = false
        speechRecognizer?.delegate = self
        
        // 授权语音识别
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            var isButtonEnabled = false
            switch authStatus {
            case .authorized:
                isButtonEnabled = true
            case .denied:
                isButtonEnabled = false
                print("User denied access to speech recognition")
            case .restricted:
                isButtonEnabled = false
                print("Speech recognition restricted on this device")
            case .notDetermined:
                isButtonEnabled = false
                print("Speech recognition not yet authorized")
            }
            
            OperationQueue.main.addOperation {
                self.microPhoneButton.isEnabled = isButtonEnabled
            }
        }
        
    }
    
    
    
    

    @IBAction func microPhoneTapped(_ sender: Any) {
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
            microPhoneButton.isEnabled = false
            microPhoneButton.setTitle("Start Recording", for: .normal)
        } else {
            startRecording()
            microPhoneButton.setTitle("Stop Recording", for: .normal)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


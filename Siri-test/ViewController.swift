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
    
    // 声明 speechRecognizer 变量
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "en-US"))
    
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


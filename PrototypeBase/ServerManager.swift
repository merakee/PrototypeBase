//
//  ServerList.swift
//  PrototypeBase
//
//  Created by Bijit on 11/24/15.
//  Copyright © 2015 Bijit Halder. All rights reserved.
//

import UIKit

class ServerManager {
    enum ServerType: Int8{
        case ChineseBaidu
        case ChineseMVP
        case ChineseBaiduUS
        case ChineseAmazon
        case EnglishAmazon
        case ChineseDebug
    }
    
    //    class let serverList:Array  = [["name":"Chinese: deepspeech.baidu.com",
    //        "endpoint":"http://deepspeech.baidu.com/SpeechFrontEnd/Transcribe",
    //        "type":0,
    //        "language":"zh_CN"],
    //        ["name":"Chinese: MVP",
    //            "endpoint":"http://104.254.65.131/SpeechFrontEnd/Transcribe",
    //            "type":0,
    //            "language":"zh_CN",
    //            "encodingSupport":1],
    //        ["name":"Chinese: us.deepspeech.baidu.com",
    //            "endpoint":"http://us.deepspeech.baidu.com/SpeechFrontEnd/Transcribe",
    //            "type":0,
    //            "language":"zh_CN"],
    //        ["name":"Chinese: Amazon server",
    //            "endpoint":"https://api.spchrsrch.com/v1/transcribe/chinese",
    //            "type":1,
    //            "language":"zh_CN"],
    //        ["name":"English: Amazon server",
    //            "endpoint":"https://api.spchrsrch.com/v1/transcribe/english",
    //            "type":1,
    //            "language":"en_US"],
    //        ["name":"Chinese: for debug",
    //            "endpoint":"http://172.19.51.0:8001/SpeechFrontEnd/Transcribe",
    //            "type": 0,
    //            "language":"zh_CN"]]
    
    class func getServer(type:ServerType = .EnglishAmazon) -> AnyObject{
        switch type{
        case .ChineseBaidu:
            return ["name":"Chinese: deepspeech.baidu.com",
                "endpoint":"http://deepspeech.baidu.com/SpeechFrontEnd/Transcribe",
                "type":0,
                "language":"zh_CN"]
        case .ChineseMVP:
            return ["name":"Chinese: MVP",
                "endpoint":"http://104.254.65.131/SpeechFrontEnd/Transcribe",
                "type":0,
                "language":"zh_CN",
                "encodingSupport":1]
        case .ChineseBaiduUS:
            return ["name":"Chinese: us.deepspeech.baidu.com",
                "endpoint":"http://us.deepspeech.baidu.com/SpeechFrontEnd/Transcribe",
                "type":0,
                "language":"zh_CN"]
        case .ChineseAmazon:
            return ["name":"Chinese: Amazon server",
                "endpoint":"https://api.spchrsrch.com/v1/transcribe/chinese",
                "type":1,
                "language":"zh_CN"]
        case .EnglishAmazon:
            return ["name":"English: Amazon server",
                "endpoint":"https://api.spchrsrch.com/v1/transcribe/english",
                "type":1,
                "language":"en_US"]
        case .ChineseDebug:
            return ["name":"Chinese: for debug",
                "endpoint":"http://172.19.51.0:8001/SpeechFrontEnd/Transcribe",
                "type": 0,
                "language":"zh_CN"]
        }
    }
}

//
//  ApiAiManager.swift
//  PrototypeBase
//
//  Created by Bijit on 12/18/15.
//  Copyright © 2015 Bijit Halder. All rights reserved.
//

import UIKit
//import SwiftyJSON

class ContentManager: NSObject {
    enum ContentType{
        case Poem,
        Joke,
        News,
        Story,
        Song
    }
    
    let poems = ["When You Are Old " +
        "by William Butler Yeats " +
        "When you are old and grey and full of sleep, " +
        "And nodding by the fire, take down this book, " +
        "And slowly read, and dream of the soft look " +
        "Your eyes had once, and of their shadows deep; " +
        "How many loved your moments of glad grace, " +
        "And loved your beauty with love false or true, " +
        "But one man loved the pilgrim soul in you, " +
        "And loved the sorrows of your changing face; " +
        "And bending down beside the glowing bars, " +
        "Murmur, a little sadly, how Love fled " +
        "And paced upon the mountains overhead " +
        "And hid his face amid a crowd of stars. ",
        "The Wild Swans at Coole " +
            "by William Butler Yeats " +
            "The trees are in their autumn beauty, " +
            "The woodland paths are dry, " +
            "Under the October twilight the water " +
            "Mirrors a still sky; " +
            "Upon the brimming water among the stones " +
            "Are nine and fifty swans. " +
            "The nineteenth Autumn has come upon me " +
            "Since I first made my count; " +
            "I saw, before I had well finished, " +
            "All suddenly mount " +
            "And scatter wheeling in great broken rings " +
            "Upon their clamorous wings. " +
            "I have looked upon those brilliant creatures, " +
            "And now my heart is sore. " +
            "All’s changed since I, hearing at twilight, " +
            "The first time on this shore, " +
            "The bell-beat of their wings above my head, " +
        "Trod with a lighter tread. "
    ]
    
    var currentContent: String?
    
    let songs = ["Sorry there I do not have any songs yet."]
    let jokes = ["Sorry there I do not have any jokes yet."]
    let stories = ["Sorry there I do not have any stories yet."]
    let news = ["Sorry there I do not have any news yet."]
    
    // MARK: - singleton
    static let sharedManager = ContentManager()
    
    private override init() {
        super.init()
        self.setupManager()
    }
    
    func setupManager() {
    }
    
    func getContentOfType(type:ContentType) -> String? {
        switch type{
        case .Poem:
            self.currentContent =  self.pickRandomFromArray(self.poems)
        case .Joke:
            self.currentContent = self.pickRandomFromArray(self.jokes)
        case .Song:
            self.currentContent = self.pickRandomFromArray(self.songs)
        case .Story:
            self.currentContent = self.pickRandomFromArray(self.stories)
        case .News:
            self.currentContent = self.pickRandomFromArray(self.news)
        }
        return self.currentContent
    }
    
    func pickRandomFromArray(array: [String]) -> String{
        return array[CommonUtils.sharedInstance.pickRandom(array.count)]
    }
}

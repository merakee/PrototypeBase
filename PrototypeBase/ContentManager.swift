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
    let jokes = ["The most important property of a program is whether it accomplishes the intention of its user.",
    "The question of whether a computer can think is no more interesting than the question of whether a submarine can swim.",
    "if you aren't, at any given time, scandalized by code you wrote five or even three years ago, you're not learning anywhere near enough",
        "There are 2 hard problems in computer science: cache invalidation, naming things, and off-by-1 errors.",
        "The cost of electrons and photons is getting cheaper all the time!",
        "Programming is like sex, one mistake and you have to support it for the rest of your life",
        "If you give someone a program, you will frustrate them for a day; if you teach them how to program, you will frustrate them for a lifetime.",
        "An infinite crowd of mathematicians enters a bar. The first one orders a pint, the second one a half pint, the third one a quarter pint…I understand, says the bartender – and pours two pints.",
        "Real men don’t use backups, they post their stuff on a public ftp server and let the rest of the world make copies.",
        "Evolution is God’s way of issuing upgrades",
        "If brute force doesn’t solve your problems, then you aren’t using enough.",
        "Black holes are where God divided by zero.",
        "My attitude isn’t bad. It’s in beta.",
        "The beginning of the programmer’s wisdom is understanding the difference between getting program to run and having a runnable program.",
        "Beware of programmers that carry screwdrivers.",
        "I would love to change the world, but they won’t give me the source code.",
        "Mac users swear by their Mac, PC users swear at their PC.",
        "Computers are like air conditioners: they stop working when you open Windows.",
        "Failure is not an option. It comes bundled with your Microsoft product.",
        "UNIX is basically a simple operating system, but you have to be a genius to understand the simplicity.",
        "The box said Requires Windows Vista or better. So I installed LINUX.",
        "The Internet: where men are men, women are men, and children are FBI agents.",
        "The truth is out there. Anybody got the URL?",
        "Artificial intelligence usually beats real stupidity.",
        "To err is human – and to blame it on a computer is even more so.",
        "CAPS LOCK – Preventing Login Since 1980.",
        "The sad thing about artificial intelligence is that it lacks artifice and therefore intelligence.",
        "Computer dating is fine, if you're a computer.",
        "If debugging is the process of removing bugs, then programming must be the process of putting them in.",
        "Crap... Someone knocked over my recycle bin... There's icons all over my desktop...",
        "Java is to JavaScript what Car is to Carpet.",
        "Walking on water and developing software from a specification are easy if both are frozen.",
        "Should array indices start at 0 or 1? My compromise of 0.5 was rejected without, I thought, proper consideration",
        "Always code as if the guy who ends up maintaining your code will be a violent psychopath who knows where you live.",
        "Any fool can write code that a computer can understand. Good programmers write code that humans can understand.",
        "Software sucks because users demand it to.",
        "Linux is only free if your time has no value.",
        "Beware of bugs in the above code; I have only proved it correct, not tried it.",
        "There is not now, nor has there ever been, nor will there ever be, any programming language in which it is the least bit difficult to write bad code.",
        "The first 90% of the code accounts for the first 90% of the development time. The remaining 10% of the code accounts for the other 90% of the development time.",
        "Programs must be written for people to read, and only incidentally for machines to execute.",
        "Most software today is very much like an Egyptian pyramid with millions of bricks piled on top of each other, with no structural integrity, but just done by brute force and thousands of slaves.",
        "Programming can be fun, so can cryptography; however they should not be combined. ",
        "Copy and paste is a design error.",
        "Before software can be reusable it first has to be usable.",
        "Without requirements or design, programming is the art of adding bugs to an empty text file. ",
        "When someone says, I want a programming language in which I need only say what I want done, give him a lollipop.",
        "Computers are good at following instructions, but not at reading your mind.",
        "Computer Science is embarrassed by the computer.",
        "I never took a computer science course in college, because then it was a thing you just learned on your own.",
        "Computer science is no more about computers than astronomy is about telescopes."]
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

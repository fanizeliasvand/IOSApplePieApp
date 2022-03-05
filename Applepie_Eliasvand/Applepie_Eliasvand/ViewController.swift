//On my honor, I have neither received nor given any unauthorized assistance on Assignment 4.Faniz Eliasvand
//  ViewController.swift
//  Applepie_Eliasvand
//
//  Created by Faniz Eliasvand on 10/15/21.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var letterBottons: [UIButton]!
    
var listOfWords = ["buccaneer", "swift", "glorious", "incandenscent", "bug", "program"]
let incorrectMovesAllowed = 7
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }
   
var currectGame : Game!
   
    @IBAction func buttonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        currectGame.playerGuessed(letter: letter)
        
        updateGameState()
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        newRound()
    }
    func newRound() {
        if !listOfWords.isEmpty {
            
            let newWord = listOfWords.removeFirst()
            currectGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
            enableLetterbuttons(true)
            updateUI()
        }else {
            enableLetterbuttons(false)
        }
    }
    func enableLetterbuttons (_ enable: Bool) {
        for button in letterBottons {
            button.isEnabled = enable
        }
    }
    func updateUI() {
        var letters = [String]()
        for letter in currectGame.formatterWord {
            letters.append(String(letter))
        }
        let wordWithSpacing = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing
        scoreLabel.text = "wins: \(totalWins), losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currectGame.incorrectMovesRemaining)")
        
    }
    func updateGameState() {
        if currectGame.incorrectMovesRemaining == 0 {
            totalLosses += 1
        } else if currectGame.word == currectGame.formatterWord {
            totalWins += 1
        
        }else {
            updateUI()
        }
    }
}


//
//  Game.swift
//  Bullseye
//
//  Created by Nathan on 20/07/2021.
//

import Foundation

struct LeaderboardEntry {
    let score: Int
    let date: Date
}

struct Game {
    var target: Int = Int.random(in: 1...100)
    var score: Int = 0
    var round: Int  = 1
    var leaderboardEntries: [LeaderboardEntry] = []
    
    init(loadTestData: Bool = false) {
        if loadTestData == true {
            self.leaderboardEntries.append(LeaderboardEntry(score: 100, date: Date()))
            self.leaderboardEntries.append(LeaderboardEntry(score: 80, date: Date()))
            self.leaderboardEntries.append(LeaderboardEntry(score: 200, date: Date()))
            self.leaderboardEntries.append(LeaderboardEntry(score: 97, date: Date()))
            self.leaderboardEntries.append(LeaderboardEntry(score: 189, date: Date()))
        }
    }
    
    /**
     Calculates and returns the number of points based on the slider's current value
     - Parameter sliderValue: the slider's current value
     - Returns: the number of points scored
     */
    func points(sliderValue: Int) -> Int {
        let difference: Int = abs(self.target - sliderValue)
        let points: Int = 100 - abs(sliderValue - self.target)
        
        if difference == 0 {
            return points + 100
        } else if difference <= 2 {
            return points + 50
        } else {
            return points
        }        
    }
    
    mutating func addToLeaderboard(points: Int) {
        self.leaderboardEntries.append(LeaderboardEntry(score: points, date: Date()))
        self.leaderboardEntries.sort { $0.score > $1.score }
    }
    
    /**
     Starts a new round and remembers the player's score.
     - Parameter points: the number of points scored during the current round
     */
    mutating func startNewRound(points: Int) {
        self.score += points
        self.round += 1
        target = Int.random(in: 1...100)
        self.addToLeaderboard(points: points)
    }
    
    /**
     Restarts the game and resets the score and round.
     */
    mutating func restart() {
        self.score = 0
        self.round = 1
        target = Int.random(in: 1...100)
    }
}

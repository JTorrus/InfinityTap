//
//  ScoreboardViewController.swift
//  InfinityTap
//
//  Created by Alumne on 15/5/18.
//  Copyright © 2018 Alumne. All rights reserved.
//

import UIKit

class ScoreboardViewController: UITableViewController {
    
    var highScores: HighScore?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpHighScores()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (highScores?.playerScores.count)!
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "high_score", for: indexPath)
        let playerScore = highScores?.playerScores[indexPath.row]
        
        cell.textLabel?.text = "\(indexPath.row + 1). \(playerScore!.name)"
        cell.detailTextLabel?.text = "\(playerScore!.points) pts"
        
        return cell
    }
    
    private func setUpHighScores() {
        if let data = UserDefaults.standard.object(forKey: "IT_HS") as? Data {
            let decoder = PropertyListDecoder()
            self.highScores = try? decoder.decode(HighScore.self, from: data)
        }
    }
}

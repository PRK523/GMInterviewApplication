//
//  GitApiViewController.swift
//  GMInterviewApplication
//
//  Created by PRANOTI KULKARNI on 12/21/20.
//
import UIKit

class GitApiViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak private var tableView: UITableView?
    
    private var authorName = [String]()
    private var commitMessage = [String]()
    
    override func viewDidLoad() {
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        
        self.parse()
        self.registerTableViewCells()
    }
    
    private func registerTableViewCells() {
        let nib = UINib(nibName: "GitApiCustomCell",
                                  bundle: nil)
        self.tableView?.register(nib, forCellReuseIdentifier: "GitApiCustomCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return authorName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GitApiCustomCell") as! GitApiCustomCell
        cell.authorName.text = authorName[indexPath.row]
        cell.commitMessage.text = commitMessage[indexPath.row]
        
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
    
    private func parse() {
        //you can also use my current repos url: https://api.github.com/repos/PRK523/GitHubApi/commits?=da78e338b643d0433bf96d996a2c214057822bc8
        guard let url = URL(string: "https://api.github.com/repos/PRK523/GitHubApi/commits?=da78e338b643d0433bf96d996a2c214057822bc8") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let item = try decoder.decode([UserData].self, from: data)
                for i in item {
                    let message = i.commit?.message
                    let authorName = i.commit?.author?.name
                    
                    self.authorName.append("Author Name: " + authorName!)
                    self.commitMessage.append("Commit Message: " + message!)
                }
                DispatchQueue.main.async {
                    self.tableView?.reloadData()
                }
            } catch let err {
                print("Err", err)
            }
        }.resume()
    }
}

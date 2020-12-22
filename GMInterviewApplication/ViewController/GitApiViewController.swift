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
    private var commitSha = [String]()
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
        cell.commitSha.text = commitSha[indexPath.row]
        
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "GitHub Api Details"
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45.0
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = .boldSystemFont(ofSize: 20)
    }
    
    private func parse() {
        //you can also use my one of my current repos url, but it has 11 commits. https://api.github.com/repos/PRK523/GitHubApi/commits
        guard let url = URL(string: "https://api.github.com/repos/eficode/weatherapp/commits") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let item = try decoder.decode([UserData].self, from: data)
                for i in item {
                    let message = i.commit?.message
                    let commitSha = i.sha
                    let authorName = i.commit?.author?.name
                    
                    self.authorName.append("Author Name: " + authorName!)
                    self.commitSha.append("Commit Sha: " + commitSha!)
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

//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by Ryan Sullivan on 2/2/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    var tweets = [NSDictionary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.title = "Home"
        loadTweet()
        tableView.delegate = self
        tableView.dataSource = self
    }

    // MARK: - Table view data source
        
    @IBAction func logoutPressed(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        self.dismiss(animated: true, completion: nil)
        UserDefaults.standard.set(false, forKey: "loggedIn")
    }
    
    func loadTweet() {
        let url = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let params = ["count": 10]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: url, parameters: params, success: { (dict) in
            //success
            self.tweets.removeAll()
            for tweet in dict {
                self.tweets.append(tweet)
            }
            self.tableView.reloadData()
        }, failure: { (error) in
            //failure
            
        })
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweets.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath)

        let tweet = tweets[indexPath.row]
        if let tweetCell = cell as? TweetTableViewCell, let user = tweet["user"] as? [String: Any] {
            tweetCell.userLabel.text = user["name"] as? String ?? ""
            tweetCell.contentLabel.text = tweet["text"] as? String ?? ""
            
            if let imageUrl = URL(string: user["profile_image_url_https"] as? String ?? ""),
                let data = try? Data(contentsOf: imageUrl) {
                tweetCell.profileImage.image = UIImage(data: data)
            }
            
        }

        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

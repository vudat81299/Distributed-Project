//
//  MessagingViewControllerTableView.swift
//  Social Messaging
//
//  Created by Dat vu on 13/05/2021.
//

import UIKit

class MessagingViewControllerTableView: UIViewController {
    
    private var tableView: UITableView! = nil
    var userBoxData: [ResolvedBox] = []
    
    
    
    // MARK: - Navbar components.
    let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "New Search"
        searchController.searchBar.searchBarStyle = .minimal
//        searchController.dimsBackgroundDuringPresentation = false // was deprecated in iOS 12.0
        searchController.definesPresentationContext = true
       return searchController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.searchController = searchController
        configureHierarchy()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchBoxesData {
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func fetchBoxesData(completion: @escaping () -> Void) {
        let request_box = ResourceRequest<ResolvedBox>(resourcePath: "mess")
        request_box.getArray(token: Auth.token) { result in
            switch result {
            case .success(let data):
                Auth.userBoxData = data
                self.userBoxData = data
                completion()
            case .failure:
                break
            }
        }
    }

}



// MARK: - TableView
extension MessagingViewControllerTableView: UITableViewDelegate, UITableViewDataSource {
    private func configureHierarchy() {
        tableView = UITableView(frame: view.bounds)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: BoxTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: BoxTableViewCell.reuseIdentifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userBoxData.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BoxTableViewCell.reuseIdentifier, for: indexPath) as! BoxTableViewCell
//        cell.boxImage
        var boxName = "Group"
        let box = userBoxData[indexPath.row]
        if box.type == .privateChat {
            for name in box.membersName {
                if name != box.boxSpecification.creatorName {
                    boxName = name
                    break
                }
            }
        }
        cell.name.text = boxName
        cell.lastestMess.text = box.boxSpecification.lastestMess
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let chattingViewController = ChattingViewController()
        let box = userBoxData[indexPath.row]
        chattingViewController.boxId = box._id
        chattingViewController.navigationItem.largeTitleDisplayMode = .never
        chattingViewController.tabBarController?.tabBar.isHidden = true
        navigationController?.pushViewController(chattingViewController, animated: true)
        self.tabBarController?.tabBar.isHidden = true
    }
}

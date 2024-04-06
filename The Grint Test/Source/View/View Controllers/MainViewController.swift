//
//  MainViewController.swift
//  The Grint Test
//
//  Created by Pedro Toro on 4/3/24.
//

import UIKit
import ProgressHUD

class MainViewController: UIViewController {
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    let refreshControl = UIRefreshControl()
    let viewModel = RedditNewsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        viewModel.setup(delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? DetailViewController,
              let post = sender as? Post else { return }
        detailVC.post = post
    }
    
}

private extension MainViewController {
    
    func setupSubviews() {
        setupRefreshControl()
        setupTableView()
        ProgressHUD.animationType = .circleStrokeSpin
    }
    
    func setupTableView() {
        let nibName = "RedditTableViewCell"
        let cellNib = UINib(nibName: nibName, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: nibName)
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc func refresh() {
        viewModel.getRedditPosts()
    }

    func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RedditTableViewCell") as? RedditTableViewCell else {
            return UITableViewCell()
        }
        let post = viewModel.posts[indexPath.row].post
        cell.setup(with: post)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = viewModel.posts[indexPath.row].post
        performSegue(withIdentifier: "PresentDetailVC", sender: post)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row >= viewModel.posts.count - 3 {
            viewModel.getRedditPosts()
        }
    }
    
}

extension MainViewController: RedditNewsViewModelDelegate {
    func onFinish() {
        refreshControl.endRefreshing()
        ProgressHUD.dismiss()
        tableView.reloadData()
    }
    
    func onError(error: Error) {
        refreshControl.endRefreshing()
        ProgressHUD.dismiss()
        showAlert(title: "Oops!", message: error.localizedDescription)
    }
    
    func onLoad() {
        ProgressHUD.animate("")
    }
    
}


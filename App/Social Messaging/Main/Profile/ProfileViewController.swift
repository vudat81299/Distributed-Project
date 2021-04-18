//
//  ProfileViewController.swift
//  Social Messaging
//
//  Created by Vũ Quý Đạt  on 10/04/2021.
//

import UIKit


class ProfileViewController: UIViewController {

    @IBOutlet var panGesture: UIPanGestureRecognizer!
    @IBOutlet weak var tableView: UITableView!

    var headersIndex = [IndexPath]()
    var touchPosition: CGPoint = CGPoint(x: 0, y: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.register(UINib(nibName: "Cell", bundle: nil), forCellReuseIdentifier: "Cell")
        tableView.register(UINib(nibName: "HeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderTableViewCell")
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    
    
    
    
    
//    @IBAction func panGestureOnTable(_ sender: UIPanGestureRecognizer) {
//        let touchPoint = sender.location(in: tableView)
//        print(touchPoint)
//        if sender.state == .ended {
//            tableView.visibleCells.forEach {
//                if let cell = $0 as? Cell {
//                    UIView.animate(withDuration: 0.1) { [weak self] in
//                        cell.constraint.constant = 0
//                        self?.view.layoutIfNeeded()
//                    }
//                }
//            }
//        } else if sender.state == .began {
//            touchPosition = touchPoint
//        } else if sender.state == .changed {
//            tableView.visibleCells.forEach {
//                $0.textLabel?.text = "\(touchPoint.x)"
//                if let cell = $0 as? Cell {
//                    cell.constraint.constant = (touchPosition.x - touchPoint.x) > 0 ? (touchPosition.x - touchPoint.x) : 0
//                }
//            }
//        }
//    }
    
//    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        return [gestureRecognizer, otherGestureRecognizer].contains(panGesture)
//    }
//
//    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
//        if let gesture = gestureRecognizer as? UIPanGestureRecognizer, gesture == panGesture {
//            let translation = gesture.translation(in: gesture.view)
//            return (abs(translation.x) > abs(translation.y)) && (gesture == panGesture)
//        }
//        return false
//    }
    
}

extension ProfileViewController: UITableViewDataSource,UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 5 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderTableViewCell") as! HeaderTableViewCell
            cell.centerLabel.text = "sanjay"
            cell.centerLabel.center.x = view.center.x
            if !headersIndex.contains(indexPath) {
                headersIndex.append(indexPath)
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
            cell.leftLabel.text = "Message \(indexPath.row)"
            cell.rightLabel.text = indexPath.row.description
            return cell
        }
    }
}

//
//  SavedDecadeTableViewController.swift
//  Decade
//
//  Created by Nick Reichard on 5/2/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import UIKit


class SavedDecadeTableViewController: UITableViewController, SavedDecadeTableViewCellDelegate {
    
    let stretchyHeader = StretchHeader()
    var decades: [Decade] = []
    var decade: Decade?
    var user: User?
    var headerView: UIView?
    var newHeaderLayer: CAShapeLayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title =  "Saved Images"
        updateView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DecadeController.shared.fetchUserLikedDecades {
            DecadeController.shared.fetchUserLikedImages {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func updateView() {
        tableView.backgroundColor = UIColor.white
        headerView = tableView.tableHeaderView
        tableView.tableHeaderView = nil
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.addSubview(headerView ?? UIView())
        
        newHeaderLayer = CAShapeLayer()
        newHeaderLayer?.fillColor = UIColor.black.cgColor
        headerView?.layer.mask = newHeaderLayer
        
        let newHeight = stretchyHeader.headerHeight - stretchyHeader.headerCut / 2
        
        tableView.contentInset = UIEdgeInsets(top: newHeight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -newHeight)
        setNewView()
     }
    
    func setNewView() {
        
        let newHeight = stretchyHeader.headerHeight - stretchyHeader.headerCut / 2
        var getHeaderFrame = CGRect(x: 0, y: -newHeight, width: tableView.bounds.width, height: stretchyHeader.headerHeight)
        
        if tableView.contentOffset.y < newHeight {
            getHeaderFrame.origin.y = tableView.contentOffset.y
            getHeaderFrame.size.height = -tableView.contentOffset.y + stretchyHeader.headerCut / 2
        }
        
        headerView?.frame = getHeaderFrame
        let cutDirecrtion = UIBezierPath()
        cutDirecrtion.move(to: CGPoint(x: 0, y: 0))
        cutDirecrtion.addLine(to: CGPoint(x: getHeaderFrame.width, y: 0))
        cutDirecrtion.addLine(to: CGPoint(x: getHeaderFrame.width, y: getHeaderFrame.height))
        cutDirecrtion.addLine(to: CGPoint(x: 0, y: getHeaderFrame.height - stretchyHeader.headerCut))
        newHeaderLayer?.path = cutDirecrtion.cgPath
    
    }
    
    // MARK: ShareButtonTableViewCellDelegate
    
    func shareButtonTapped(_ sender: SavedDecadeTableViewCell) {
        guard let indexPath = tableView.indexPath(for: sender) else { return }
        
        let decade = DecadeController.shared.likedDecades[indexPath.row]
        guard let decadeImage = decade.decadeImage else { return }
        let decadeName = decade.imageName
    
        let activityVC = UIActivityViewController(activityItems: [decadeImage, decadeName], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        setNewView()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return DecadeController.shared.likedDecades.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "savedImagesCell", for: indexPath) as? SavedDecadeTableViewCell else { return SavedDecadeTableViewCell() }
        
        let decade = DecadeController.shared.likedDecades[indexPath.row]
        cell.decade = decade
        cell.delegate = self
        cell.shareButtonTapped(self)
        
        return cell
    }
}

struct StretchHeader {
    fileprivate let headerHeight: CGFloat = 250
    fileprivate let headerCut: CGFloat = -30
}



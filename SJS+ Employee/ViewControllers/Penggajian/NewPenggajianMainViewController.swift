//
//  NewPenggajianMainViewController.swift
//  SJS+ Employee
//
//  Created by Prabaesa Yudha Tama on 14/06/22.
//

import UIKit
import IGListKit

class NewPenggajianMainViewController: SJSViewController, Storyboarded {
    @IBOutlet weak var listCollectionView: UICollectionView!
    
    var coordinator: PenggajianCoordinator?
    
    lazy var adapter = {
       return ListAdapter(updater: ListAdapterUpdater(),
                          viewController: self,
                          workingRangeSize: 0)
    }()
    
    
    var card = Card(bankName: "Mandiri", accountNumber: "0123456789", ownerName: "John Doe")
    
    var menuItems: [MenuData] = [MenuData(id: "1", nama_menu: "Index 0"),
                                 MenuData(id: "2", nama_menu: "Index 1"),
                                 MenuData(id: "3", nama_menu: "Index 2")]
    var menus: [Menu] = []
    
    var sectionKey = ["card", "menu"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listCollectionView.backgroundColor = .systemGroupedBackground
        adapter.collectionView = listCollectionView
        adapter.dataSource = self
    }
}

extension NewPenggajianMainViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        var items: [ListDiffable] = [card]
        
        menus.append(Menu(menu: menuItems, total_notif: 0))
        items += menus as [ListDiffable]
        
        return items
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        if object is Card {
            return CardSectionController()
        } else {
            return PenggajianMenuSectionController()
        }
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}

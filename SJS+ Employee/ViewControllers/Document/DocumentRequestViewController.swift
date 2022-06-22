//
//  DocumentRequestViewController.swift
//  SJS+ Employee
//
//  Created by Prabaesa Yudha Tama on 12/05/22.
//

import UIKit

class DocumentRequestViewController: SJSViewController, Storyboarded {
    var coordinator: HomeCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Permintaan Dokumen"
    }
}

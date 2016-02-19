//
//  ViewController.swift
//  TestAlamofire
//
//  Created by Yoshizumi Ashikawa on 2016/02/19.
//  Copyright © 2016年 Yoshizumi Ashikawa. All rights reserved.
//

import UIKit
import ReactiveKit
import SwiftyJSON

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
  var requestViewModel = RequestViewModel()
  var tbv: UITableView!
  var getDataJSON = Observable<JSON>([])
  var testData = Observable<JSON>([])

  override func viewDidLoad() {
    super.viewDidLoad()
		view.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    let barHeight = UIApplication.sharedApplication().statusBarFrame.size.height

		tbv = UITableView(frame: CGRectMake(0, barHeight, view.frame.width, view.frame.height-barHeight))
    tbv.registerClass(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
    tbv.dataSource = self
    tbv.delegate = self
    view.addSubview(tbv)

    //setBind
    requestViewModel.jsonData.bindTo(getDataJSON)
    requestViewModel.startOperation {
			print(self.getDataJSON.value)
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()

  }

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 3
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("MyCell", forIndexPath: indexPath)
    cell.textLabel?.text = "へーい"
    return cell
  }

}


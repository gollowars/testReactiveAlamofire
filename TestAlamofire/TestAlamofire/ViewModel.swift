//
//  ViewModel.swift
//  TestAlamofire
//
//  Created by Yoshizumi Ashikawa on 2016/02/19.
//  Copyright © 2016年 Yoshizumi Ashikawa. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import ReactiveKit


class RequestViewModel {
  var jsonObj:JSON?
	var initFileRewrite = true
  var requestUrl = "https://lolipop-junpop.ssl-lolipop.jp/_test/scrap/hero.json"
  let documentPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,.UserDomainMask, true)
	var fileName = "data.json"
  var jsonData = Observable<JSON>([])

  var operation: Operation<JSON,NSError>!

  init(){

  }
  convenience init(url:String,file:String){
    self.init()
		requestUrl = url
		fileName = file
  }

  // startRequest
  func startOperation(callback:()->Void){
    // create operation
    operation = Operation { (observer:OperationObserver<JSON,NSError>) in
      if !self.checkDatafile() && !self.initFileRewrite {
        print("file has already been required")
        observer.success()
      }else {
        print("start request")
        self.startRequest(self.requestUrl) { data in
          let dataTxt = data.description
          self.saveDatafile(dataTxt){
            if self.checkDatafile() {
              print("file has already been required")
              observer.success()
            }
          }
        }
      }
      return BlockDisposable {
        print("disposable")
      }
    }

    operation.observe { event in
      switch event {
      case .Success():
        print("success")
        callback()
      default:
        print("other")
      }
    }
  }


  // jsonfileの読み込みを確認
  func checkDatafile() -> Bool{
    var flag = true
    if let dir : NSString = documentPath.first {
      let path_file_name = dir.stringByAppendingPathComponent( fileName )
      do {
        jsonObj = JSON(try String( contentsOfFile: path_file_name, encoding: NSUTF8StringEncoding ))
        jsonData.value = jsonObj!
      } catch {
        flag = false
      }
    }
		return flag
  }

  //file保存
  func saveDatafile(data:String,callback:()->Void) {
    if let dir : NSString = documentPath.first {
      let path_file_name = dir.stringByAppendingPathComponent( fileName )
      do {
        try data.writeToFile( path_file_name, atomically: false, encoding: NSUTF8StringEncoding )
        callback()
      } catch {
				print("書き込みエラー")
      }
    }
  }

  //リクエストスタート
  func startRequest(url:String, callback:(data:JSON)-> Void){
    Alamofire.request(.GET, url, parameters: nil).responseJSON(options:.AllowFragments) { response in
      let responseData = JSON(response.result.value!)
      callback(data: responseData)
    }
  }

}
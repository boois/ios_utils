//
//  MyTableView.swift
//  HengChengHui
//
//  Created by boois on 2017/6/22.
//  Copyright © 2017年 boois. All rights reserved.
//

import UIKit


class MyAutoHeightCell{
    var IsShow:Bool = true
    var CellName:String
    //    var CellId:String
    var SectionName:String = ""
    var SectionHeight:CGFloat = 0
    var CellFn:((_ tableView: UITableView,_ cell:UITableViewCell, _ indexPath: IndexPath)->())?
    var SelectedFn:((_ tableView: UITableView, _ indexPath: IndexPath)->())?
    init(CellName:String, CellFn:((_ tableView: UITableView,_ cell:UITableViewCell, _ indexPath: IndexPath)->())?,SelectedFn:((_ tableView: UITableView, _ indexPath: IndexPath)->())?) {
        self.CellName = CellName
        self.CellFn = CellFn
        self.SelectedFn = SelectedFn
    }
    init(SectionName:String,SectionHeight:CGFloat,CellName:String,CellFn:((_ tableView: UITableView,_ cell:UITableViewCell, _ indexPath: IndexPath)->())?,SelectedFn:((_ tableView: UITableView, _ indexPath: IndexPath)->())?) {
        self.SectionName = SectionName
        self.SectionHeight = SectionHeight
        self.CellName = CellName
        self.CellFn = CellFn
        self.SelectedFn = SelectedFn
    }
}


class MyAutoHeightTableViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var tabview : UITableView?{
        return nil
    }
    func regCell(tabview:UITableView?) {
        
    }
    func getData()->[MyAutoHeightCell] {
        return []
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabviewInit()
        regCell(tabview: self.tabview)
    }
    var list:[MyAutoHeightCell] = []
    func tabviewInit(){
        //tabview.separatorStyle = UITableViewCellSeparatorStyle.none
        tabview?.delegate = self
        tabview?.dataSource=self
        tabview?.backgroundColor = UIColor(colorLiteralRed: 241/255, green: 241/255, blue: 241/255, alpha: 1)
        tabview?.estimatedRowHeight = 80.0;
        tabview?.rowHeight = UITableViewAutomaticDimension;
        list = getData()
        
    }
    func tabviewRegCells() {
        // 在这里注册Nib
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell?
        cell = UITableViewCell()
        cell!.selectionStyle = UITableViewCellSelectionStyle.none
        if self.tabview == nil{return cell!}
        cell = self.tabview!.dequeueReusableCell(withIdentifier: list[indexPath.row].CellName)
        cell?.selectionStyle = UITableViewCellSelectionStyle.none;
        if (cell == nil ){  return UITableViewCell() }
        list[indexPath.row].CellFn?(tableView,cell!,indexPath)
        return cell!
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        list[indexPath.row].SelectedFn?(tableView,indexPath)
    }
    
}


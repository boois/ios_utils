//
//  MyPicker.swift
//  HengChengHui
//
//  Created by boois on 2017/6/25.
//  Copyright © 2017年 boois. All rights reserved.
//

/*
 selector.adapter = MyPickerAdapter(data:
            MyPickerData(text:"",fontSize:nil,fontColor:nil,subData:[
                MyPickerData(text:"福州",fontSize:nil,fontColor:nil,subData:[
                    MyPickerData(text:"鼓楼",fontSize:nil,fontColor:nil,subData:[
                        MyPickerData(text:"东街",fontSize:nil,fontColor:nil,subData:[]),
                        MyPickerData(text:"金山",fontSize:nil,fontColor:nil,subData:[]),
                        MyPickerData(text:"南门",fontSize:nil,fontColor:nil,subData:[]),
                    ]),
                    MyPickerData(text:"连江",fontSize:nil,fontColor:nil,subData:[
                        MyPickerData(text:"连江1",fontSize:nil,fontColor:nil,subData:[]),
                    ]),
                    MyPickerData(text:"长乐",fontSize:nil,fontColor:nil,subData:[
                        MyPickerData(text:"长乐1",fontSize:nil,fontColor:nil,subData:[]),
                    ]),
                ]),
                MyPickerData(text:"南平",fontSize:nil,fontColor:nil,subData:[
                    MyPickerData(text:"武夷山",fontSize:nil,fontColor:nil,subData:[
                        MyPickerData(text:"武夷山1",fontSize:nil,fontColor:nil,subData:[]),
                    ]),
                    MyPickerData(text:"顺昌",fontSize:nil,fontColor:nil,subData:[
                        MyPickerData(text:"顺昌1",fontSize:nil,fontColor:nil,subData:[]),
                    ]),
                    MyPickerData(text:"建阳",fontSize:nil,fontColor:nil,subData:[
                        MyPickerData(text:"建阳1",fontSize:nil,fontColor:nil,subData:[]),
                    ]),
                ]),
                MyPickerData(text:"厦门",fontSize:nil,fontColor:nil,subData:[
                    MyPickerData(text:"湖里",fontSize:nil,fontColor:nil,subData:[
                        MyPickerData(text:"湖里1",fontSize:nil,fontColor:nil,subData:[]),
                   ]),
                    MyPickerData(text:"思明",fontSize:nil,fontColor:nil,subData:[
                        MyPickerData(text:"思明1",fontSize:nil,fontColor:nil,subData:[]),
                    ]),
                    MyPickerData(text:"海沧",fontSize:nil,fontColor:nil,subData:[
                        MyPickerData(text:"海沧1",fontSize:nil,fontColor:nil,subData:[]),
                    ]),
                ]),
                ]),fontSize: 18, fontColor: UIColor.white, lineColor: UIColor.white, rowHeight: 40,columnCount:3)

        selector.selectRow(row: 1, component: 0)
        selector.selectRow(row: 1, component: 1)
        selector.selectRow(row: 1, component: 2)

        selector.adapter.selectEvent = {(pickerView: UIPickerView, row: Int, component: Int)->() in
            var sel = self.selector.getData()
            print(";;",sel?[0]?.text,sel?[1]?.text,sel?[2]?.text);
        }

 */

import UIKit

class MyPickerData{
    var text:String = ""
    var val:AnyObject? = nil
    var fontSize:CGFloat? = 18.0
    var fontColor:UIColor?
    var subData:[MyPickerData] = []
    var selectedIndex = 0
    init(text:String,val:AnyObject?,selectedIndex:Int,fontSize:CGFloat?,fontColor:UIColor?,subData:[MyPickerData]) {
        self.text = text
        self.val = val
        self.fontSize = fontSize
        self.fontColor = fontColor
        self.subData = subData
    }
    init(text:String,val:AnyObject?,fontSize:CGFloat?,fontColor:UIColor?,subData:[MyPickerData]) {
        self.text = text
        self.val = val
        self.fontSize = fontSize
        self.fontColor = fontColor
        self.subData = subData
    }
    init(text:String,selectedIndex:Int,fontSize:CGFloat?,fontColor:UIColor?,subData:[MyPickerData]) {
        self.text = text
        self.fontSize = fontSize
        self.fontColor = fontColor
        self.subData = subData
    }
    init(text:String,fontSize:CGFloat?,fontColor:UIColor?,subData:[MyPickerData]) {
        self.text = text
        self.fontSize = fontSize
        self.fontColor = fontColor
        self.subData = subData
    }
    init(subData:[MyPickerData]) {
        self.subData = subData
    }
    init() {
        
    }
}
class MyPickerVal{
    var text:String = ""
    var val:AnyObject? = nil
    init(text:String,val:AnyObject?) {
        self.text = text
        self.val = val
    }
}
class MyPickerAdapter{
    var data:MyPickerData = MyPickerData()
    var fontSize:CGFloat = 18.0
    var fontColor:UIColor = UIColor.black
    var lineColor:UIColor = UIColor.black
    var rowHeight:CGFloat = 40
    var columnCount:Int = 1
    var selectEvent:((_ pickerView: UIPickerView, _ row: Int, _ component: Int)->())?

    init(data:MyPickerData,fontSize:CGFloat,fontColor:UIColor,lineColor:UIColor,rowHeight:CGFloat,columnCount:Int) {
        self.data = data
        self.fontSize = fontSize
        self.fontColor = fontColor
        self.lineColor = lineColor
        self.rowHeight = rowHeight
        self.columnCount = columnCount
    }
    init(data:MyPickerData,fontSize:CGFloat,fontColor:UIColor,lineColor:UIColor,rowHeight:CGFloat,columnCount:Int,selectEvent:((_ pickerView: UIPickerView, _ row: Int, _ component: Int)->())?) {
        self.data = data
        self.fontSize = fontSize
        self.fontColor = fontColor
        self.lineColor = lineColor
        self.rowHeight = rowHeight
        self.columnCount = columnCount
        self.selectEvent = selectEvent
    }
    init() {
        
    }
    
}

class MyPicker:UIPickerView,UIPickerViewDataSource,UIPickerViewDelegate{
    
    var adapter:MyPickerAdapter = MyPickerAdapter()
    var selectedObjs:[Int:MyPickerData] = [:]
    func setData(adapter:MyPickerAdapter){
       self.adapter = adapter
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        doit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        doit()
    }
    
    func doit() {
        self.delegate = self
        self.dataSource = self
        self.tintColor = UIColor.white
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        for speartorView in self.subviews{
            if (speartorView.frame.size.height < 1){
                speartorView.backgroundColor = UIColor.white;//分割线样式
            }
        }
    }
    /*
     var sel = self.selector.getData()
     print(";;",sel?[0]?.text,sel?[1]?.text,sel?[2]?.text);
     */
    public func getData()->[MyPickerVal?]?{
        var arr:[MyPickerVal?]? = []
        var root:MyPickerData = self.adapter.data
        for i in 0 ..< self.adapter.columnCount{
            let sel_row = self.selectedRow(inComponent: i)
            if sel_row == -1 {
                arr?.append(nil)
            }else{
                if (root.subData.count > sel_row){
                    arr?.append(MyPickerVal(text:root.subData[sel_row].text,val:root.subData[sel_row].val))
                    root = root.subData[sel_row]
                }else{
                    arr?.append(nil)
                }
            }
        }
        return arr
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return adapter.columnCount
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        var dt : [MyPickerData] = []
        if component == 0 {
            dt = adapter.data.subData
        }else{
            let _dt = getDataObj(component: component)?.subData
            if _dt != nil {
                dt = _dt!
            }
        }
        return dt.count
    }

    public func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return adapter.rowHeight
    }
    
    private func getDataObj(component:Int)->MyPickerData?{
        if (adapter.data.selectedIndex > adapter.data.subData.count-1 ){ return nil }
        var root = adapter.data.subData[adapter.data.selectedIndex]
        for _ in 0 ..< component-1{
            if (root.subData.count==0) {
                return root
            }
            root = root.subData[root.selectedIndex]
        }
        return root
    }
    
    public func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView{
        let txt = UILabel()
        var dt : [MyPickerData] = []
        if component == 0 { // 如果是第一列,就直接载入了
            dt = adapter.data.subData
        }else{
        // 如果不是第一列的话,那我们要看他的上一列选中了哪个元素,那么就渲染上个元素的子元素
            let _dt = getDataObj(component: component)?.subData
            if (_dt != nil){
                dt = _dt!
            }
        }
        if dt.count == 0 {return txt}
        txt.text = dt[row].text
        txt.font = UIFont.systemFont(ofSize: adapter.fontSize)
        txt.textColor = adapter.fontColor
        txt.textAlignment = NSTextAlignment.center
        return txt
    }
    
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
//        print("选中了我",row,component)
        selectRow(row: row,component: component)
        self.adapter.selectEvent?(pickerView, row, component)
    }
    // 联动式的选择
    public func selectRow(row: Int,component: Int){
        
        print("联动选择",row,component)
        if (self.adapter.columnCount==1){
            self.selectRow(row, inComponent: 0, animated: true)
            return
        }
        
        
        for i in component ..< self.adapter.columnCount-1{
            
            var dt : MyPickerData = MyPickerData()
            if i == component {
                if component == 0 {
                    dt = adapter.data
                }else{
                    let _dt = getDataObj(component: component)
                    if _dt != nil {
                        dt = _dt!
                    }
                }
                dt.selectedIndex = row
                self.selectRow(row, inComponent: i, animated: true)
                self.reloadComponent(component+1)
            }else{
                let _dt = getDataObj(component: i)
                if _dt != nil {
                    dt = _dt!
                }
                dt.selectedIndex = 0
                self.reloadComponent(i+1)
            }
            
            self.selectRow(0, inComponent: i+1, animated: true)
        }
    }
    
    
}

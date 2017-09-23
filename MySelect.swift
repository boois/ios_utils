//
//  MySelect.swift
//  HengChengHui
//
//  Created by boois on 2017/6/26.
//  Copyright © 2017年 boois. All rights reserved.
//
/*
self.jiner = cell.viewWithTag(99) as? MySelect
self.jiner?.pickerBgColor = UIColor.white
self.jiner?.yesBtnTextColorUIColor = UIColor.gray
self.jiner?.noBtnTextColorUIColor = UIColor.black
self.jiner?.adapter = MyPickerAdapter(data:
		MyPickerData(text:"",fontSize:nil,fontColor:nil,subData:[
				MyPickerData(text:"￥100",fontSize:nil,fontColor:nil,subData:[]),
				MyPickerData(text:"￥200",fontSize:nil,fontColor:nil,subData:[]),
				MyPickerData(text:"￥300",fontSize:nil,fontColor:nil,subData:[]),
				MyPickerData(text:"￥400",fontSize:nil,fontColor:nil,subData:[]),
				MyPickerData(text:"￥500",fontSize:nil,fontColor:nil,subData:[]),
				MyPickerData(text:"￥800",fontSize:nil,fontColor:nil,subData:[]),
				MyPickerData(text:"￥1000",fontSize:nil,fontColor:nil,subData:[]),
		]),fontSize: 18, fontColor: UIColor.black, lineColor: UIColor.black, rowHeight: 40,columnCount:1)

self.jiner?.pickerSelectedIndexs = [1,1]
self.jiner?.pickerSelectEvent = {(pickerView: UIPickerView, row: Int, component: Int)->() in
		//var sel = self.jiner?.getData()
		//let je = sel?[0]?.text ?? "请选择金额"
		//print("选中了")
		//self.jiner?.setTitle(je, for: UIControlState.normal)
}
*/


import UIKit

class MySelect:UIButton{
    var selector:MyPicker = MyPicker()
    
    var bg:UIButton?
    
    var text:String = ""
    var val:AnyObject? = nil
    var adapter:MyPickerAdapter?
    var pickerBgColor:UIColor = UIColor.white
    var pickerSelectEvent:((_ pickerView: UIPickerView, _ row: Int, _ component: Int)->())?
    var pickerSelectedIndexs:[Int]?
    var yesBtnTextColorUIColor = UIColor.gray
    var noBtnTextColorUIColor = UIColor.black
    var data:[MyPickerVal?]?
    
    @objc private func quxiao_clk(){
        bg?.isHidden = true
    }
    @objc private func queding_clk(){
        let arr = self.getData()
        if arr == nil {return }
        var s = ""
        for d in arr! {
            if d == nil {continue}
            s = s + " " + (d?.text)!
        }
        print(s)
        self.setTitle(s, for: UIControlState.normal)
        bg?.isHidden = true
    }
    func getData()->[MyPickerVal?]?{
        data = self.selector.getData()
        return data
    }
    func selectRow(row: Int, component:Int){
        self.selector.selectRow(row: row, component: component)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        if bg == nil { // 如果没有添加则开始添加
            // 背景的设置
            bg = UIButton(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
            bg!.backgroundColor = UIColor(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0.5)
            bg!.isHidden = true
            bg!.addTarget(self, action: #selector(quxiao_clk), for: UIControlEvents.touchUpInside)
            
            // 工具条
            let tool_bar = UIView(frame:CGRect(x: 0, y: UIScreen.main.bounds.height-216-51, width: UIScreen.main.bounds.width, height: 50))
            tool_bar.backgroundColor = pickerBgColor
            
            // 取消按钮
            let quxiao = UIButton(frame: CGRect(x: 5, y:5, width: 60, height: 40))
            quxiao.setTitle("取消", for: UIControlState.normal)
            quxiao.setTitleColor(yesBtnTextColorUIColor, for: UIControlState.normal)
            quxiao.addTarget(self, action: #selector(quxiao_clk), for: UIControlEvents.touchUpInside)
            
            // 确定按钮
            let queding = UIButton(frame: CGRect(x: UIScreen.main.bounds.width-65, y:5, width: 60, height: 40))
            queding.setTitleColor(noBtnTextColorUIColor, for: UIControlState.normal)
            queding.setTitle("确定", for: UIControlState.normal)
            queding.addTarget(self, action: #selector(queding_clk), for: UIControlEvents.touchUpInside)
            
            // 工具条
            tool_bar.addSubview(quxiao)
            tool_bar.addSubview(queding)
            bg!.addSubview(tool_bar)
            // picker的设置
            selector.frame = CGRect(x: 0, y: UIScreen.main.bounds.height-216, width: UIScreen.main.bounds.width, height: 216)
            bg!.addSubview(selector)
            selector.backgroundColor = pickerBgColor
            if self.adapter != nil {
                selector.adapter = self.adapter!
            }
            selector.adapter.selectEvent = self.pickerSelectEvent
            controller()?.view.addSubview(bg!)
            // 这里设置默认的选择索引
            if pickerSelectedIndexs != nil && self.adapter != nil{
                for i in 0 ..< self.adapter!.columnCount {
                    if pickerSelectedIndexs!.count <= i {break}
                    selector.selectRow(row: pickerSelectedIndexs![i], component: i)
                }
            }
            // 获取数据进行初始化数据填充
            queding_clk()
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       self.bg!.isHidden = false
    }
    private func controller()->UIViewController?{
        var next:UIView? = self
        repeat{
            if let nextResponder = next?.next , nextResponder.isKind(of: UIViewController.self){
                return (nextResponder as! UIViewController)
            }
            next = next?.superview
        } while next != nil
        return nil
    }
}

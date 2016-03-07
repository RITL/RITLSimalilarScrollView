//
//  YSimailarScrollView.swift
//  SimilarUCScrollDemo
//
//  Created by YueWen on 16/3/4.
//  Copyright © 2016年 YueWen. All rights reserved.
//

import UIKit

typealias ScrollBlock = (scale : Int) -> Void


/// 上端的滚动状态栏
class YSimailarScrollView: UIView {
    
    var bottomScrollView:UIScrollView!          //底层负责滚动的滚动视图
    var showChooseView:UIView!                  //负责显示选中的视图
    var showSelectView:UIView!                  //展示背后存放的视图
    
    var backTitleColor = UIColor.blackColor()   //底层展示文字颜色
    var showTitleColor = UIColor.whiteColor()   //选中展示文字颜色
    var showBackColor = UIColor.redColor()      //选中视图的背景色
    
    var fontSize = 16.0             //文字的大小
    var duration = 0.5              //动画完成的时间
    var numberOfTitle = 4           //每页呈现的个数
    var sHeight:CGFloat = 40.0      //状态栏的高度
    
    //数据变量
    var width : CGFloat?
    var labels : [UILabel]?
    var titles : [String] = ["Run","Into","Love","Yue"]
    
    var scrollBlockHandle:ScrollBlock?          //点击进行的回调
    
    
    

    
    //MARK: - 重写父类的方法
    override init(frame: CGRect)
    {
        //初始化视图
        bottomScrollView = UIScrollView()
        showSelectView = UIView()
        showChooseView = UIView()
        
        //初始化数组
        labels = Array()
        width = frame.size.width / CGFloat(numberOfTitle)
        
        super.init(frame: frame)
    }
    
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func awakeFromNib() {
       
        
        
    }
    
    override func layoutSubviews()
    {
        //初始化宽度
        width = self.frame.size.width / (CGFloat(numberOfTitle))
        
        yBottomScrollView()
        createBottomLabel()
        yShowSelectView()
        yShowChooseView()
        createResponseButton()
    }
    
    
    
    
    
    //MARK: - 创建View

    /**
     创建底层的滚动视图
     */
    func yBottomScrollView()
    {
        bottomScrollView.frame = self.bounds
        bottomScrollView.contentSize = CGSize(width: width! * CGFloat(titles.count),height: sHeight)
        bottomScrollView.showsHorizontalScrollIndicator = false
        self.addSubview(bottomScrollView)
    }
    
    
    /**
     创建底层的标签
     */
    func createBottomLabel()
    {
        for(var i = 0; i < titles.count; i++)
        {
            let label = createLabel(i, titleColor: backTitleColor)
            bottomScrollView.addSubview(label)
        }
    }
    
    
    /**
     创建选中的视图
     */
    func yShowChooseView()
    {
        showChooseView.frame = frameOfView(0)
        showChooseView.backgroundColor = showBackColor
        showChooseView.clipsToBounds = true
        bottomScrollView.addSubview(showChooseView)
    }
    
    
    
    /**
     创建展示背后存放的视图
     */
    func yShowSelectView()
    {
        showSelectView.frame = bottomScrollView.bounds
        
        for(var i = 0; i < titles.count; i++)
        {
            showSelectView.addSubview(createLabel(i, titleColor: showTitleColor))
        }
        
        showChooseView.addSubview(showSelectView)
    }
    
    
    /**
     创建响应的按钮
     */
    func createResponseButton()
    {
        for(var i = 0; i < titles.count; i++)
        {
            let button = createButton(i)
            bottomScrollView.addSubview(button)
        }
    }
    
    
    /**
     根据索引创建Label对象
     
     :param: index      索引
     :param: titleColor 显示的文字颜色
     
     :returns: 创建好的Label
     */
    func createLabel(index : NSInteger, titleColor : UIColor) -> UILabel
    {
        let frame = CGRectMake((CGFloat(index)) * width!, 0, width!, sHeight)
        let label = UILabel(frame: frame)
        label.textAlignment = NSTextAlignment.Center
        label.font = UIFont.systemFontOfSize(CGFloat(fontSize))
        label.textColor = titleColor
        label.text = titles[index]
        labels?.append(label)//添加到数组
        return label
    }
    
    
    /**
     根据索引创建按钮对象
     
     :param: index 索引
     
     :returns: 当前标签的frame
     */
    func createButton(index: NSInteger) -> UIButton
    {
        let button = UIButton(type: UIButtonType.Custom)
        button.frame = frameOfView(index)
        button.tag = index
        button.backgroundColor = UIColor.clearColor()
        button.addTarget(self, action: Selector("labelDidTap:"), forControlEvents: UIControlEvents.TouchUpInside)
        return button
    }
    
    /**
     根据索引获得当前label的框架
     
     :param: index 索引
     
     :returns: 当前索引的lable的frame
     */
    func frameOfView(index:NSInteger) -> CGRect
    {
        return labels![index].frame
    }
    
    
    
    
    //MARK: - Target Action
    
    /**
    按钮点击的目标动作回调
    
    :param: sender 回调的发送者
    */
    func labelDidTap(sender : AnyObject)
    {
        //获取button
        let button = sender as! UIButton

        //获取当前的frame
        let frame = frameOfView(button.tag)
        
        let frameSelect = handleFrame(frame)
        
        //回调Block
        scrollBlockHandle!(scale: Int(frame.origin.x / width!))
        
        //设置frame
        UIView.animateWithDuration(duration) { () -> Void in
            self.showChooseView.frame = frame
            self.showSelectView.frame =  frameSelect
        }
    }
    
    
    // MARK: - Data Handle
    
    
    /**
    设置闭包回调
    
    :param: scrollBlockHandleNew 闭包回调
    */
    func selectTapBlockHandle(scrollBlockHandleNew:ScrollBlock)
    {
        scrollBlockHandle = scrollBlockHandleNew
    }
    
    
    /**
    处理当前的frame
    
    :param: frame 需要处理的frame
    
    :returns: 处理完毕的frame
    */
    func handleFrame(frame : CGRect) -> CGRect
    {
        var frameHandle = frame
        frameHandle.origin.x = -1 * frame.origin.x
        return frameHandle
    }
    
    
    //MARK: - 对外接口
    
    /**
    滚动到当前偏移量的位置
    
    :param: contentOff 滚动的偏移量
    */
    func sliderSimailarScrollView(contentOff : CGPoint)
    {
        //获取当前选中视图的位置
        var frame = showChooseView.frame
        
        //对点进行处理
        frame.origin.x = contentOff.x / CGFloat(numberOfTitle)
        
        //动画执行
        UIView.animateWithDuration(0.2) { () -> Void in
            
            self.showChooseView.frame = frame
            self.showSelectView.frame = self.handleFrame(frame)
        }
        
    }

}

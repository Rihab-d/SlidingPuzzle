//
//  ViewController.swift
//  Sliding Puzzle
//
//  Created by rihab aldabbagh on 07/06/2018.
//  Copyright © 2018 rihab aldabbagh. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var GameView: UIView!
    
    @IBOutlet weak var TimerLBL: UILabel!
    
    var GameViewWidth : CGFloat!
    var BlockWidth : CGFloat!
    var xCen : CGFloat!
    var yCen : CGFloat!
    var BlocksArr: NSMutableArray = []
    var CentersArr: NSMutableArray = []
    var timeCount : Int = 0
    var gameTimer : Timer = Timer()
    var empty: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MakeBlocks ()
    //  ranodmizedAction()
        self.ResetAction(Any.self)
    }
    
    func MakeBlocks () {
        
        BlocksArr = []
        CentersArr = []
        
        GameViewWidth =  GameView.frame.size.width
        BlockWidth = GameViewWidth / 4
        
        xCen = BlockWidth / 2
        yCen = BlockWidth / 2
        
        var lableNum : Int = 1
        
        
        for _ in 0..<4 {
            
        for _ in 0..<4{
            let BlockFrame : CGRect = CGRect(x:0,y:0,width:BlockWidth - 4, height: BlockWidth - 4)
               let block: MyLabel = MyLabel ( frame: BlockFrame)
            block.isUserInteractionEnabled = true
            let thisCen : CGPoint = CGPoint (x: xCen, y: yCen)
            
            block.center = thisCen
            block.OrigCen = thisCen
            
            CentersArr.add(thisCen)
            block.text = String (lableNum)
            lableNum+=1
            block.textAlignment = NSTextAlignment.center
            block.font = UIFont.systemFont(ofSize: 24)
            
        block.backgroundColor = #colorLiteral(red: 0.8768292271, green: 0.9284963214, blue: 1, alpha: 1)
        GameView.addSubview(block)
            BlocksArr.add(block)
            xCen = xCen + BlockWidth
    }
            xCen = BlockWidth / 2
            yCen = yCen + BlockWidth
    }
        let lastBlock : MyLabel = BlocksArr[15] as! MyLabel
        lastBlock.removeFromSuperview()
        BlocksArr.removeObject(at: 15)
    }
    
    func ranodmizedAction(){
        
        let tempCentersArr: NSMutableArray = CentersArr.mutableCopy() as! NSMutableArray
    for anyBlock in BlocksArr { //15 elements
    let randomIndex : Int = Int (arc4random()) % tempCentersArr.count
        let randomCenter : CGPoint = tempCentersArr [randomIndex]as! CGPoint
        
            (anyBlock as! MyLabel).center = randomCenter
        tempCentersArr.removeObject(at: randomIndex)
        
        }
        empty = tempCentersArr[0] as! CGPoint}
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let myTouch : UITouch = touches.first!
            if(BlocksArr.contains(myTouch.view as Any)){
                let touchView: MyLabel = (myTouch.view)! as! MyLabel
                let xDif: CGFloat = touchView.center.x - empty.x
                let yDif: CGFloat = touchView.center.y - empty.y
                let distance: CGFloat = sqrt(pow(xDif, 2)+pow(yDif, 2))
                if (distance == BlockWidth){
                    let tempCen : CGPoint = touchView.center
                    UIView.beginAnimations(nil, context: nil)
                    UIView.setAnimationDuration(0.2)
                    touchView.center = empty
                    UIView.commitAnimations()
                    
                    if ( touchView.OrigCen == empty){
                        touchView.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
                    } else {
                        touchView.backgroundColor = #colorLiteral(red: 0.8768292271, green: 0.9284963214, blue: 1, alpha: 1)
                    }
                    
                    empty = tempCen
                }
            }
        }
        

    
    @IBAction func ResetAction(_ sender: Any) {
        ranodmizedAction()
timeCount = 0
        gameTimer.invalidate()
        gameTimer = Timer.scheduledTimer(timeInterval: 1,
                                         target: self,
                                         selector: #selector(TimerAction),
                                         userInfo: nil,
                                         repeats: true)
        
    }
    
 @objc  func TimerAction(){
        timeCount += 1
    TimerLBL.text = String.init(format: "%02d\"", timeCount)
    }
    
}
//stored in a correct place
class MyLabel: UILabel {
    var OrigCen : CGPoint!
}


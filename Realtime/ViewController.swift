import UIKit
import Foundation

class ViewController: UIViewController, SocketIODelegate {
    let socketIO: SocketIO?
    
    required init (coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        socketIO = SocketIO(delegate: self)
//        socketIO?.connectToHost("realtimeserver.nodejitsu.com", onPort: 80, withParams: nil, withNamespace: "/game")
        socketIO?.connectToHost("realtimeserver.nodejitsu.com", onPort: 80)

    }
    
    override init (nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button   = UIButton.buttonWithType(UIButtonType.System) as UIButton
        button.frame = CGRectMake(CGRectGetWidth(view.frame)/2-100, CGRectGetHeight(view.frame)/2-40, 200, 80)
        button.backgroundColor = UIColor(red: 0.2421875, green: 0.64453125, blue: 0.8046875, alpha: 1)
        button.setTitle("Send new position", forState: UIControlState.Normal)
        button.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), forState: UIControlState.Normal)
        button.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 1), forState: UIControlState.Highlighted)
        button.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button)
    }

    func socketIODidConnect(socket: SocketIO!) {
        println("Did connect")
    }
    
    func socketIO(socket: SocketIO!, didReceiveMessage packet: SocketIOPacket!) {
        println("didReceiveMessage: \(packet.data)")
        
    }
    
    func socketIO(socket: SocketIO!, didReceiveJSON packet: SocketIOPacket!) {
        println("didReceiveJSON: \(packet.data)")

    }
    
    func socketIO(socket: SocketIO!, didReceiveEvent packet: SocketIOPacket!) {
        println("didReceiveEvent: \(packet.data)")
    }
    
    func buttonAction (sender:UIButton!) {
        var dict = [
            "x" : 50,
            "y" : 50
        ]
        
        socketIO?.sendEvent("newPosition", withData: dict)
    }
}

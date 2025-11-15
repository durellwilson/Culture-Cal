import Foundation
import Network
import OSLog

final class ConnectivityMonitor: ObservableObject {
    static let shared = ConnectivityMonitor()
    
    @Published private(set) var isConnected = true
    private let monitor = NWPathMonitor()
    private let logger = Logger(subsystem: Constants.bundleId, category: "ConnectivityMonitor")
    
    private init() {
        setupNetworkMonitoring()
    }
    
    private func setupNetworkMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied
                self?.logger.info("Network status changed: \(path.status == .satisfied ? "connected" : "disconnected")")
                
                NotificationCenter.default.post(
                    name: .connectivityStatusChanged,
                    object: path.status == .satisfied
                )
            }
        }
        
        let queue = DispatchQueue(label: "\(Constants.bundleId).network")
        monitor.start(queue: queue)
    }
    
    deinit {
        monitor.cancel()
    }
}

extension Notification.Name {
    static let connectivityStatusChanged = Notification.Name(Constants.Notification.connectivityStatusChanged)
}
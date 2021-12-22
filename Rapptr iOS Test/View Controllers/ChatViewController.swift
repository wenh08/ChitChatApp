 
import UIKit

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
 
 private var client: ChatClient = {
    let client = ChatClient()
    client.session = URLSession.shared
    return client
  }()

  private var messages: [Message]?

  @IBOutlet var chatTable: UITableView!

   override func viewDidLoad() {
    super.viewDidLoad()

    messages = [Message]()
    configureTable(tableView: chatTable)
    title = "Chat"

    client.fetchChatData { [weak self] messages in
      self?.messages = messages
      DispatchQueue.main.async {
        self?.chatTable.reloadData()
      }

    } error: { errorString in
      print(errorString ?? "some other error happend")
    }
  }

   private func configureTable(tableView: UITableView) {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(ChatTableViewCell.self, forCellReuseIdentifier: "ChatTableViewCell")
    tableView.tableFooterView = UIView(frame: .zero)

    tableView.estimatedRowHeight = 44
    tableView.rowHeight = UITableView.automaticDimension

    tableView.translatesAutoresizingMaskIntoConstraints = false

    tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
  }

   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: "ChatTableViewCell",
      for: indexPath
    ) as? ChatTableViewCell else {
      fatalError("Illegal configuration of ChatTableViewCell")
    }
    cell.setCellData(message: messages![indexPath.row])
    return cell
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return messages!.count
  }
 func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }

   @IBAction func backAction(_ sender: Any) {
    let mainMenuViewController = MenuViewController()
    navigationController?.pushViewController(mainMenuViewController, animated: true)
  }
}

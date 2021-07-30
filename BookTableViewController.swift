import UIKit

class BookTableViewController: UITableViewController
{
    
    var books: [Book] = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
       
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return books.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as! BookTableViewCell

        let book = books[indexPath.row]
        
        cell.update(with: book)
        
        cell.showsReorderControl = true

        return cell
    }

    // MARK: - Navigation
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue)
    {
        guard let source = segue.source as? BookFromTableViewController,
            let book = source.book else {return}
        
        if let indexPath = tableView.indexPathForSelectedRow
        {
            books.remove(at: indexPath.row)
            books.insert(book, at: indexPath.row)
            tableView.deselectRow(at: indexPath, animated: true)
        } else
        {
            books.append(book)
            tableView.reloadData()
        }
    }
    
    @IBSegueAction func editBook(_ coder: NSCoder, sender: Any?) -> BookFormViewController?
    {
        
        guard let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) else
        {
            return nil
        }
        
        let book = books[indexPath.row]
        
        return BookFormViewController(coder: coder, book: book)
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            // Delete the row from the data source
            books.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert
        {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
}

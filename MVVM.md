# MVVM in Swift

First if you don't know what is MVVM or why it's awesome, go check [this great article](http://www.sprynthesis.com/2014/12/06/reactivecocoa-mvvm-introduction/)

Each and everyone have their own implementation of MVVM.	
Here I'd like to present how I do it using a collection of extensions and tools I called [Swiftility](https://github.com/allbto/ios-swiftility)		
Swiftility tools are very simple and easily replacable by something like ReactiveCocoa or you name it

## Summary

MVVM has 3 main components:

#### Model

The same as in MVC. It represents data in application.	
Depending on your preference it may or may not encapsulate some additional business logic.

#### View

UI layer, UI in code, storyboards, xibs.	
Also reaction to user input. View in MVVM covers the presentation logic of controller in MVC.	
`View == UIView + UIViewController`		

Each **View** contain one instance of **View-Model**. In case your UIViewController has sub-UIViews or sub-UIViewControllers (UITableView with switch on a cell for example), I advise you to bring the events up to the main UIViewController that will talk to the **View-Model** and contain the binding/update view logic.

#### View-Model

Confusing name but completely different entity.		
Prepares data for future presentation. Also Responsible for gathering, interpreting & transforming of data.		
(aka View Coordinator)


## Model

```swift
/// Represents data. In this example we will use a plain object.
/// But you can imagine your own implementation with CoreData, Realm, etc.

/// In MVVM, info need to be passed to the View
/// But it needs to stay immutable, changed only by the View-Model
/// That's why each Model is a protocol with get only variables
/// It's only acceptable to pass protocols to View, no object.
/// So it doesn't really matter to the View what kind of implementation you have behind
protocol Post
{
	var id: String { get }
	var content: String { get }
	var createdAt: NSDate { get }

	/// Convenience variables/funcs
	var numberOfWords: Int { get }
}

/// Then comes the implementation of your choice
/// Here a simple object implementing Post protocol
class PostEntity: Post
{
	// MARK: - Properties

	/// Implementing protocol variables
	let id: String
	let content: String
	let createdAt: NSDate
}

/// Implementing custom/convenience var/func in a separate extension

// MARK: - Convenience
extension PostEntity
{
	var numberOfWords: Int {
		// Count and return number of words
	}
}

/// I decide to add the logic inside the model
/// Separated in two extensions, Model (local data logic) and API (network requests)

// MARK: - Model
extension PostEntity
{
	/// Example function that fetch and return local post from user
	func allUserPosts(userId: String) -> [PostEntity]
	{
		/// ...
	}
}

// MARK: - API
extension PostEntity
{
	/// Example function that fetch a list of post
	/// I usually use PromiseKit but you can easily switch to something similar (like a callback)
	func fetchRemotePost() -> Promise<[PostEntity]>
	{
		/// Run a network request
		/// Parse result into a list of PostEntity
		/// Return it via Promise, callback, etc.
	}
}
```

Side note: I'm aware that you can get the same immutable result using `struct`, but you cannot use `struct` with CoreData and Realm for example. So for the sake of consistency I prefer using this method.

## View

```swift
/// Handles the UI layer
/// Also passes user input to View-Model

/// Define class implement Swiftility ViewModelController protocol
class PostListViewController: UIViewController, ViewModelController
{
	// MARK: - Outlets

	@IBOutlet weak var tableView: UITableView!

	// MARK: - View Model

	/// Implementing ViewModelController protocol here
	/// Initial View instanciate it's own viewModel (here with lazy, first called in viewDidLoad)
	/// Detail Views have their viewModels instanciated by the initial View-Model (more on that on the View-Model section)
	/// That's why we need an explicitly unwrapped variable
	lazy var viewModel: PostListViewModel! = {
		/// Instanciate viewModel
		let vm = PostListViewModel(/* Pass any variable needed */)

		/// Using a Swiftility Dynamic variable from the viewModel here (more on that on the View-Model section)
		/// Binding value changes of the dynamic posts variable
		vm.posts.bind { posts in
			self.tableView.reloadData()
		}

		/// Return viewModel
		return vm
	}()

	// MARK: - Actions

	/// User request a post reload
	/// Ask viewModel to reload post list
	/// Changes will be applied in above binding
	@IBAction func reloadPosts(_: AnyObject)
	{
		self.viewModel.reloadPosts()
	}
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension PostListViewController: UITableViewDelegate, UITableViewDataSource
{
	/// Example of UITableViewDataSource implementation
	/// Returning the size of the posts dynamic variable ( varName.value to get the actual value out of the Dynamic )
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.viewModel.posts.value.count
    }

    /// Implementing action when a cell is selected
    /// Presents the detail of a post
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
    	let postDetailVC = /// Get a PostDetailViewController instance somehow, could also be in prepareForSegue

    	/// Like said above, initial View-Model instanciate detail View's View-Model
    	postDetailVC.viewModel = self.viewModel.viewModelForPost(index: indexPath.row)

    	/// Present postDetailVC
    }
}
```

```swift
/// Implementation of detail View
class PostDetailViewController: UIViewController, ViewModelController
{
	// MARK: - View Model

	/// Detail View has it's viewModel instanciated in the initial View
	/// So here we can bind Dynamic variables in the didSet trigger
	var viewModel: PostDetailViewModel! {
		didSet {

			/// Calling bindAndFire to bind and apply the changes as soon as viewModel is set
			viewModel.post.bindAndFire { post in
				/// Reload view with post info
			}
		}
	}
}
```

## View-Model

```swift
class PostListViewModel
{
	// MARK: - Dynamic

	/// Define dynamic array of post variable
	/// Note that it's an array of Post not PostEntity since the info passed to the View must be immutable
	var posts: Dynamic<[Post]>

	// MARK: - Properties

	/// Private list here of PostEntity because it will only be available for the View-Model
	private var _posts: [PostEntity]

	// MARK: - Life cycle

	init()
	{
		self._posts = /// Get the list of post somehow

		/// Casting PostEntity as Post to avoid Swift fatal error: array cannot be bridged from objective-c
		self.posts = Dynamic(_posts.map { $0 as Post })
	}

	// MARK: - View Models

	func viewModelForPost(index index: Int) -> PostDetailViewModel
	{
		/// Should include some guard to avoid out of bounds array but let's keep it simple for this example

		/// Passing mutable PostEntity to detail View-Model without the View knowing it
		return PostDetailViewModel(post: _posts[index])
	}
}
```

```swift
class PostDetailViewModel
{
	// MARK: - Dynamic

	/// Define dynamic post variable
	/// Note that it's a Post not PostEntity since the info passed to the View must be immutable
	var post: Dynamic<Post>

	// MARK: - Properties

	/// Private PostEntity because it will only be available for the View-Model
	private var _post: PostEntity

	// MARK: - Life cycle

	/// Defining the init used in the initial View-Model
	init(post: PostEntity)
	{
		self._post = post
		self.post = Dynamic(post)
	}
}
```

# That's all folks!

Don't forget to check [Swiftility](https://github.com/allbto/ios-swiftility) if you liked this. And if have any suggestions they are more than welcome.

You can also checkout the [MVVM example project](https://github.com/allbto/iOS-DynamicRegistration) I built using Swiftility and [PromiseKit](http://promisekit.org/).

## Author

Allan Barbato, allan.barbato@gmail.com

Thanks to [@DanielCech](https://github.com/DanielCech) for the article and explanation of MVVM components.	
Checkout his [ReactiveCocoa MVVM implementation example project](https://github.com/DanielCech/iOS-ReactiveRegistration)

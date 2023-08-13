# Assessment

The project is the submission from Rushit for the assessment give. The requirements of the assessments are as follows:

1. Create a simple sign in / sign up function by the aid of any of the available local storage options (UserDefaults, CoreData, KeyChain)
a. User can signup and their particulars got stored in any one of the local storage options
b. Once signup, user can signin and that their login credentials is to be stored as base64 on any one of the local storage options
2. Create simple list view by utilising API from
`https://www.themealdb.com/api.php?ref=apilist.fun`
a. Implement search by first letter to populate list
b. Implement meal details by id
c. Object “strMealThumb” must appear in the list view as image view, and must be
expandable and zoom-able
d. You are not limited to the design and approach in making the list and detail interface
of the app
e. You are to use Alamofire to handle the Restful interaction between the app and api
3. Create unit testing by using XCTest Framework
a. Unit test must be executable at least to perform basic test inorder to check model
and interaction with controller
b. As there’s API integration, it is expected that the unit test should cover
asynchronous operations test



# Project Details

### How to run?
For running the App, follow the standard procedure to run the app form Xcode.
Select an approprite target, and "run" (CMD + R) to view the app.
And for tests just press (CMD + U).

### Architecture
MVC with Singleton Managers

### 3rd part Libraires user
1. Alamofire - For Rest API interactions
2. Kingfisher - For image downloading and chaching
3. IQKeyboardManager - For handling for keyboard events

(All libraries are integrated through `Cocoapods`)

Currently the app only supports iOS Phone devices.
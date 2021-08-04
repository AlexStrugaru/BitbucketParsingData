# BitbucketParsingData

The project is written in Swift and SwiftUI
The structure is done based on MVVM pattern
- **Model**:
  Structures done based on JSON file
  The name of the parameters were set as the name of the JSON fields (as code improvement: CodingKey, or keycodingStrategy can be used for handling the parameter names)
- **ViewModel(APIManager)**:
  - contains the fetch request in which is send the url based on the initial url and "next" parameter value
  - was done using JSONDecoder
  - published values after the data is fetched
  - Error handling (4 cases treated)
- **Views**:
  ContainerView: 
     - Loading view
     - Alert view which shows the error type if the APIManager throws error
     - ScrollView which has the views grouped in VStack and HStack
     - Next button showed when there is non empty "next parameter"
     - On next button action the view loads more data
  DetailView: 
     - Detailed information of the respository
     - Website url parameter clickable, opens Safari
- **Pod file**: 
  contains the Kingfisher pod which downloads images based on the provided URL

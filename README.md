

# Motorcycle's Catalog App (Motolog)

## Overview
This app is created using swift promgamming language. the code use **VIPER** design pattern to make it scalable and easy to test. This app allows you to browse through motorcycle catalog and purchase it!.

>  it was just a prototype app, so the balance and motorcycle you purchase is not real. Since firebase is requirement, there are few functionality that it lacks like it still process the balance on the app instead of server, it probably achievable by using `Firebase cloud function` but it might cost some money 💰.


## Libraries
Here are the libraries that help this app to be built, big kudos to the creator of these libraries 🔥. 

- [Firestore] - Real-time cloud database by Firebase for storing, syncing, and querying data across applications.

- [Firebase Storage] - Cloud storage service within Firebase to securely store and serve user-generated content.

- [Firebase Authentication] - Firebase service for simplified user authentication and identity management in apps.

-  [Kingfisher] - pure-Swift library for downloading and caching images from the web!


## Installation
This app is created in **XCode version 15.0 beta (15A5160n)**. It might not be possible to run it in lower version of XCode, If that is the case please do let me know. 

1. Clone or download zip from https://bitbucket.org/lerepertoire/nawatechtest/src/main/

    > `git clone https://bitbucket.org/lerepertoire/nawatechtest/src/main/`

2. go to project directory

    > `cd insert_project_directory_here`

3. open `TestNawaTech.xcworkspace`

    > optional: you can also upgrade the pod if necessary by typing `pod update` in the terminal

4. run the project


## Notes
As I mentioned in the overview, when user purchase something, all of the balance deduction and addition still happen on the iOS app. There are things that can be improved, I can use native library like StoreKit to simulate payment when user do top up, and even use Push Notification capability when user's purchase of a motorcycle get rejected/approved by the "admin/seller" but I currently am not in a posession of a paid Apple developer account.

[//]: # 
[Firebase Authentication]: <https://firebase.google.com/docs/auth>
[Firebase Storage]: <https://firebase.google.com/docs/storage>
[Firestore]: <https://firebase.google.com/docs/firestore>
[Kingfisher]: <https://cocoapods.org/pods/Kingfisher>


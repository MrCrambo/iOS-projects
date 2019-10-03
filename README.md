# iOS-projects
 Applications for iOS devices using Machine Learning and Augmented Reality

## 1. Online Image Recognition

Online image recognition with ResNet50 pretrained model using device camera. Could be used other models from [Apple ML website page](https://developer.apple.com/machine-learning/models/). Also you can use your trained model instead of Apple's model, later here will be an example of how to do it.

##### Learned to use: 
- MLCore

##### Time spent
- 40 mins.

![animation](https://user-images.githubusercontent.com/14878297/65996637-762be800-e4a0-11e9-81f2-113e99d056d4.gif)

## 2. Image Recognition on Photo

Image recognition with ResNet50 model on photos chosen using picker(with camera and photo library). Predicted results is better than in first app. Also used auto layout with constraints for UI.

##### Learned to use: 
- MLCore
- Self created image picker

##### Time spent
- 1 hour.

<img src="https://user-images.githubusercontent.com/14878297/65996738-af645800-e4a0-11e9-8ac1-d5de83deedd7.jpeg" width="240" height="400" />

## 3. Face Detection using Flask server

This app allows you to choose photo using Instagram like image picker and send photo to Flask server where it will find similar actor from real world using facial landmarks.

Flask server with `dlib` library to find 68 landmarks on face and with more than 16000 actors in database. To find most similar actor I used KD-Tree. 

There is no code to Flask server and no link to server on app code.

##### Learned to use: 
- Alamofire
- Pods
- Instagram like picker
- Connection with Flask server
- Python Flask server deployment

##### Time spent
- 3 hours.

<img width="291" alt="Снимок экрана 2019-10-03 в 13 37 51" src="https://user-images.githubusercontent.com/14878297/66120365-5f41de80-e5e3-11e9-9dcd-74ec060894ec.png">

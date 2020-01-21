# VIPERPlayground

This is simplee VIPERPlayground which helps you to understand VIPER flow and it's responsiblities.

VIPER :

1.View: Responsibilty of View is to send user action to presenter and shows whatever presenter tells it.

2.Presenter: The responsibility of Presenter is to get data from Interactor on user actions and after getting data from interactor it send it to the view to show it. It also asks the router/Wireframe for navigation \.

3.Interactor: It Contains all business logic(Call services etc.)

4.Entity: It contains basic model object used by Interactor

5.Router: It has all navigation logic for describing which screens are to be shown.

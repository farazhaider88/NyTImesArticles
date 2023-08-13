A simple app to hit the NY Times Most Popular Articles API and show a list of articles, that shows details when items on the list are tapped (a typical master/detail app).
We'll be using the most viewed section of this API. http://api.nytimes.com/svc/mostpopular/v2/mostviewed/{section}/{period}.json?api- key=sample-key To test this API, you can use all-sections for the section path component in the URL above and 7 for period (available period values are 1, 7 and 30, which represents how far back, in days, the API returns results for).

Installation
	•	Installation by cloning the repository
	•	Go to directory
	•	use command + B or Product -> Build to build the project
	•	Press run icon in Xcode or command + R to run the project on Simulator

Tools And Resources Used
	•	Package - Swift Package Manager, or SPM, lets you manage your project dependencies, allowing you to import libraries into your applications with ease.

Architecture
This project uses MVVM design pattern with Combine and project is fully developed in Swift.

Running The Tests Manually
Follow the steps to get test case reports:
	•	Enable coverage Data under test schema section:
	•	Select the Test Icon by pressing and holding Xcode Run Icon OR press Command+Control+U
	•	In the Project Navigator under Test Navigator tab, check test status and coverage

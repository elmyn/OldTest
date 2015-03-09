# OldTest
OldTest, sorry for lack of design and no cocapods

Objectives:
Please follow the below objectives as closely as you can
•	Develop a universal application that will work on both iPhone and iPad devices
o	The application should be designed to best work on an iPhone and should scale up to work on an iPad (not the default 1x/2x option)
o	This application should have a deployment target of iOS version 5.0 or greater
o	This application should of course use the core framework/libraries but feel free to use any open source framework/libraries as appropriate
o	The application should look as visually exciting and creative as possible (to a reasonable limit with the timeframe for the test) and not look like it’s something that’s been “taken off the shelf”
o	This application should not leak any memory
•	Start-up
o	The application should on start-up read the contents of the JSON file at the following network location - http://www.konzeptual.es/sb/gamesDetail.json
•	Please see attached example
o	The JSON file describes some details for a list of games. Two of the details are URL’s to images (full image and icon). These images should be downloaded using the URL’s
o	The application should use asynchronous URL connections for both the JSON and image requests
•	The main application thread should not block during download activities
o	Both the JSON and image data should be persisted to local storage so it’s not requested each time the application starts. The JSON file should be checked once every 24 hours and if the image URL’s have changed, then re-download new data
•	Main functionality
o	Once the data has been downloaded, the list of games should be shown to the user using the full image and game name
o	When the user clicks on the image, the user should then be shown details for that particular game – the game icon, game name, rating, description, etc
o	The user should also have an ability to go back to the list of games
•	Bonus steps
o	Display the content (game list and game details) in a different way depending on whether the user is viewing the device in portrait or landscape orientation
•	Maybe different layout / UI components?
o	Display a completely different user interface for the iPad version
•	Maybe one screen instead of multiple?
Notes:
Your solution will be tested for: 
•	You should not use story boards to generate the UI. All UI’s should be developed completely in code but feel free to use other 3rd party libraries to assist in quickly and easily producing a polished and nice looking user interface
•	Structure and code
•	Completeness of solution and adherence to objectives 
•	Creativity of the solution (visually and from a code perspective) and how well presented it is 
Please zip up your test solution retaining the folder structure (source code and binary) and email it to your recruitment agent who will forward it on for consideration 

# Objective
This program is meant to allow for easy viewing and analyzation of scouting data at FRC tournaments
It was originally designed by team 7617 for the 2025 season. 
It is programmed in Godot game engine, using GDscript

# How-To-Configure

When opening the program, Select first if you want to used saved config data(select no if you have not configured before)
Drag and Drop a JSON file of relevant raw scouting data(by the match)

all data must be on one spreadsheet, and the first column must be a unique identifier for that column that is NOT the team number
all statistics must have their respective name in the top row of the spreadsheet.
This program was tested using Google sheets exported using a JSON exporter extension
Said Extension can be found here https://workspace.google.com/marketplace/app/export_sheet_data/903838927001

You will then be asked to select which statistics to track. all tracked statistics must be convertible to ints or floats(any number)
There are special tracking for team numbers and whether the robot died/broke. please select these accordingly
Team number is used for identification of summarized data
Died/broke is used to exclude matches where the robot died from the summarized data(it will still show correct percentages for Died/broke)
Other than team number and died/broke, click track and don't track respective to what you would like to do for those statistics
all tracked statistics MUST be convertible to a int or a float, otherwise the program will crash

currently about 9-10 statistics(other than died/broke and team number) can be tracked at once. 
any more will not cause the program to crash, but will cause the statistics over the limit to be unviewable due to existing offscreen
I plan to add support for horizontal scrolling in the future, yet as of me writing this that has not been completed.

After configuring which statistics to track, you will be asked to provide which teams you would to track. 
There is also a track all teams in list in case you do not need this feature
This is useful for combining multiple tournaments worth of data, but only tracking the teams from your current tournament

At any point in the configuration process(other than the spreadsheet import) you will have the option to use previous configuration data.
This can be used if you only want to reconfigure either the tracked statistics or tracked teams. These buttons should only be used if you have configured before

# How-To-Use-|-Main-View

Main view is meant to view data before alliance selection, and as a pathway to other views

In the main view, there is one main element(a chart of all teams and statistics that were configured as tracked), and a button to bring you to selection view
The chart can be sorted by any statistic except team number by simply clicking the Statistic name, and a white arrow will show next to the statistic name to signify whether it is sorted descending or ascending
You cannot sort by the team number

You can click on any of the team's numbers, and it will bring you to it's respective team's individual view

You may also click the large button at the top of the screen labeled selection view. this will bring you to the selection view

# How-To-Use-|-Individual-View

In the individual view, you can view a chart with all matches played by the selected team
All matches are displayed in order and cannot be sorted.

This is useful for viewing a teams individual matches during the day
For example if a robot broke at the beginning of the day and got fixed, you can see that a high died/broke rate was centered around one time period

# How-To-Use-|-Selection-View

This view is meant for during alliance selection, while on the field, and making picks.

There is 8 blue boxes at the top of the screen representing each alliance.
The green box represents where the next team picked will go.

either click on a teams name or type their number into the text box to select them. 
This team will now disappear from the chart, allowing you to sort the remaining teams by any tracked statistics
selected teams are saved when switching between scenes(selection view, individual view, and main view)

Currently the only way to reset a selection is to relaunch the program
however i intend to add a way to reset it without reloading the program in the future

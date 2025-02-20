extends Node
var whitelist:Array = ["teamNumber","died","removedAlgaeFromReef","teleopSuccessfulDeep","teleopL4","teleopL3","teleopProcessor",
"teleopNet","teleopL2","teleopL1","matchesplayed"]
var current_teams:Array = ["447","2867","97","9644","1073","501","5422","166","4909","1768"
,"8567","5687","1153","190","8724","2342","4761","1729","1501","88","2877"]
var team_number_ID:String = "teamNumber"

var save_path := "user://frc_scouting_app_save_data.json"

var save_data:Dictionary = {
	"whitelist":whitelist,
	"current_teams":current_teams,
	"team_number_ID":team_number_ID
}
# To save data
func save() -> void:
	save_data = {
	"whitelist":whitelist,
	"current_teams":current_teams,
	"team_number_ID":team_number_ID
	}
	var json_string := JSON.stringify(save_data)

  # We will need to open/create a new file for this data string
	var file_access := FileAccess.open(save_path, FileAccess.WRITE)
	if not file_access:
		print("An error happened while saving data: ", FileAccess.get_open_error())
		return
	file_access.store_line(json_string)
	file_access.close()

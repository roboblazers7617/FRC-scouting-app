extends Node
var whitelist:Array = []
var current_teams:Array = []
var team_number_ID:String
var spreadsheet_path="user://frc_scouting_app_spreadsheet_data.json"
var save_path := "user://frc_scouting_app_save_data.json"
var spreadsheet
var died_ID:String = "died"
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
	"team_number_ID":team_number_ID,
	"died_ID":died_ID
	}
	var json_string := JSON.stringify(save_data)

  # We will need to open/create a new file for this data string
	DirAccess.remove_absolute(save_path)
	var file_access := FileAccess.open(save_path, FileAccess.WRITE)
	if not file_access:
		print("An error happened while saving data: ", FileAccess.get_open_error())
		return
	file_access.store_line(json_string)
	file_access.close()
	
func save_spreadsheet(spreadsheet:Dictionary):
	DirAccess.remove_absolute(spreadsheet_path)
	var json_string := JSON.stringify(spreadsheet)
	var file_access := FileAccess.open(spreadsheet_path, FileAccess.WRITE)
	if not file_access:
		print("An error happened while saving data: ", FileAccess.get_open_error())
		return
	file_access.store_line(json_string)
	file_access.close()
func load_spreadsheet():
	var filestring = FileAccess.get_file_as_string(spreadsheet_path)
	if filestring != null:
		spreadsheet = JSON.parse_string(filestring)

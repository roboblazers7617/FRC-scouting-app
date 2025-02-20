extends Control
@onready var center_text_label: Label = %"center text label"
@onready var buttons: Node2D = %buttons
@onready var don_t_track: Button = %"don't track"
@onready var track: Button = %track
@onready var is_team_number_id: Button = %"Is team number ID"
@onready var question_label: Label = %question_label
@onready var main: Node2D = %main
@onready var use_saved_data: Node2D = %use_saved_data
var spreadsheet_path:="user://frc_scouting_app_spreadsheet_data.json"
var main_scene:PackedScene = load("res://imports.tscn")
var current_ans:int
signal is_answered(ans:int)
var save_path := "user://frc_scouting_app_save_data.json"
var configured:bool = false
var saved_ans:bool
signal use_saved()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("/")
	get_window().files_dropped.connect(files_import)
	var filestring = FileAccess.get_file_as_string(save_path)
	var json_data
	var spreadsheet
	if filestring != null:
		main.hide()
		use_saved_data.show()
		spreadsheet = JSON.parse_string(filestring)
		Settings.whitelist =spreadsheet["whitelist"]
		Settings.current_teams =spreadsheet["current_teams"]
		Settings.team_number_ID =spreadsheet["team_number_ID"]
		Settings.save()
		main.hide()
		use_saved_data.show()
		await use_saved
		if saved_ans:
			get_tree().change_scene_to_packed(main_scene)
		else:
			configured = false
			use_saved_data.hide()
			main.show()
	else:
		print("path does not lead to a file")
		
		

func files_import(files:Array):
	if !configured:
		main.show()
		use_saved_data.hide()
		configured = true
		print(files)
		var spreadsheet:Dictionary
		for i in files:
			if i.ends_with(".json"):
				print("valid file")
				print(i)
				var filestring = FileAccess.get_file_as_string(i)
				var json_data
				if filestring != null:
					spreadsheet = JSON.parse_string(filestring)
				else:
					print("path does not lead to a file")
				if spreadsheet == null:
					print("failed to parse json")
				break
			
		if spreadsheet:
			center_text_label.hide()
			question_label.show()
			don_t_track.show()
			track.show()
			is_team_number_id.hide()
			question_label.text = "Does " +str(len(spreadsheet.keys()))+" seem like a reasonable number of matches scouted"
			await self.is_answered
			if current_ans == 0:
				for i in spreadsheet.keys():
					question_label.text = "is "+i+" the spreadsheet you want to track?"
					await self.is_answered
					if current_ans == 1:
						spreadsheet = spreadsheet.get(i)
						print(spreadsheet.keys())
						break
			don_t_track.show()
			track.show()
			is_team_number_id.show()
			don_t_track.text = "Don't Track"
			track.text = "Track"
			is_team_number_id.text = "Is Team Number"
			for i in spreadsheet.values()[0].keys():
				print(i)
				question_label.text = "Do you want to track "+i+"?
				Only ints or floats will work(other than team num)"
				await self.is_answered
				if current_ans ==1:
					Settings.whitelist.append(i)
				if current_ans == -1:
					Settings.team_number_ID = i
		else:
			center_text_label.text = "Only a JSON is supported"
		Settings.save()
		get_tree().change_scene_to_packed(main_scene)


func _on_dont_track_button_down() -> void:
	current_ans = 0
	is_answered.emit(0)


func _on_track_button_down() -> void:
	current_ans = 1
	is_answered.emit(1)

func _on_is_team_number_id_button_down() -> void:
	current_ans = -1
	is_team_number_id.hide()
	is_answered.emit(-1)


func _on_yes_button_down() -> void:
	saved_ans = true
	use_saved.emit()
	print("y")

func _on_no_button_down() -> void:
	saved_ans = false
	use_saved.emit()
	print("false")
	
func save_spreadsheet(spreadsheet):
	var json_string := JSON.stringify(spreadsheet)
	var file_access := FileAccess.open(spreadsheet_path, FileAccess.WRITE)
	if not file_access:
		print("An error happened while saving data: ", FileAccess.get_open_error())
		return
	file_access.store_line(json_string)
	file_access.close()

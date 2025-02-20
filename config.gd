extends Control
@onready var center_text_label: Label = %"center text label"
@onready var buttons: Node2D = %buttons
@onready var don_t_track: Button = %"don't track"
@onready var track: Button = %track
@onready var is_team_number_id: Button = %"Is team number ID"
@onready var question_label: Label = %question_label
@onready var main: Node2D = %main
@onready var use_saved_data: Node2D = %use_saved_data
@onready var line_edit: LineEdit = %LineEdit
@onready var button: Button = %Button
@onready var done: Button = %done
@onready var item_list: ItemList = %ItemList
var spreadsheet:Dictionary
@onready var config_teams: Node2D = %config_teams
@onready var is_died: Button = %"Is Died"




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
	config_teams.hide()
	get_window().files_dropped.connect(files_import)
	var filestring = FileAccess.get_file_as_string(save_path)
	var json_data
	print(filestring)
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
		Settings.whitelist = []
		main.show()
		use_saved_data.hide()
		configured = true
		print(files)
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
			Settings.save_spreadsheet(spreadsheet.values()[0])
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
					Settings.whitelist.append(i)
		else:
			center_text_label.text = "Only a JSON is supported"
		Settings.save()
		Settings.save_spreadsheet(spreadsheet)
		configure_teams()


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
	
func configure_teams():
	main.hide()
	use_saved_data.hide()
	config_teams.show()
	


func _on_button_button_down() -> void:
	Settings.whitelist = []
	for i in spreadsheet.values():
		if i[Settings.team_number_ID] not in Settings.current_teams:
			Settings.current_teams.append(i[Settings.team_number_ID])
	get_tree().change_scene_to_packed(main_scene)
	


func _on_line_edit_text_submitted(new_text: String) -> void:
	if new_text.is_valid_int() and new_text not in Settings.current_teams:
		line_edit.placeholder_text = "Enter what team you want to track"
		Settings.current_teams.append(new_text)
		item_list.add_item(new_text,null,false)
	elif new_text in Settings.current_teams:
		line_edit.placeholder_text = "You Have Already Entered That"
	else:
		line_edit.placeholder_text = "Enter a Valid Team Number"


func _on_done_button_down() -> void:
	get_tree().change_scene_to_packed(main_scene)


func _on_is_died_button_down() -> void:
	pass # Replace with function body.

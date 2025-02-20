extends Node2D
@onready var title: Label = %title
var spreadsheet_path:String = Settings.spreadsheet_path
var spreadsheet_data:Dictionary
@onready var chart: chart = %chart
@onready var button: Button = %Button
var main_scene:PackedScene = preload("res://imports.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spreadsheet_data = read_file(spreadsheet_path)
	if spreadsheet_data == null:
		print("error reading JSON")
	Globals.setup_individual.connect(setup)
	Globals.im_ready()

func setup(team:String):
	print("setup")
	var tracked_matches:Array = []
	title.text = team
	for i in spreadsheet_data.keys():
		if str(spreadsheet_data[i][Settings.team_number_ID]) == team:
			tracked_matches.append(i)
	for i in spreadsheet_data[tracked_matches[0]].keys():
			if i in Settings.whitelist:
				chart.create_column(i)
	for i in tracked_matches:
		for k in spreadsheet_data[i].keys():
			if k in Settings.whitelist:
				chart.add_item_to_column(chart.columnIDs[k],str(spreadsheet_data[i][k]))
	#chart.setup_column_seperators(len(chart.columnIDs.keys()),len(tracked_matches))
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func read_file(path:String):
	var filestring = FileAccess.get_file_as_string(path)
	var json_data
	if filestring != null:
		json_data = JSON.parse_string(filestring)
	else:
		print("path does not lead to a file")
	if json_data == null:
		print("failed to parse json")
	
	return json_data


func _on_button_button_down() -> void:
	get_tree().change_scene_to_packed(main_scene)

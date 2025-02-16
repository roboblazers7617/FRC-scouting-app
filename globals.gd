extends Node
var individual:PackedScene = preload("res://individual_view.tscn")
signal sort_by_column(column_name:String)
signal setup_individual(team:String)
var individual_team:String
func switch_to_individual(team:String):
	individual_team = team
	get_tree().change_scene_to_packed(individual)
	await get_tree().create_timer(.25).timeout

func im_ready():
	setup_individual.emit(individual_team)

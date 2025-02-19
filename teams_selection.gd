extends Node2D
var captain_mode:bool = true
var alliances:Array = []
var target:Label
var next_target:Label
var blank = StyleBoxFlat.new()
var next = StyleBoxFlat.new()
func _ready() -> void:
	next.bg_color = Color(0,1,0)
	blank.bg_color = Color(1,1,1,0)
	$"Alliance 1/HBoxContainer/Team 1".add_theme_stylebox_override("normal",next)
	#target.add_theme_stylebox_override("normal",blank)
	#8 color rects are used as folders to store labels, and hbox container is used to keep all labels aligned
	#append all 8 color rects to a list
	alliances.append($"Alliance 1")
	alliances.append($"Alliance 2")
	alliances.append($"Alliance 3")
	alliances.append($"Alliance 4")
	alliances.append($"Alliance 5")
	alliances.append($"Alliance 6")
	alliances.append($"Alliance 7")
	alliances.append($"Alliance 8")
	
	
func add_pick(pick:String):
	# checks if a label's text is blank, if so, it fills it with the team's name
	#once all alliances are full, changes a global variable to prevent future picking
	if $"Alliance 1/HBoxContainer/Team 1".text == "":
		target = $"Alliance 1/HBoxContainer/Team 1"
		next_target = $"Alliance 1/HBoxContainer/Team 2"
	elif $"Alliance 1/HBoxContainer/Team 2".text == "":
		target = $"Alliance 1/HBoxContainer/Team 2"
		next_target = $"Alliance 2/HBoxContainer/Team 1"
	elif $"Alliance 2/HBoxContainer/Team 1".text == "":
		target = $"Alliance 2/HBoxContainer/Team 1"
		next_target = $"Alliance 2/HBoxContainer/Team 2"
	elif $"Alliance 2/HBoxContainer/Team 2".text == "":
		target = $"Alliance 2/HBoxContainer/Team 2"
		next_target = $"Alliance 3/HBoxContainer/Team 1"
	elif $"Alliance 3/HBoxContainer/Team 1".text == "":
		target = $"Alliance 3/HBoxContainer/Team 1"
		next_target = $"Alliance 3/HBoxContainer/Team 2"
	elif $"Alliance 3/HBoxContainer/Team 2".text == "":
		target = $"Alliance 3/HBoxContainer/Team 2"
		next_target = $"Alliance 4/HBoxContainer/Team 1"
	elif $"Alliance 4/HBoxContainer/Team 1".text == "":
		target = $"Alliance 4/HBoxContainer/Team 1"
		next_target = $"Alliance 4/HBoxContainer/Team 2"
	elif $"Alliance 4/HBoxContainer/Team 2".text == "":
		target = $"Alliance 4/HBoxContainer/Team 2"
		next_target = $"Alliance 5/HBoxContainer/Team 1"
	elif $"Alliance 5/HBoxContainer/Team 1".text == "":
		target = $"Alliance 5/HBoxContainer/Team 1"
		next_target = $"Alliance 5/HBoxContainer/Team 2"
	elif $"Alliance 5/HBoxContainer/Team 2".text == "":
		target = $"Alliance 5/HBoxContainer/Team 2"
		next_target = $"Alliance 6/HBoxContainer/Team 1"
	elif $"Alliance 6/HBoxContainer/Team 1".text == "":
		target = $"Alliance 6/HBoxContainer/Team 1"
		next_target = $"Alliance 6/HBoxContainer/Team 2"
	elif $"Alliance 6/HBoxContainer/Team 2".text == "":
		target = $"Alliance 6/HBoxContainer/Team 2"
		next_target = $"Alliance 7/HBoxContainer/Team 1"
	elif $"Alliance 7/HBoxContainer/Team 1".text == "":
		target = $"Alliance 7/HBoxContainer/Team 1"
		next_target = $"Alliance 7/HBoxContainer/Team 2"
	elif $"Alliance 7/HBoxContainer/Team 2".text == "":
		target = $"Alliance 7/HBoxContainer/Team 2"
		next_target = $"Alliance 8/HBoxContainer/Team 1"
	elif $"Alliance 8/HBoxContainer/Team 1".text == "":
		target = $"Alliance 8/HBoxContainer/Team 1"
		next_target = $"Alliance 8/HBoxContainer/Team 2"
	elif $"Alliance 8/HBoxContainer/Team 2".text == "":
		target = $"Alliance 8/HBoxContainer/Team 2"
		next_target = $"Alliance 8/HBoxContainer/Team 3"
	elif $"Alliance 8/HBoxContainer/Team 3".text == "":
		target = $"Alliance 8/HBoxContainer/Team 3"
		next_target = $"Alliance 7/HBoxContainer/Team 3"
	elif $"Alliance 7/HBoxContainer/Team 3".text == "":
		target = $"Alliance 7/HBoxContainer/Team 3"
		next_target = $"Alliance 6/HBoxContainer/Team 3"
	elif $"Alliance 6/HBoxContainer/Team 3".text == "":
		target = $"Alliance 6/HBoxContainer/Team 3"
		next_target = $"Alliance 5/HBoxContainer/Team 3"
	elif $"Alliance 5/HBoxContainer/Team 3".text == "":
		target = $"Alliance 5/HBoxContainer/Team 3"
		next_target = $"Alliance 4/HBoxContainer/Team 3"
	elif $"Alliance 4/HBoxContainer/Team 3".text == "":
		target = $"Alliance 4/HBoxContainer/Team 3"
		next_target = $"Alliance 3/HBoxContainer/Team 3"
	elif $"Alliance 3/HBoxContainer/Team 3".text == "":
		target = $"Alliance 3/HBoxContainer/Team 3"
		next_target = $"Alliance 2/HBoxContainer/Team 3"
	elif $"Alliance 2/HBoxContainer/Team 3".text == "":
		target = $"Alliance 2/HBoxContainer/Team 3"
		next_target = $"Alliance 1/HBoxContainer/Team 3"
	elif $"Alliance 1/HBoxContainer/Team 3".text == "":
		target = $"Alliance 1/HBoxContainer/Team 3"
		next_target = null
		Globals.selection_filled = true
	target.text = pick
	target.add_theme_stylebox_override("normal",blank)
	if next_target:
		next_target.add_theme_stylebox_override("normal",next)

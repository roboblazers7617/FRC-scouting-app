extends Node2D
var captain_mode:bool = true
var alliances:Array = []

func _ready() -> void:
	alliances.append($"Alliance 1")
	alliances.append($"Alliance 2")
	alliances.append($"Alliance 3")
	alliances.append($"Alliance 4")
	alliances.append($"Alliance 5")
	alliances.append($"Alliance 6")
	alliances.append($"Alliance 7")
	alliances.append($"Alliance 8")
func add_pick(pick:String):
	#for i in alliances:
		#print(i.$"HBoxContainer".$"Team 1".text)
		#if i.$"HBoxContainer".$"Team 1".text == "":
			#i.$"HBoxContainer".$"Team 1".text = pick
			#break
	if $"Alliance 1/HBoxContainer/Team 1".text == "":
		$"Alliance 1/HBoxContainer/Team 1".text = pick
	elif $"Alliance 2/HBoxContainer/Team 1".text == "":
		$"Alliance 2/HBoxContainer/Team 1".text = pick
	elif $"Alliance 3/HBoxContainer/Team 1".text == "":
		$"Alliance 3/HBoxContainer/Team 1".text = pick
	elif $"Alliance 4/HBoxContainer/Team 1".text == "":
		$"Alliance 4/HBoxContainer/Team 1".text = pick
	elif $"Alliance 5/HBoxContainer/Team 1".text == "":
		$"Alliance 5/HBoxContainer/Team 1".text = pick
	elif $"Alliance 6/HBoxContainer/Team 1".text == "":
		$"Alliance 6/HBoxContainer/Team 1".text = pick
	elif $"Alliance 7/HBoxContainer/Team 1".text == "":
		$"Alliance 7/HBoxContainer/Team 1".text = pick
	elif $"Alliance 8/HBoxContainer/Team 1".text == "":
		$"Alliance 8/HBoxContainer/Team 1".text = pick
	elif $"Alliance 1/HBoxContainer/Team 2".text == "":
		$"Alliance 1/HBoxContainer/Team 2".text = pick
	elif $"Alliance 2/HBoxContainer/Team 2".text == "":
		$"Alliance 2/HBoxContainer/Team 2".text = pick
	elif $"Alliance 3/HBoxContainer/Team 2".text == "":
		$"Alliance 3/HBoxContainer/Team 2".text = pick
	elif $"Alliance 4/HBoxContainer/Team 2".text == "":
		$"Alliance 4/HBoxContainer/Team 2".text = pick
	elif $"Alliance 5/HBoxContainer/Team 2".text == "":
		$"Alliance 5/HBoxContainer/Team 2".text = pick
	elif $"Alliance 6/HBoxContainer/Team 2".text == "":
		$"Alliance 6/HBoxContainer/Team 2".text = pick
	elif $"Alliance 7/HBoxContainer/Team 2".text == "":
		$"Alliance 7/HBoxContainer/Team 2".text = pick
	elif $"Alliance 8/HBoxContainer/Team 2".text == "":
		$"Alliance 8/HBoxContainer/Team 2".text = pick
	elif $"Alliance 1/HBoxContainer/Team 3".text == "":
		$"Alliance 1/HBoxContainer/Team 3".text = pick
	elif $"Alliance 2/HBoxContainer/Team 3".text == "":
		$"Alliance 2/HBoxContainer/Team 3".text = pick
	elif $"Alliance 3/HBoxContainer/Team 3".text == "":
		$"Alliance 3/HBoxContainer/Team 3".text = pick
	elif $"Alliance 4/HBoxContainer/Team 3".text == "":
		$"Alliance 4/HBoxContainer/Team 3".text = pick
	elif $"Alliance 5/HBoxContainer/Team 3".text == "":
		$"Alliance 5/HBoxContainer/Team 3".text = pick
	elif $"Alliance 6/HBoxContainer/Team 3".text == "":
		$"Alliance 6/HBoxContainer/Team 3".text = pick
	elif $"Alliance 7/HBoxContainer/Team 3".text == "":
		$"Alliance 7/HBoxContainer/Team 3".text = pick
	elif $"Alliance 8/HBoxContainer/Team 3".text == "":
		$"Alliance 8/HBoxContainer/Team 3".text = pick
		Globals.selection_filled = true

extends LineEdit


func _ready() -> void:
	placeholder_text = "Enter Team Number"
func _on_text_submitted(new_text: String) -> void:
	text = ""
	if new_text in Settings.current_teams:
		placeholder_text = "Enter Team Number"
		Globals.activate_pick.emit(new_text)
	else:
		placeholder_text = "Enter a Valid Team Number"

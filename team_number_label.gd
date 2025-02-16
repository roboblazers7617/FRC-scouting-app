extends Label

func _init() -> void:
	self.gui_input.connect(on_input)
	
func on_input(input_event:InputEvent):
	#print(text)
	if input_event is InputEventMouseButton and input_event.pressed and input_event.button_index == 1:
		#print("clicked")
		Globals.switch_to_individual(self.text)

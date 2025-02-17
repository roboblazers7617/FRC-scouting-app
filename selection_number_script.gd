extends Label


func _init() -> void:
	self.gui_input.connect(on_input)
	
func _ready() -> void:
	self.label_settings = LabelSettings.new()
	self.label_settings.font_size = 50
func on_input(input_event:InputEvent):
	#print(text)
	if input_event is InputEventMouseButton and input_event.pressed and input_event.button_index == 1 and !Globals.selection_filled:
		Globals.activate_pick.emit(self.text)

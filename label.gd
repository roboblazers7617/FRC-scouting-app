extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.gui_input.connect(on_input)
	#print(self.text)
	#print(self.mouse_filter)
#
#func _physics_process(delta: float) -> void:
	#print(text)
	#print(gui_input.is_connected(on_input))
	#print(mouse_filter)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func on_input(input_event:InputEvent):
	#print(text)
	if input_event is InputEventMouseButton and input_event.pressed and input_event.button_index == 1:
		#print("clicked")
		Globals.sort_by_column.emit(text)
	

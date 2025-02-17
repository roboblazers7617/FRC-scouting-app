extends ScrollContainer
var old_pos:int = self.scroll_vertical

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.get_v_scroll_bar().modulate = Color(0, 0, 0, 0)
	#self.scroll_started.connect(scroll_starter)
func _process(delta: float) -> void:
	if self.scroll_vertical != old_pos:
		scroll_starter()
		old_pos = self.scroll_vertical
func scroll_starter():
	print("triggerd")
	Globals.import_scroll_started.emit(self)

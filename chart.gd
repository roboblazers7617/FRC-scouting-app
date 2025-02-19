class_name chart extends Node2D
var last_column_position:Vector2 = Vector2(0,0)
var columns:Array = []
var columnIDs:Dictionary = {}
var last_ID:int = 0
var VboxID:Dictionary = {}
var Scrollers:Array = []
@export var lblwidth:int = 150
@export var lblheight:int = 50
@export var chart_height:int = 1080
var lbllocations:Dictionary = {}
var seperators:Dictionary = {}
var run_before:bool = false
var copy_of_lbllocations:Dictionary
var column_script:Script = load("res://label.gd")
var active_scroller:ScrollContainer
var team_number_script:Script = load("res://team_number_label.gd")
@export var individual_ready:bool = false
@export var selection_ready:bool = false
var scroller_script:Script = preload("res://scroll_container.gd")
var selection_number_script = preload("res://selection_number_script.gd")


func _ready() -> void:
	#connects a signal, whenever the signal is emitted, the function import scroll started is called with the argument of the signal
	Globals.import_scroll_started.connect(import_scroll_started)





func create_column(column_name:String):
	#creates a new column with name column_name
	#creates a new label(text box)
	var new_label = Label.new()
	#allows the label to detect the mouse
	new_label.mouse_filter = 1
	#sets the text of the label to column_name
	new_label.text = column_name
	#makes text centered in the label
	new_label.horizontal_alignment = 1
	new_label.vertical_alignment = 1
	#if the column is not teamNumber, adds a script to sort by that column value whenever the label is clicked
	if column_name != "teamNumber":
		new_label.set_script(column_script)
	#adds the label as a child of the chart
	self.add_child(new_label)
	#sets the label's size to the variables lblwidth and lblheight
	new_label.size = Vector2(lblwidth,lblheight)
	#moves the label to the next position defined by variable last_column_position
	new_label.position = last_column_position
	#moves the last_column_position by the width of the label to prepare it for the next column
	last_column_position+=Vector2(lblwidth,0)
	#adds the new label to an array of columns, this array will be used to access properties of these labels
	columns.append(new_label)
	#adds a new stylebox, generates a random color(seeded) with a minimum rgb val(1.0 scale) of 0 and a max of .7
	#the seed is defined by the length of a the columnIDs dictionary
	var new_sb = StyleBoxFlat.new()
	new_sb.bg_color = random_color(0,.7,len(columnIDs.keys()))
	new_label.add_theme_stylebox_override("normal",new_sb)
	#adds the column's index in the columns array as a value with the key as the title of the column
	columnIDs[column_name] = last_ID
	#adds an empty array to a dictionary lbllocations with a key of columns ID, this will be used to access the items of the column
	lbllocations[str(last_ID)] = []
	#adds an empty array to a dictionary seperators with a key of columns ID, this will be used to access the seperators of the column
	seperators[str(last_ID)] = []
	#increases the ID to prepare it for the next column
	last_ID +=1
	
	
func set_active_scroller(scroller:ScrollContainer):
	active_scroller = scroller
	
		
func random_color(cap:float,minimum:float,seed:int)->Color:
	var rng:RandomNumberGenerator = RandomNumberGenerator.new()
	rng.seed = seed
	var r:float =rng.randf_range(minimum,cap)
	rng.seed = seed*7617
	var g:float = rng.randf_range(minimum,cap)
	rng.seed = seed*7617*15*1
	var b:float =rng.randf_range(minimum,cap)
	return Color(r,g,b)
func add_item_to_column(ID:int,new_value:String):
	var Vbox:VBoxContainer
	if str(ID) in VboxID.keys():
		Vbox =VboxID[str(ID)]
	else:
		var scrollbox = ScrollContainer.new()
		scrollbox.set_script(scroller_script)
		Vbox = VBoxContainer.new()
		VboxID[str(ID)] = Vbox
		Vbox.alignment = 1
		self.add_child(scrollbox)
		scrollbox.position = Vector2(ID*lblwidth,lblheight)
		scrollbox.scroll_vertical_custom_step = 50
		scrollbox.size = Vector2(lblwidth,chart_height-lblheight)
		Scrollers.append(scrollbox)
		scrollbox.add_child(Vbox)
		active_scroller = scrollbox
	var new_label:Label = Label.new()
	Vbox.add_child(new_label)
	new_label.size = Vector2(lblwidth,lblheight)
	new_label.horizontal_alignment = 1
	new_label.text = new_value
	if individual_ready and columns[ID].text == "teamNumber":
		new_label.mouse_filter = 1
		new_label.set_script(team_number_script)
	elif selection_ready and columns[ID].text == "teamNumber":
		new_label.mouse_filter = 1
		new_label.set_script(selection_number_script)
	lbllocations[str(ID)].append(new_label)
	var new_color_rect:ColorRect = ColorRect.new()
	new_color_rect.custom_minimum_size = Vector2(lblwidth,.1*lblheight)
	Vbox.add_child(new_color_rect)
	new_color_rect.modulate = random_color(.3,.6,len(lbllocations[str(ID)]))
	seperators[str(ID)].append(new_color_rect)

func import_scroll_started(scroller:ScrollContainer):
	active_scroller = scroller
	update_scroller_position()


func update_scroller_position():
	for i in Scrollers:
		i.scroll_vertical = active_scroller.scroll_vertical

func sort_column_element(team_number:String,pos:int,amount_of_available_teams:int):
	var index:String
	if !run_before:
		run_before = true
		for k in lbllocations.keys():
			copy_of_lbllocations[k] = []
			for i in lbllocations[k]:
				copy_of_lbllocations[k].append(i.text)
	var counter:int = 0
	for x in copy_of_lbllocations[str(columnIDs["teamNumber"])]:
		if x == team_number:
			index = str(counter)
			break
		else:
			if counter ==copy_of_lbllocations[str(columnIDs["teamNumber"])].size() -1:
				print("not found", "     ", team_number)
		counter +=1
	for k in columnIDs.values():
		lbllocations[str(k)][pos].text =copy_of_lbllocations[str(k)][int(index)]
	if amount_of_available_teams >=0:
		for k in lbllocations.keys():
			if amount_of_available_teams < lbllocations[str(k)].size():
				lbllocations[str(k)][lbllocations[str(k)].size()-1].queue_free()
				lbllocations[str(k)].remove_at(lbllocations[str(k)].size()-1)
				seperators[str(k)][lbllocations[str(k)].size()-1].queue_free()
				seperators[str(k)].remove_at(lbllocations[str(k)].size()-1)

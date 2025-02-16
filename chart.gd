class_name chart extends Node2D
var last_column_position:Vector2 = Vector2(0,0)
var columns:Array = []
var columnIDs:Dictionary = {}
var last_ID:int = 0
var VboxID:Dictionary = {}
var Scrollers:Array = []
@export var lblwidth:int = 150
@export var lblheight:int = 50
var lbllocations:Dictionary = {}
var run_before:bool = false
var copy_of_lbllocations:Dictionary
var column_script:Script = load("res://label.gd")
#@onready var h_box_container: HBoxContainer = %HBoxContainer
var team_number_script:Script = load("res://team_number_label.gd")
@export var individual_ready:bool = false
func create_column(column_name:String):
	var new_label = Label.new()
	new_label.mouse_filter = 1
	new_label.text = column_name
	new_label.horizontal_alignment = 1
	new_label.vertical_alignment = 1
	if column_name != "teamNumber":
		new_label.set_script(column_script)
	self.add_child(new_label)
	new_label.size = Vector2(lblwidth,lblheight)
	new_label.position = last_column_position
	last_column_position+=Vector2(lblwidth,0)
	columns.append(new_label)
	var new_sb = StyleBoxFlat.new()
	new_sb.bg_color = random_color(.2,.8)
	new_label.add_theme_stylebox_override("normal",new_sb)
	columnIDs[column_name] = last_ID
	lbllocations[str(last_ID)] = []
	#if last_ID !=0:
		#h_box_container.add_child(new_label)
	last_ID +=1
	
	
	

func setup_column_seperators(width:int,height:int):
	print(Scrollers[0].size.y)
	for i in range(height+1):
		var new_color_rect:ColorRect = ColorRect.new()
		self.add_child(new_color_rect)
		new_color_rect.size = Vector2(lblwidth*width,.1*lblheight)
		new_color_rect.position = Vector2(0,-new_color_rect.size.y+lblheight+i*(Scrollers[0].size.y/(height)))
		#new_color_rect.position = Vector2(0,-new_color_rect.size.y+(height+1)*lblheight+lbllocations[lbllocations.keys()[-1]][-1].position.y/height)
		new_color_rect.modulate = random_color(.3,.6)
		
func random_color(cap:float,minimum:float)->Color:
	var r:float = randf()
	var g:float = randf()
	var b:float = randf()
	if r > cap:
		r = cap
	elif r < minimum:
		r = minimum
	if g > cap:
		g = cap
	elif g < minimum:
		g = minimum
	if b > cap:
		b = cap
	elif b < minimum:
		b = minimum
	return Color(r,g,b)
func add_item_to_column(ID:int,new_value:String):
	var Vbox:VBoxContainer
	if str(ID) in VboxID.keys():
		Vbox =VboxID[str(ID)]
	else:
		var scrollbox = ScrollContainer.new()
		#if ID !=0:
			#h_box_container.add_child(scrollbox)
		Vbox = VBoxContainer.new()
		VboxID[str(ID)] = Vbox
		Vbox.alignment = 1
		self.add_child(scrollbox)
		scrollbox.add_child(Vbox)
		scrollbox.position = Vector2(ID*lblwidth+.3333*lblwidth,lblheight)
		scrollbox.size = Vector2(lblwidth,1080-lblheight)
		Scrollers.append(scrollbox)
	#Scrollers[ID].size = Vector2(lblwidth,(1+len(lbllocations[str(ID)]))*lblheight)
	#print(Scrollers[ID].size)
	#if Scrollers[ID].size.y > 1080:
		#Scrollers[ID].size.y = 1080
	var new_label:Label = Label.new()
	Vbox.add_child(new_label)
	new_label.size = Vector2(lblwidth,lblheight)
	new_label.horizontal_alignment = 1
	new_label.text = new_value
	if individual_ready and columns[ID].text == "teamNumber":
		new_label.mouse_filter = 1
		new_label.set_script(team_number_script)
		#print("attached")
		#print(new_label.get_script())
	#var new_sb = StyleBoxFlat.new()
	#new_sb.bg_color = Color(.05*len(columns),.05*len(columns),.05*len(columns))
	#new_label.add_theme_stylebox_override("normal",new_sb)
	lbllocations[str(ID)].append(new_label)
func _physics_process(delta: float) -> void:
	for i in Scrollers:
		i.scroll_vertical = Scrollers[0].scroll_vertical

func sort_column_element(team_number:String,pos:int):
	#print(team_number, pos)
	var index:String
	if !run_before:
		run_before = true
		for k in lbllocations.keys():
			copy_of_lbllocations[k] = []
			for i in lbllocations[k]:
				copy_of_lbllocations[k].append(i.text)
	#print(copy_of_lbllocations.values())
	var counter:int = 0
	for x in copy_of_lbllocations[str(columnIDs["teamNumber"])]:
		#print(lbllocations)
		#print(lbllocations[str(columnIDs["teamNumber"])].keys())
		if x == team_number:
			index = str(counter)
			break
		else:
			if counter ==copy_of_lbllocations[str(columnIDs["teamNumber"])].size() -1:
				print("not found", "     ", team_number)
			#print(copy_of_lbllocations[str(columnIDs["teamNumber"])][int(i)],"      ", i)
		counter +=1
	#print(copy_of_lbllocations[str(columnIDs["teamNumber"])])
	for k in columnIDs.values():
		#print(index)
		#print(copy_of_lbllocations[str(k)][int(index)].text)
		lbllocations[str(k)][pos].text =copy_of_lbllocations[str(k)][int(index)]
	

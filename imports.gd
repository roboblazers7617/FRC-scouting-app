extends Node2D
var spreadsheet_path:String = Settings.spreadsheet_path
var spreadsheet_data
var sheet_name:String = "2024incmp_qm"
# Called when the node enters the scene tree for the first time.
@onready var chart:Node2D = %chart
var summarized_data
@onready var indicator_arrow: AnimatedSprite2D = %"indicator arrow"
var currently_sorted:String
var descending:bool = false
var selection_view:PackedScene = load("res://selection_view.tscn")



func _ready() -> void:
	print(self.get_script())
	chart.hide()
	Globals.sort_by_column.connect(sort_by_category)
	_on_button_button_down()
# Called every frame. 'delta' is the elapsed time since the previous frame.

func read_file(path:String):
	var filestring = FileAccess.get_file_as_string(path)
	var json_data
	if filestring != null:
		json_data = JSON.parse_string(filestring)
	else:
		print("path does not lead to a file")
	if json_data == null:
		print("failed to parse json")
	
	return json_data


func _on_button_button_down() -> void:
	chart.show()
	spreadsheet_data = read_file(spreadsheet_path)
	if spreadsheet_data !=null:
		summarized_data = summarize_data(spreadsheet_data)
		var first_round:bool = true
		for x in summarized_data.keys():
			var data = summarized_data.get(x)
			if first_round:
				first_round = false
				chart.create_column(Settings.team_number_ID)
				for i in data.keys():
					if i in Settings.whitelist:
						chart.create_column(i)
			chart.add_item_to_column(chart.columnIDs[Settings.team_number_ID],x)
			for i in data.keys():
				if i not in Settings.whitelist:
					continue
				else:
					chart.add_item_to_column(chart.columnIDs[i],str(data[i]))

func summarize_data(spreadsheet_data):
	var saved_data:Dictionary = {}
	for x in spreadsheet_data.keys():
		var data = spreadsheet_data.get(str(x))
		if str(data[Settings.team_number_ID]) in saved_data.keys():
			for i in data.keys():
				if i in Settings.whitelist and i != Settings.team_number_ID and data[Settings.died_ID] != 1 or i == Settings.died_ID :
					if data[i] == null:
						data[i] = 0
					print(data[i])
					saved_data[str(data[Settings.team_number_ID])][i]+=int(data[i])
			if int(data[Settings.died_ID])!=1:
				saved_data[str(data[Settings.team_number_ID])]["matchesplayed"]+=1
		else:
			if str(data[Settings.team_number_ID]) in Settings.current_teams:
				var new_dict:Dictionary = {}
				for i in data.keys():
					if i in Settings.whitelist and i != Settings.team_number_ID:
						if data[Settings.died_ID] != 1 or  i == Settings.died_ID:
							print(data[Settings.team_number_ID])
							print(i)
							print(data[i])
							new_dict[i]= int(data[i])
						else:
							new_dict[i] = 0
						if int(data[Settings.died_ID]) == 1:
							new_dict["matchesplayed"]=0
						else:
							new_dict["matchesplayed"]=1
				saved_data[str(data[Settings.team_number_ID])] = new_dict
	for x in saved_data.keys():
		for y in saved_data[x].keys():
			if y != "matchesplayed" and y!= Settings.died_ID:
				if float(saved_data[x]["matchesplayed"]) != 0:
					saved_data[x][y] = round_place(float(saved_data[x][y])/float(saved_data[x]["matchesplayed"]),3)
				else:
					saved_data[x][y] = 0
			elif y == Settings.died_ID:
				saved_data[x][y] = round_place(float(saved_data[x][y])/(float(saved_data[x]["matchesplayed"])+float(saved_data[x][y])),3)
	return saved_data

func round_place(num,places):
	return (round(num*pow(10,places))/pow(10,places))


func sort_by_category(category:String):
	indicator_arrow.position = Vector2(chart.lblwidth*int(chart.columnIDs[category])+chart.lblwidth*.9,.5*chart.lblheight+chart.position.y)
	if currently_sorted == category:
		descending = !descending
	else:
		descending  = true
	if descending:
		indicator_arrow.animation = "down"
	else:
		indicator_arrow.animation = "up"
	currently_sorted = category
	#print(chart.columnIDs.keys())
	var dataIDs:Array = []
	for k in summarized_data.keys():
		dataIDs.append([summarized_data[k][category],k])
	var n:int = len(dataIDs)
		# Traverse through all array elements
	if descending:
		for i in range(n):
				var swapped:bool = false

				# Last i elements are already in place
				for j in range(0, n-i-1):

					# Traverse the array from 0 to n-i-1
					# Swap if the element found is greater
					# than the next element
					if dataIDs[j][0] > dataIDs[j+1][0]:
						var temp = dataIDs[j]
						dataIDs[j]= dataIDs[j+1]
						dataIDs[j+1] =temp
						swapped = true
				if (swapped == false):
					break
	else:
		for i in range(n):
				var swapped:bool = false

				# Last i elements are already in place
				for j in range(0, n-i-1):

					# Traverse the array from 0 to n-i-1
					# Swap if the element found is greater
					# than the next element
					if dataIDs[j][0] < dataIDs[j+1][0]:
						var temp = dataIDs[j]
						dataIDs[j]= dataIDs[j+1]
						dataIDs[j+1] =temp
						swapped = true
				if (swapped == false):
					break
	#print(dataIDs)
	for i in range(dataIDs.size()):
		chart.sort_column_element(dataIDs[i][1],i,-1)
		
	#dataIDs.sort()
	#var ignored:Array = []
	#var current:int = 0
	#while dataIDs.size() > current:
		#for k in summarized_data.keys():
			#if summarized_data[k][category] == dataIDs[current] and summarized_data[k] not in ignored:
				#ignored.append(summarized_data[k])
				#for i in chart.columnIDs.keys():
					#chart.sort_column_element(i,chart.columnIDs[k],current)
					#current+=1
				#break


func _on_selection_view_button_down() -> void:
	get_tree().change_scene_to_packed(selection_view)

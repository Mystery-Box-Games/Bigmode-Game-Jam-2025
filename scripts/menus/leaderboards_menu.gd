extends Control

var player_list_with_pos = []
@onready var grid_container: GridContainer = $PanelContainer/VBoxContainer/GridContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var sw_result: Dictionary = await SilentWolf.Scores.get_scores(0).sw_get_scores_complete
	player_list_with_pos = sort_players_and_add_position(SilentWolf.Scores.scores)
	add_player_to_grid(player_list_with_pos)


func add_player_to_grid(player_list):
	var pos_vbox = VBoxContainer.new()
	var name_vbox = VBoxContainer.new()
	var score_vbox = VBoxContainer.new()
	
	for score_data in player_list_with_pos:
		var pos_label = Label.new()
		pos_label.theme_type_variation = "SubTitle"
		pos_label.text = "%s." % str(score_data["position"])
		pos_label.show()
		pos_vbox.add_child(pos_label)
	grid_container.add_child(pos_vbox)
	
	for score_data in player_list_with_pos:
		var name_label = Label.new()
		name_label.theme_type_variation = "SubTitle"
		name_label.text = str(score_data["player_name"])
		name_label.show()
		name_vbox.add_child(name_label)
	grid_container.add_child(name_vbox)
	
	for score_data in player_list_with_pos:
		var score_label = Label.new()
		score_label.theme_type_variation = "SubTitle"
		score_label.text = str(score_data["score"])
		score_label.show()
		score_vbox.add_child(score_label)
	grid_container.add_child(score_vbox)
	
func sort_players_and_add_position(player_list):
	var position = 1
	for player in player_list:
		player["position"] = position
		position += 1
	return player_list


func _on_button_back_pressed() -> void:
	get_tree().change_scene_to_file(Globals.prevscene)

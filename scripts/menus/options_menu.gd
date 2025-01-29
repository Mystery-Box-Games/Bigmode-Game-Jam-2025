extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#$CenterContainer/PanelContainer/VBoxContainer/VolumeSlider.grab_focus()
	pass
	
func _on_option_button_item_selected(index: int) -> void:
	var size = $TabContainer/Display/HBoxContainer/OptionButton.get_item_text(index).split("x")
	get_viewport().size = Vector2(float(size[0]), float(size[1]))

func _on_check_button_toggled(toggled_on: bool) -> void:
	if (toggled_on):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _on_button_back_pressed() -> void:
	get_tree().change_scene_to_file(Globals.prevscene)

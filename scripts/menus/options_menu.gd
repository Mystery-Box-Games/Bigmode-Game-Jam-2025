extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CenterContainer/PanelContainer/VBoxContainer/VolumeSlider.grab_focus()

func _on_button_back_pressed() -> void:
	get_tree().change_scene_to_file(Globals.prevscene)

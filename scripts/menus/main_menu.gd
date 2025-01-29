extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$VBoxContainer/ButtonStart.grab_focus()
	Globals.prevscene = get_tree().current_scene.scene_file_path


func _on_button_start_pressed() -> void:
	get_tree().change_scene_to_packed(Globals.game_scene)


func _on_button_options_pressed() -> void:
	get_tree().change_scene_to_packed(Globals.options_scene)


func _on_button_credits_pressed() -> void:
	get_tree().change_scene_to_packed(Globals.credits_scene)


func _on_button_quit_pressed() -> void:
	get_tree().quit()

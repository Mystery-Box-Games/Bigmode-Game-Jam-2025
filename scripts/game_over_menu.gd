extends CanvasLayer


func _on_button_retry_pressed() -> void:
	Globals.reset()
	get_tree().change_scene_to_packed(Globals.game_scene)

func _on_button_options_pressed() -> void:
	get_tree().change_scene_to_packed(Globals.options_scene)

func _on_button_quit_pressed() -> void:
	Globals.reset()
	get_tree().change_scene_to_packed(Globals.menu_scene)

extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$VBoxContainer/ButtonStart.grab_focus()
	Globals.prevscene = get_tree().current_scene.scene_file_path


func _on_button_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_button_options_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/options_menu.tscn")


func _on_button_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/credits_menu.tscn")


func _on_button_quit_pressed() -> void:
	get_tree().quit()

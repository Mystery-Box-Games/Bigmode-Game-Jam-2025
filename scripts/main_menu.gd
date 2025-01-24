extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$VBoxContainer/ButtonStart.grab_focus()



func _on_button_start_pressed() -> void:
	# get_tree().change_scene_to_file("PATH TO FIRST SCENE")
	pass # Replace with function body.


func _on_button_options_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/options_menu.tscn")


func _on_button_quit_pressed() -> void:
	get_tree().quit()

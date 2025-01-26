extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CenterContainer/PanelContainer/VBoxContainer/ButtonResume.grab_focus()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_resume_pressed() -> void:
	visible = false


func _on_button_retry_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_button_options_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/options_menu.tscn")

func _on_button_quit_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

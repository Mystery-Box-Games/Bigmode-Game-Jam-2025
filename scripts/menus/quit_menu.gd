extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CenterContainer/PanelContainer/VBoxContainer/ButtonResume.grab_focus()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_resume_pressed() -> void:
	get_parent().process_mode = Node.PROCESS_MODE_PAUSABLE
	visible = false


func _on_button_retry_pressed() -> void:
	Globals.reset()
	get_tree().change_scene_to_packed(Globals.game_scene)

func _on_button_options_pressed() -> void:
	get_tree().change_scene_to_packed(Globals.options_scene)

func _on_button_quit_pressed() -> void:
	get_tree().change_scene_to_packed(Globals.menu_scene)

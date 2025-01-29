extends Node

var game_over_screen = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.prevscene = get_tree().current_scene.scene_file_path


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	# display quit menu when ESC is pressed
	if (Input.is_action_pressed("ui_cancel")):
		get_parent().process_mode = Node.PROCESS_MODE_DISABLED
		$"../QuitMenu".process_mode = Node.PROCESS_MODE_PAUSABLE
		$"../QuitMenu".visible = true
		
	if (Globals.game_over && !game_over_screen):
		game_over_screen = true
		get_parent().process_mode = Node.PROCESS_MODE_DISABLED
		$"../GameOverMenu".process_mode = Node.PROCESS_MODE_PAUSABLE
		$"../GameOverMenu".visible = true
		

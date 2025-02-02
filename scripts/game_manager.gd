extends Node

var game_over_screen = false
var round_over = false
var round = 0

@export var levels: Array[PackedScene]
var current_level: Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.reset()
	Globals.prevscene = get_tree().current_scene.scene_file_path
	current_level = levels[round].instantiate()
	get_parent().add_child.call_deferred(current_level)

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
		$"../UI".process_mode = Node.PROCESS_MODE_PAUSABLE
		$"../GameOverMenu".visible = true
	
	# round is over when amount of specified enemies are defeated (see level_# inspector)
	if (round_over):
		round_over = false
		$"../CooldownTimer".start()

# wait for timer before loading level
func _on_cooldown_timer_timeout() -> void:
	next_round()
	
# load next level in array
func next_round():
	
	# if there are levels to load, load them first
	if (round < levels.size() - 1):
		print("loading next level")
		get_parent().remove_child(current_level)
		round += 1
		current_level = levels[round].instantiate()
		get_parent().add_child(current_level)
	# else, keep on same level and just increment the round number
	else:
		round += 1
		get_parent().remove_child(current_level)
		current_level = levels[levels.size() - 1].instantiate()
		get_parent().add_child(current_level)
	Globals.round = round

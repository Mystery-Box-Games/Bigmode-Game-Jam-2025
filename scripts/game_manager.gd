extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	# display quit menu when ESC is pressed
	if (Input.is_action_pressed("ui_cancel")):
		$"../QuitMenu".visible = true

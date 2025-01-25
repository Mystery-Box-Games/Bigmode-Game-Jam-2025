extends CharacterBody2D


const SPEED := 10.0

var health := 100


func _physics_process(delta: float) -> void:
	look_at(get_global_mouse_position())
	
	# get direction from keyboard
	var character_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	#character_direction.x = Input.get_axis("move_left", "move_right")
	#character_direction.y = Input.get_axis("move_up", "move_down")
	
	if character_direction:
		velocity = character_direction.normalized() * (SPEED * 100)
	else:
		velocity = Vector2.ZERO

	move_and_slide()

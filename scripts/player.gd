extends CharacterBody2D

class_name Player

const SPEED := 3.0

var brain_power = 0

@onready var weapon_socket: Node2D = $WeaponSocket

func _physics_process(delta: float) -> void:
	#look_at(get_global_mouse_position())
	
	# get direction from keyboard
	var character_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	# move character in specified direction
	if character_direction:
		velocity = character_direction.normalized() * (SPEED * 100)
	else:
		velocity = Vector2.ZERO
		
	#if character_direction == Vector2(-1, 0):
	if (get_global_mouse_position() < global_position):
		$AnimatedSprite2D.flip_h = true
		weapon_socket.position.x = -9
	#elif character_direction == Vector2(1, 0):
	elif (get_global_mouse_position() > global_position):
		$AnimatedSprite2D.flip_h = false
		weapon_socket.position.x = 9
		
	move_and_slide()

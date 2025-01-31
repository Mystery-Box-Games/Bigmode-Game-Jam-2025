extends CharacterBody2D

class_name Player

enum Tiers {BASE, ONE, TWO, THREE, FOUR, FIVE}
var tier: Tiers = Tiers.BASE

const SPEED := 3.0

var brain_power = 0
var prev_brain_power = 0
var brain_tier_index = 0
var brain_tier = {
	0: Tiers.BASE,
	1: Tiers.ONE,
	2: Tiers.TWO,
	3: Tiers.THREE,
	4: Tiers.FOUR,
	5: Tiers.FIVE
}

@onready var weapon_socket: Node2D = $WeaponSocket
@onready var brain_power_timer: Timer = $BrainPowerTimer


func _physics_process(delta: float) -> void:
	brain_tier_index = clampi(brain_tier_index, 0, 5)
	brain_power = clampi(brain_power, 0, 50)
	
	if (prev_brain_power < brain_power):
		prev_brain_power = brain_power
		brain_power_timer.start()
	if (brain_power > 0 && brain_power_timer.is_stopped()):
		print("starting timer")
		brain_power_timer.start()
	
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

func _on_brain_power_timer_timeout() -> void:
	brain_tier_index -= 1
	brain_tier_index = clampi(brain_tier_index, 0, 5)
	set_state(brain_tier[brain_tier_index])

func set_state(state: Tiers) -> void:
	match state:
		Tiers.BASE:
			pass
		Tiers.ONE:
			pass
		Tiers.TWO:
			pass
		Tiers.THREE:
			pass
		Tiers.FOUR:
			pass
		Tiers.FIVE:
			pass
	

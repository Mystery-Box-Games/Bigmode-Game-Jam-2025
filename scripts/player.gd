extends CharacterBody2D

class_name Player

enum Tiers {BASE, ONE, TWO, THREE, FOUR, FIVE}
var tier: Tiers = Tiers.BASE

const SPEED := 3.0

var damage_multiplier = 1
var speed_multiplier = 1
var bps_multiplier = 1

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

var magnet_power = false

@onready var weapon_socket: Node2D = $WeaponSocket
@onready var brain_power_timer: Timer = $BrainPowerTimer
@onready var magnet_power_timer: Timer = $MagnetPowerTimer
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var magnetzone: Area2D = $Magnetzone


func _physics_process(delta: float) -> void:
	brain_tier_index = clampi(brain_tier_index, 0, 5)
	#brain_power = clampi(brain_power, 0, 50)
	
	if (prev_brain_power < brain_power):
		prev_brain_power = brain_power
		brain_power_timer.start()
	if (tier != Tiers.BASE && brain_power_timer.is_stopped()):
		brain_power_timer.start()
	
	# get direction from keyboard
	var character_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	# move character in specified direction
	if character_direction:
		velocity = character_direction.normalized() * ((SPEED * 100) * speed_multiplier)
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
	
	# animations
	
		# walking right, facing right
	if (character_direction > Vector2(0, 0) && get_global_mouse_position() > global_position):
		animated_sprite.play("walk")
		
		# walking left, facing right
	elif (character_direction < Vector2(0, 0) && get_global_mouse_position() > global_position):
		animated_sprite.play("backstep")
		
		# walking right, facing left
	elif (character_direction > Vector2(0, 0) && get_global_mouse_position() < global_position):
		animated_sprite.play("backstep")
		
		# walking left, facing left
	elif (character_direction < Vector2(0, 0) && get_global_mouse_position() < global_position):
		animated_sprite.play("walk")
		
	else:
		animated_sprite.play("idle")
	
	move_and_slide()

func _on_brain_power_timer_timeout() -> void:
	#brain_power -= 10
	brain_tier_index -= 1
	brain_tier_index = clampi(brain_tier_index, 0, 5)
	set_state(brain_tier[brain_tier_index])

func set_state(state: Tiers) -> void:
	tier = state
	match tier:
		Tiers.BASE:
			brain_power = 0
			prev_brain_power = 0
			#damage_multiplier = 1
			speed_multiplier = 1
			bps_multiplier = 1
		Tiers.ONE:
			brain_power = 10
			prev_brain_power = 10
			#damage_multiplier = 1.2
			speed_multiplier = 1.2
			bps_multiplier = 1.2
		Tiers.TWO:
			brain_power = 20
			prev_brain_power = 20
			#damage_multiplier = 1.4
			speed_multiplier = 1.4
			bps_multiplier = 1.4
		Tiers.THREE:
			brain_power = 30
			prev_brain_power = 30
			#damage_multiplier = 1.6
			speed_multiplier = 1.6
			bps_multiplier = 1.6
		Tiers.FOUR:
			brain_power = 40
			prev_brain_power = 40
			#damage_multiplier = 1.8
			speed_multiplier = 1.8
			bps_multiplier = 1.8
		Tiers.FIVE:
			brain_power = 50
			prev_brain_power = 50
			#damage_multiplier = 2
			speed_multiplier = 2
			bps_multiplier = 2
			
	if (weapon_socket.get_children().size() > 0):
		weapon_socket.get_child(0).fire_rate = 1 / (weapon_socket.get_child(0).bps * bps_multiplier)
			
func next_tier() -> void:
	brain_tier_index += 1
	brain_tier_index = clampi(brain_tier_index, 0, 5)
	set_state(brain_tier[brain_tier_index])

func activate_magnet():
	magnetzone.monitoring = true
	magnet_power = true
	magnet_power_timer.start()
	
func _on_magnetzone_area_entered(area: Area2D) -> void:
	var node = area.get_parent()
	if node is Pickup && node.is_brain:
		node.move_towards_player = true

func _on_magnetzone_area_exited(area: Area2D) -> void:
	var node = area.get_parent()
	if node is Pickup && node.is_brain:
		node.move_towards_player = false

func _on_magnet_power_timer_timeout() -> void:
	magnetzone.monitoring = false
	magnet_power = false

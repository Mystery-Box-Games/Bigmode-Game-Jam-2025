extends "res://scripts/enemies/enemy.gd"

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var enemy_brute: CharacterBody2D = $"."

var flipped = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	initialize()
	animation_player.play("walk")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	move_character()
	
	if (player.global_position.x > global_position.x && flipped):
			enemy_brute.scale.x *= -1
			flipped = false
	elif (player.global_position.x < global_position.x && !flipped):
			enemy_brute.scale.x *= -1
			flipped = true

	if (within_attack_range && time_until_attack <= 0):
		animation_player.play("attack")
		time_until_attack = attack_speed
	else:
		time_until_attack -= delta
		
#func attack():
	#player.get_node("Health").damage(attack_damage)

func attack():
	$AttackDetector.monitoring = true
	
func end_of_attack():
	$AttackDetector.monitoring = false

func _on_attack_range_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		within_attack_range = true

func _on_attack_range_area_exited(area: Area2D) -> void:
	if area.get_parent() is Player:
		within_attack_range = false
		time_until_attack = attack_speed

func _on_attack_detector_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		player.get_node("Health").damage(attack_damage)

func start_walk():
	animation_player.play("walk")

func _on_tree_exiting() -> void:
	dead()
	#Globals.score += score
	#
	#var random = RandomNumberGenerator.new()
	#var number = random.randi_range(1, 100)
	#
	#if (number <= brain_chance):
		#var brain = brains.instantiate()
		#brain.global_position = global_position
		#get_tree().root.get_node("Game").add_child.call_deferred(brain)
		#
	#elif (number <= 100 && number >= 90 && !player.get_node("Magnetzone").monitoring):
		#var magnet = magnets.instantiate()
		#magnet.global_position = global_position
		#get_tree().root.get_node("Game").add_child.call_deferred(magnet)

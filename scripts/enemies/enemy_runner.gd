extends "res://scripts/enemies/enemy.gd"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	initialize()
	$AnimationPlayer.play("run")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	move_character()
	
	if (player.global_position.x > global_position.x):
			$Sprite.flip_h = false
	elif (player.global_position.x < global_position.x):
			$Sprite.flip_h = true

	if (within_attack_range && time_until_attack <= 0):
		$AnimationPlayer.play("attack")
		time_until_attack = attack_speed
	else:
		time_until_attack -= delta
		
func attack():
	$AttackDetector.monitoring = true
	
func end_of_attack():
	$AttackDetector.monitoring = false

func _on_attack_range_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		within_attack_range = true

func _on_attack_range_area_exited(area: Area2D) -> void:
	if area.get_parent() is Player:
		#print("player out of range")
		within_attack_range = false
		time_until_attack = attack_speed


func _on_attack_detector_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		player.get_node("Health").damage(attack_damage)

func start_run():
	$AnimationPlayer.play("run")
	
	
func _on_tree_exiting() -> void:
	Globals.score += score
	
	var random = RandomNumberGenerator.new()
	var number = random.randi_range(1, 100)
	
	if (number <= brain_chance):
		var brain = brains.instantiate()
		brain.global_position = global_position
		get_tree().root.get_node("Game").add_child.call_deferred(brain)

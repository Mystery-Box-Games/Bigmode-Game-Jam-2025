extends "res://scripts/enemies/enemy.gd"

@export var bullet_scn: PackedScene
@export var bullet_speed: float = 1200

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	initialize()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (player != null):
		look_at(player.global_position)
	
	if (!within_attack_range):
		move_character()
	
	if (within_attack_range && time_until_attack <= 0):
		attack()
		time_until_attack = attack_speed
	else:
		time_until_attack -= delta
		
func attack():
	print("Shooter is attacking")
	var bullet: RigidBody2D = bullet_scn.instantiate()
			
	bullet.rotation = global_rotation
	bullet.global_position = $BulletPosition.global_position
	bullet.linear_velocity = bullet.transform.x * bullet_speed
			
	bullet.damage = attack_damage
	bullet.is_enemies = true
			
	get_tree().root.get_node("Game").add_child(bullet)
	
func _on_attack_range_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		print("player in range")
		within_attack_range = true

func _on_attack_range_area_exited(area: Area2D) -> void:
	if area.get_parent() is Player:
		print("player out of range")
		within_attack_range = false
		time_until_attack = attack_speed

func _on_tree_exiting() -> void:
	var random = RandomNumberGenerator.new()
	var number = random.randi_range(1, 100)
	
	if (number <= brain_chance):
		var brain = brains.instantiate()
		brain.global_position = global_position
		get_tree().root.get_node("Game").add_child.call_deferred(brain)

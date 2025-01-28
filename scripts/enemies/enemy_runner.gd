extends "res://scripts/enemies/enemy.gd"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	initialize()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	move_character()

	if (within_attack_range && time_until_attack <= 0):
		attack()
		time_until_attack = attack_speed
	else:
		time_until_attack -= delta
		
func attack():
	player.get_node("Health").damage(attack_damage)

func _on_attack_range_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		print("player in range")
		within_attack_range = true

func _on_attack_range_area_exited(area: Area2D) -> void:
	if area.get_parent() is Player:
		print("player out of range")
		within_attack_range = false
		time_until_attack = attack_speed

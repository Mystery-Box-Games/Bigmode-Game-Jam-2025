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
	print("attack player")

func _on_attack_range_body_entered(body: Node2D) -> void:
	if body is Player:
		print("player in range")
		within_attack_range = true

func _on_attack_range_body_exited(body: Node2D) -> void:
	if body is Player:
		print("player out of range")
		within_attack_range = false
		time_until_attack =attack_speed

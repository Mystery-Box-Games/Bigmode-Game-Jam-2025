extends Node2D

@export var max_health: float = 100.0

var health: float

func _ready() -> void:
	health = max_health
	
func damage(damage: float):
	health -= damage
	
	if (health <= 0):
		if (get_parent() is Player):
			Globals.game_over = true
		else:
			Globals.enemies_defeated += 1
			print(Globals.enemies_defeated)
			get_parent().queue_free()
			

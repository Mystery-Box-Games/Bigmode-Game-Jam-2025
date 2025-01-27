extends Node2D

@export var max_health: float = 100.0

var health: float

func _ready() -> void:
	health = max_health
	
func damage(damage: float):
	health -= damage
	
	if (health <= 0):
		get_parent().queue_free()

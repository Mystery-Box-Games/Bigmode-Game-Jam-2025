extends CharacterBody2D

# this video for adding an enemy
# https://www.youtube.com/watch?v=lOZZxRFG99k

class_name Enemy

@export var brains: PackedScene
@export var brain_chance: int = 10
@export var attack_damage: float = 20
@export var aps: float = 2
@export var speed: float = 40
@export var min_distance: float = 0

var attack_speed: float
var time_until_attack: float
var within_attack_range: bool = false

@onready var player: Player = get_tree().root.get_node("Game").get_node("Player")

func initialize():
	attack_speed = 1 / aps;
	time_until_attack = 0
	add_to_group("enemies")
	
func move_character():
	if (player != null):
		var target_position = (player.global_position - global_position).normalized()
		if (global_position.distance_to(player.global_position) > min_distance):
			move_and_collide(target_position * speed)
		#look_at(player.global_position)
	

extends CharacterBody2D

# this video for adding an enemy
# https://www.youtube.com/watch?v=lOZZxRFG99k

class_name Enemy

@export var attack_damage: float = 20
@export var aps: float = 2
@export var speed: float = 40
@export var min_distance: float = 0

var attack_speed: float
var time_until_attack: float
var within_attack_range: bool = false

@onready var player: Player = $'../Player'

func initialize():
	attack_speed = 1 / aps;
	time_until_attack = attack_speed
	
func move_character():
	if (player != null):
		var target_position = (player.global_position - global_position).normalized()
		if (global_position.distance_to(player.global_position) > min_distance):
			move_and_collide(target_position * speed)
		look_at(player.global_position)
	

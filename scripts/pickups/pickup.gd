extends Node2D

class_name Pickup

@export var pickup_scene: PackedScene
@export var is_weapon: bool = false
@export var is_brain: bool = false
@export var is_magnet: bool = false

var move_towards_player = false
var velocity = Vector2.ZERO

@onready var player: Player = get_tree().root.get_node("Game").get_node("Player")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if move_towards_player:
		print("moving towards player")
		if (player != null):
			var position = player.get_node("CollisionShape2D").global_position
			var target_position = (position - global_position).normalized()
			if (global_position.distance_to(position) > 1):
				velocity += target_position * 20
				translate(velocity * delta)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		if is_weapon:
			if body.weapon_socket.get_child_count() >= 0:
				var children = body.weapon_socket.get_children()
				for child in children:
					body.weapon_socket.remove_child(child)
			var weapon = pickup_scene.instantiate()
			body.weapon_socket.add_child(weapon)
			queue_free()
		elif is_brain:
			print("brains")
			body.brain_power += 1
			body.get_node("Health").health += 2
			queue_free()
		elif is_magnet:
			body.activate_magnet()
			queue_free()


func _on_timer_timeout() -> void:
	queue_free()

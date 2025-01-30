extends Node

@export var pickup_scene: PackedScene
@export var is_weapon: bool = false
@export var is_brain: bool = false

@onready var player: Player = get_tree().root.get_node("Game").get_node("Player")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		if is_weapon:
			if player.weapon_socket.get_child_count() >= 0:
				var children = player.weapon_socket.get_children()
				for child in children:
					player.weapon_socket.remove_child(child)
			var weapon = pickup_scene.instantiate()
			player.weapon_socket.add_child(weapon)
			queue_free()
		elif is_brain:
			print("brains")
			body.brain_power += 1
			body.get_node("Health").health += 5
			queue_free()

func _on_area_2d_area_entered(area: Area2D) -> void:
	pass

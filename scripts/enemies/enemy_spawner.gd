extends Node2D

@export var enemy_scene: PackedScene
@export var spawn_points: Array[Node2D]
@export var eps: float = 1.0

var spawn_rate: float
var time_until_spawn: float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_rate = 1 / eps


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (time_until_spawn > spawn_rate):
		spawn()
		time_until_spawn = 0
	else:
		time_until_spawn += delta

func spawn():
	var rng = RandomNumberGenerator.new()
	var location: Vector2 = spawn_points[rng.randi() % spawn_points.size()].global_position
	var enemy: Enemy = enemy_scene.instantiate()
	enemy.global_position = location
	get_tree().root.add_child(enemy)

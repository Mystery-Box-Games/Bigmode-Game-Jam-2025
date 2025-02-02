extends Node2D

@export var bullet_scn: PackedScene
@export var bullet_speed = 1200
@export var attack_damage = 10

var flipped: bool = false

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var enemy_shooter: CharacterBody2D = $"../.."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (enemy_shooter.player != null):
		look_at(enemy_shooter.player.global_position)
		
	if (enemy_shooter.player.global_position.x < global_position.x && !flipped):
		animated_sprite.flip_v = true
		$BulletPosition.position.y *= -1
		flipped = true
	elif (enemy_shooter.player.global_position.x > global_position.x && flipped):
		animated_sprite.flip_v = false
		$BulletPosition.position.y *= -1
		flipped = false

func attack():
	var bullet: RigidBody2D = bullet_scn.instantiate()
			
	bullet.rotation = global_rotation
	bullet.global_position = $BulletPosition.global_position
	bullet.linear_velocity = bullet.transform.x * bullet_speed
			
	bullet.damage = attack_damage
	bullet.is_enemies = true
			
	get_tree().root.get_node("Game").add_child(bullet)

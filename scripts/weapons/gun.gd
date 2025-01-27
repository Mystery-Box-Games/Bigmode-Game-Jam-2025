extends Node2D

# Watch to learn how this script works
# https://www.youtube.com/watch?v=MFaMVsYrLrc

@export var bullet_scn: PackedScene
@export var bullet_speed: float = 1200.0
@export var bps: float = 5.0
@export var bullet_damage: float = 30.0

@export var is_shotgun: bool = false

var fire_rate: float

var time_until_fire: float = 0.0

func _get_configuration_warnings():
	if not bullet_scn:
		return 'Bullet Scene not set'
	return ''

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fire_rate = 1 / bps


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	
	if ((Input.is_action_just_pressed("click") || Input.is_action_pressed("click")) && time_until_fire > fire_rate):
		
		if (is_shotgun):
			var bullet1: RigidBody2D = bullet_scn.instantiate()
			var bullet2: RigidBody2D = bullet_scn.instantiate()
			var bullet3: RigidBody2D = bullet_scn.instantiate()
			
			bullet1.rotation = global_rotation
			bullet1.global_position = $BulletPosition.global_position
			bullet1.linear_velocity = bullet1.transform.x * bullet_speed
			
			bullet2.rotation = global_rotation + .2
			bullet2.global_position = $BulletPosition.global_position
			bullet2.linear_velocity = bullet2.transform.x * bullet_speed
			
			bullet3.rotation = global_rotation - .2
			bullet3.global_position = $BulletPosition.global_position
			bullet3.linear_velocity = bullet3.transform.x * bullet_speed
			
			bullet1.add_collision_exception_with(bullet2)
			bullet1.add_collision_exception_with(bullet3)
			
			bullet2.add_collision_exception_with(bullet1)
			bullet2.add_collision_exception_with(bullet3)
			
			bullet3.add_collision_exception_with(bullet1)
			bullet3.add_collision_exception_with(bullet2)
			
			bullet1.damage = bullet_damage
			bullet2.damage = bullet_damage
			bullet3.damage = bullet_damage
			
			get_tree().root.add_child(bullet1)
			get_tree().root.add_child(bullet2)
			get_tree().root.add_child(bullet3)
		
			time_until_fire = 0
		else:
			var bullet: RigidBody2D = bullet_scn.instantiate()
			
			bullet.rotation = global_rotation
			bullet.global_position = $BulletPosition.global_position
			bullet.linear_velocity = bullet.transform.x * bullet_speed
			
			bullet.damage = bullet_damage
			
			get_tree().root.add_child(bullet)
		
			time_until_fire = 0
	else:
		time_until_fire += delta

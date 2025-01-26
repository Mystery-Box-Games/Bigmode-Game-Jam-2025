extends Node2D

# Watch to learn how this script works
# https://www.youtube.com/watch?v=MFaMVsYrLrc

@export var bullet_scn: PackedScene
@export var bullet_speed: float = 1200.0
@export var bps: float = 5.0
@export var bullet_damage: float = 30.0

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
	
	if (Input.is_action_just_pressed("click") && time_until_fire > fire_rate):
		var bullet: RigidBody2D = bullet_scn.instantiate()
		
		bullet.rotation = global_rotation
		bullet.global_position = $BulletPosition.global_position
		bullet.linear_velocity = bullet.transform.x * bullet_speed
		
		get_tree().root.add_child(bullet)
		
		time_until_fire = 0
	else:
		time_until_fire += delta

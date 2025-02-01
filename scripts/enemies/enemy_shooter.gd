extends "res://scripts/enemies/enemy.gd"

@export var bullet_scn: PackedScene
@export var bullet_speed: float = 1200

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var enemy_shooter_gun: Node2D = $WeaponSocket/EnemyShooterGun
@onready var weapon_socket: Node2D = $WeaponSocket

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	initialize()
	$AnimationPlayer.play("idle")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (!within_attack_range):
		move_character()
		
	if (player.global_position.x > global_position.x):
			$Sprite.flip_h = false
			weapon_socket.position.x = 10
	elif (player.global_position.x < global_position.x):
			$Sprite.flip_h = true
			weapon_socket.position.x = -10
	
	if (within_attack_range && time_until_attack <= 0):
		enemy_shooter_gun.attack()
		time_until_attack = attack_speed
	else:
		time_until_attack -= delta
		
	
func _on_attack_range_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		animation_player.play("idle")
		within_attack_range = true

func _on_attack_range_area_exited(area: Area2D) -> void:
	if area.get_parent() is Player:
		animation_player.play("walk")
		within_attack_range = false
		time_until_attack = attack_speed

func _on_tree_exiting() -> void:
	Globals.score += score
	
	var random = RandomNumberGenerator.new()
	var number = random.randi_range(1, 100)
	
	if (number <= brain_chance):
		var brain = brains.instantiate()
		brain.global_position = global_position
		get_tree().root.get_node("Game").add_child.call_deferred(brain)

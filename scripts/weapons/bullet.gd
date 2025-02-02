extends RigidBody2D

const SPEED = 40

var is_enemies: bool = false
var piercing: bool = false
var damage
var pierced = 2


@onready var timer: Timer = $Timer
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#$AnimatedSprite2D.play("bullet")
	pass

func _on_timer_timeout() -> void:
	queue_free()

#func _on_body_entered(body: Node) -> void:
	#if body is Enemy:
		#body.get_node("Health").damage(damage)
		#queue_free()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() is Enemy && !is_enemies:
		area.get_parent().get_node("Health").damage(damage)
		
		if piercing:
			if (pierced != 0):
				pierced -= 1
				
				var bullet: RigidBody2D = duplicate()
				get_tree().root.get_node("Game").add_child(bullet)
				bullet.damage = damage
				bullet.linear_velocity = Vector2.ZERO
				bullet.animated_sprite.scale = Vector2(2, 2)
				bullet.animated_sprite.play("blood")
				return
			piercing = false
		
		linear_velocity = Vector2.ZERO
		animated_sprite.scale = Vector2(2, 2)
		animated_sprite.play("blood")
		
	if area.get_parent() is Player && is_enemies:
		area.get_parent().get_node("Health").damage(damage)
		
		linear_velocity = Vector2.ZERO
		animated_sprite.scale = Vector2(2, 2)
		animated_sprite.play("blood")

func _on_animated_sprite_2d_animation_finished() -> void:
	if (animated_sprite.get_animation() == "blood" && !piercing):
		queue_free()
	if (animated_sprite.get_animation() == "flash"):
		z_index = 0

extends Node2D

const SPEED = 40

var is_enemies: bool = false
var damage

@onready var timer: Timer = $Timer


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
		queue_free()
	if area.get_parent() is Player && is_enemies:
		area.get_parent().get_node("Health").damage(damage)
		queue_free()

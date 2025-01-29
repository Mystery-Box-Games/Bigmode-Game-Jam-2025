extends CanvasLayer

@onready var game = get_tree().root.get_node("Game").get_node("GameManager")
@onready var health_node = get_tree().root.get_node("Game").get_node("Player").get_node("Health")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	health_node.health = clamp(health_node.health, 0, 100)
	$ProgressBar.value = health_node.health
	
	$Label.text = "Round %s" % (game.round + 1)

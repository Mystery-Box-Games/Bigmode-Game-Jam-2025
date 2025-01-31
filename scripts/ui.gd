extends CanvasLayer

@onready var game = get_tree().root.get_node("Game").get_node("GameManager")
@onready var player = get_tree().root.get_node("Game").get_node("Player")
@onready var health_node = get_tree().root.get_node("Game").get_node("Player").get_node("Health")
@onready var round_text: Label = $RoundText
@onready var brain_text: Label = $VBoxContainer/BrainText
@onready var brain_progress: TextureProgressBar = $VBoxContainer/HBoxContainer/BrainProgress
@onready var reset_progress: ProgressBar = $VBoxContainer/HBoxContainer/ResetProgress


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	health_node.health = clamp(health_node.health, 0, 100)
	$ProgressBar.value = health_node.health
	
	brain_progress.value = player.brain_power
	brain_text.text = "Tier: %s" % player.brain_tier_index
	
	reset_progress.value = (player.get_node("BrainPowerTimer").get_time_left() / player.get_node("BrainPowerTimer").get_wait_time()) * 100
	
	round_text.text = "Round %s" % (game.round + 1)

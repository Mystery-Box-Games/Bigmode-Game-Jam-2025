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
	
	match player.brain_tier_index:
		0:
			brain_progress.max_value = 10
			brain_progress.min_value = 0
		1:
			brain_progress.max_value = 20
			brain_progress.min_value = 10
		2:
			brain_progress.max_value = 30
			brain_progress.min_value = 20
		3:
			brain_progress.max_value = 40
			brain_progress.min_value = 30
		4:
			brain_progress.max_value = 50
			brain_progress.min_value = 40
		5:
			brain_progress.max_value = 50
			brain_progress.min_value = 50
	
	brain_progress.value = player.brain_power
	if (brain_progress.value == brain_progress.max_value && player.brain_power <= 50):
		player.next_tier()
	brain_text.text = "Tier: %s" % player.brain_tier_index
	
	reset_progress.value = (player.get_node("BrainPowerTimer").get_time_left() / player.get_node("BrainPowerTimer").get_wait_time()) * 100
	
	round_text.text = "Round %s" % (game.round + 1)

extends Node2D

@export var enemies_to_defeat: int = 1
var enemies_defeated
var round_over = false
var loading_new_level = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if (Globals.round > 1 && Globals.round % 5  == 0 && get_node("Pickups") != null):
		var weapons = get_node("Pickups").get_children()
		for weapon in weapons:
			if (!weapon.visible):
				weapon.visible = true
	elif (Globals.round > 1 && Globals.round % 5  != 0 && get_node("Pickups") != null):
		var weapons = get_node("Pickups").get_children()
		for weapon in weapons:
			if (weapon.visible):
				weapon.visible = false
	
	if (Globals.enemies_defeated >= enemies_to_defeat && !round_over):
		var spawners = get_node("Spawners").get_children()
		for spawner in spawners:
			spawner.disabled = true
		round_over = true
		
	elif (get_tree().get_nodes_in_group("enemies").size() <= 0 && round_over && !loading_new_level):
		loading_new_level = true
		Globals.enemies_defeated = 0
		get_tree().root.get_node("Game").get_node("GameManager").round_over = true

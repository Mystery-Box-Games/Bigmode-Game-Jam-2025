extends CanvasLayer

# How to create a Custom Mouse Cursor in Godot
# https://www.youtube.com/watch?v=JrQ1-Ea6_KM
# watch this if we don't like the lag of the cursor

@export var empty_cursor: Texture = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_custom_mouse_cursor(empty_cursor, Input.CURSOR_ARROW)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Sprite2D.global_position = $Sprite2D.get_global_mouse_position()

extends CanvasLayer

@onready var round_text: Label = $PanelContainer/VBoxContainer/RoundText
@onready var score_text: Label = $PanelContainer/VBoxContainer/ScoreText

func _process(delta: float) -> void:
	round_text.text = "You reached round %s" % Globals.round
	score_text.text = "Your score was %s" % Globals.score

func _on_button_retry_pressed() -> void:
	Globals.reset()
	get_tree().change_scene_to_packed(Globals.game_scene)

func _on_button_options_pressed() -> void:
	get_tree().change_scene_to_packed(Globals.options_scene)

func _on_button_quit_pressed() -> void:
	Globals.reset()
	get_tree().change_scene_to_packed(Globals.menu_scene)

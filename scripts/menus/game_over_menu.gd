extends CanvasLayer

@onready var round_text: Label = %RoundText
@onready var score_text: Label = %ScoreText
@onready var name_field: LineEdit = %NameField
@onready var submit_button: Button = %SubmitButton
@onready var submitted_text: Label = %SubmittedText

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

# submit button for score and rounds
func _on_submit_button_pressed() -> void:
	if name_field.text == null || name_field.text == "":
		#name_field
		return
		
	# disable name field and button
	name_field.editable = false
	submit_button.disabled = true
	
	Globals.player_name = name_field.text
	var sw_result: Dictionary = await SilentWolf.Scores.save_score(Globals.player_name, Globals.score).sw_save_score_complete
	print("Score persisted successfully: " + str(sw_result.score_id))
	submitted_text.visible = true
	

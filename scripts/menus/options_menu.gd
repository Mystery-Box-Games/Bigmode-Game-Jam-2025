extends Control

@export var master_bus_name := "Master"
@export var music_bus_name := "Music"
@export var sfx_bus_name := "SFX"

@onready var master_bus := AudioServer.get_bus_index(master_bus_name)
@onready var music_bus := AudioServer.get_bus_index(music_bus_name)
@onready var sfx_bus := AudioServer.get_bus_index(sfx_bus_name)

@onready var master_slider: HSlider = $TabContainer/Audio/VBoxContainer/MasterSlider
@onready var music_slider: HSlider = $TabContainer/Audio/VBoxContainer/MusicSlider
@onready var sfx_slider: HSlider = $TabContainer/Audio/VBoxContainer/SFXSlider

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#$CenterContainer/PanelContainer/VBoxContainer/VolumeSlider.grab_focus()
	master_slider.value = db_to_linear(AudioServer.get_bus_volume_db(master_bus))
	music_slider.value = db_to_linear(AudioServer.get_bus_volume_db(music_bus))
	sfx_slider.value = db_to_linear(AudioServer.get_bus_volume_db(sfx_bus))
	

func _on_check_button_toggled(toggled_on: bool) -> void:
	if (toggled_on):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _on_button_back_pressed() -> void:
	get_tree().change_scene_to_file(Globals.prevscene)

func _on_master_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(master_bus, linear_to_db(value))
	
func _on_master_slider_mouse_exited() -> void:
	release_focus()

func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(music_bus, linear_to_db(value))

func _on_music_slider_mouse_exited() -> void:
	release_focus()

func _on_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(sfx_bus, linear_to_db(value))

func _on_sfx_slider_mouse_exited() -> void:
	release_focus()

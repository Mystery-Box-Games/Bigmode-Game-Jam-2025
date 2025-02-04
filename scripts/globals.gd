extends Node

var prevscene = null
var packed_scene: PackedScene

var game_scene = preload("res://scenes/game.tscn")
var menu_scene = preload("res://scenes/menus/main_menu.tscn")
var options_scene = preload("res://scenes/menus/options_menu.tscn")
var credits_scene = preload("res://scenes/menus/credits_menu.tscn")
var leaderboard_scene = preload("res://scenes/menus/leaderboards_menu.tscn")

var player_name: String
var player_list = []
var game_over: bool = false
var round: int = 1
var score: int = 0
var enemies_defeated = 0

func _ready() -> void:
	SilentWolf.configure({
		"api_key": "wd4lwJ08Ib6HG7AN7Jk0Rvuoq2qyVyV2rvDcNa6g",
		"game_id": "KillingHumansforZommies",
		"log_level": 1
	})
	
	SilentWolf.configure_scores({
		"open_scene_on_close": "res://scenes/menus/main_menu.tscn"
	})

func reset():
	round = 1
	score = 0
	prevscene = null
	game_over = false
	enemies_defeated = 0

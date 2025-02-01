extends Node

var prevscene = null
var packed_scene: PackedScene

var game_scene = preload("res://scenes/game.tscn")
var menu_scene = preload("res://scenes/menus/main_menu.tscn")
var options_scene = preload("res://scenes/menus/options_menu.tscn")
var credits_scene = preload("res://scenes/menus/credits_menu.tscn")

var game_over: bool = false
var score: int
var enemies_defeated = 0

func reset():
	score = 0
	prevscene = null
	game_over = false
	enemies_defeated = 0

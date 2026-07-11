extends Node

const START = preload("res://scenes/start.tscn")
const GAME = preload("res://scenes/game.tscn")
const SETTINGS = preload("res://scenes/settings.tscn")
const TUTORIAL = preload("res://scenes/cutscene_tutorial.tscn")

var debug = 1
@onready var viewport = get_viewport().get_visible_rect().size
#@onready var camera = get_tree().$player/Camera2D
var player_node : CharacterBody2D
var fade_node : CanvasLayer
func _process(_delta: float) -> void:
	viewport = get_viewport().get_visible_rect().size
var score = 0

func start_game():
	Engine.time_scale = 1
	get_tree().reload_current_scene()
	score = 0
	

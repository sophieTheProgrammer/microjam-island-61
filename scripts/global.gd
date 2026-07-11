extends Node

const START = preload("res://scenes/start.tscn")
const GAME = preload("res://scenes/game.tscn")
const SETTINGS = preload("res://scenes/settings.tscn")
const TUTORIAL = preload("res://scenes/cutscene_tutorial.tscn")

@onready var viewport = get_viewport().get_visible_rect().size
#@onready var camera = get_tree().$player/Camera2D


func _process(delta: float) -> void:
	viewport = get_viewport().get_visible_rect().size
var score = 0

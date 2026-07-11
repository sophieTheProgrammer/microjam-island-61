extends Node

const START = preload("res://scenes/start.tscn")
const GAME = preload("res://scenes/game.tscn")
const SETTINGS = preload("res://scenes/settings.tscn")
const TUTORIAL = preload("res://scenes/cutscene_tutorial.tscn")

@onready var viewport = get_viewport().get_visible_rect().size
#@onready var camera = get_tree().$player/Camera2D
var player_node : CharacterBody2D

func _process(_delta: float) -> void:
	pass
var score = 0

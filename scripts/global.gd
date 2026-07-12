extends Node

const START = preload("res://scenes/start.tscn")
const GAME = preload("res://scenes/game.tscn")
const SETTINGS = preload("res://scenes/settings.tscn")
const TUTORIAL = preload("res://scenes/cutscene_tutorial.tscn")
const WORLD_CONTAINER = preload("res://scenes/world_container.tscn")

@onready var viewport = get_viewport().get_visible_rect().size
@onready var world_container_node = get_tree().current_scene.get_node("world_container")
var player_node : CharacterBody2D
var fade_node : CanvasLayer
var measure_unit = 1
const DEBUG_DEATH : bool = false

var game_is_running: bool = true

func _process(_delta: float) -> void:
	viewport = get_viewport().get_visible_rect().size
var score = 0

func start_game(reloadWorld):
	score = 0
	Engine.time_scale = 1
	await fade_node.fade(1, .15).finished
	game_is_running = true
	world_container_node = get_tree().current_scene.get_node("world_container")
	world_container_node.queue_free()
	if reloadWorld:
		var world_container = WORLD_CONTAINER.instantiate()
		world_container_node = world_container
		get_tree().current_scene.add_child(world_container)
		await fade_node.fade(0,.15).finished
	else:
		get_tree().change_scene_to_packed(GAME)
		await fade_node.fade(0,.15).finished
		

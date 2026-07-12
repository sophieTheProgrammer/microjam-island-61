extends Node

const START = preload("res://scenes/start.tscn")
const GAME = preload("res://scenes/game.tscn")
const SETTINGS = preload("res://scenes/settings.tscn")
const TUTORIAL = preload("res://scenes/cutscene_tutorial.tscn")
const WORLD_CONTAINER = preload("res://scenes/world_container.tscn")

@onready var viewport = get_viewport().get_visible_rect().size
var player_node : CharacterBody2D
var fade_node : CanvasLayer
var measure_unit = 1
const DEBUG_DEATH : bool = false
var high_score = 0
var game_is_running: bool = false
var chunk_val = 0
func _ready() -> void:
	AudioPlayer.play_music(AudioPlayer.START_SCREEN_SONG, -1)

func _process(_delta: float) -> void:
	viewport = get_viewport().get_visible_rect().size
var score = 0
var attached = false
var is_decreasing = false
var fade = 0
var stamina = 100

func start_game(reloadWorld):
	EventBus.start_game.emit()
	score = 0
	Engine.time_scale = 1
	await fade_node.fade(1, .15).finished
	if reloadWorld:
		var current_world_container = get_tree().current_scene.get_node("world_container")
		print(current_world_container)
		print(get_tree().current_scene.get_children())
		current_world_container.queue_free()
		# remove child removes in within the frame cause queue free waits until the end so i kept both
		get_tree().current_scene.remove_child(current_world_container)
		var new_world_container = WORLD_CONTAINER.instantiate()
		get_tree().current_scene.add_child(new_world_container, true)
		new_world_container.name = "world_container"
		await fade_node.fade(0,.15).finished
		# GAME IS RUNNING NEEDS TO STAY HERE WHEN THE GAME IS RUNNING ACTUALLY STARTS RUNNING
		game_is_running = true
	else:

		get_tree().change_scene_to_packed(GAME)
		await fade_node.fade(0,.15).finished
		
		
var dudeno = false

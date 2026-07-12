extends Area2D

@export var is_whirlpool = false
@export var is_shark = false

func _on_body_entered(_body: Node2D) -> void:
	if !Global.DEBUG_DEATH:
		if is_whirlpool:
			var tween = create_tween()
			_body.look_at(Vector2(global_position))
			tween.set_parallel(true)
			tween.tween_property(_body, "scale", Vector2(0,0),1)
			tween.tween_property(_body, "position", global_position,1)
			print("tweening")
			AudioPlayer.play_sfx(AudioPlayer.SPLASH, -1)
			EventBus.game_over.emit("whirlpool")
		if is_shark:
			EventBus.game_over.emit("shark")
			AudioPlayer.play_sfx(AudioPlayer.CHOMP, -1)
		print("dying shall commence now")

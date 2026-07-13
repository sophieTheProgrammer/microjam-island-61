extends Area2D

@export var is_whirlpool = false
@export var is_shark = false
func _on_body_entered(body: Node2D) -> void:
	if !Global.DEBUG_DEATH:
		if is_whirlpool:
			var tween = create_tween()
			body.look_at(Vector2(global_position))
			tween.set_parallel(true)
			tween.tween_property(body, "scale", Vector2(0,0),1)
			tween.tween_property(body, "position", global_position,1)
			print("tweening")
			AudioPlayer.play_sfx(AudioPlayer.SPLASH, -1)
			EventBus.game_over.emit("whirlpool")
		if is_shark:
			EventBus.game_over.emit("shark")
			AudioPlayer.play_sfx(AudioPlayer.CHOMP, -1)
		print("dying shall commence now")



func _on_area_entered(area: Area2D) -> void:
	if is_whirlpool:
		if self.get_parent().on_screen == true:
			var tween = create_tween()
			var area_parent = area.get_parent()
			area.look_at(Vector2(global_position))
			tween.set_parallel(true)
			tween.tween_property(area_parent, "scale", Vector2(0,0),1)
			tween.tween_property(area_parent, "position", global_position,1)
			print("tweening")
			if area.name == "Area2D":
				EventBus.deattached_log.emit()
			#AudioPlayer.play_sfx(AudioPlayer.SPLASH, -1)
			area.queue_free()

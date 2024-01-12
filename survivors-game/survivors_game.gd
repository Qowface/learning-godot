extends Node2D


func _unhandled_key_input(event):
	if %GameOver.visible and event.is_pressed():
		get_tree().reload_current_scene()


func spawn_mob():
	var new_mob = preload("res://mob.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)


func _on_timer_timeout():
	spawn_mob()


func _on_player_health_depleted():
	%GameOver.visible = true
	%Player.visible = false

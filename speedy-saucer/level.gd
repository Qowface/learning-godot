extends Node2D


func _on_maze_body_exited(body):
	get_tree().reload_current_scene()


func _on_win_area_body_entered(body):
	$Graphics/WinScreen.visible = true
	get_tree().paused = true

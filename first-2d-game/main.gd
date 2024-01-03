extends Node

const DATA_PATH = "user://data.cfg"

@export var mob_scene: PackedScene

var score
var high_score
var new_high_score

var _config = ConfigFile.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	load_high_score()
	$HUD.update_high_score(high_score)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	
	if score > high_score:
		new_high_score = true
		save_high_score(score)
		load_high_score()
		$HUD.update_high_score(high_score)
	
	$HUD.show_game_over(new_high_score)
	
	$Music.stop()
	$DeathSound.play()


func new_game():
	score = 0
	new_high_score = false
	$Player.start($StartPosition.position)
	$StartTimer.start()
	
	get_tree().call_group("mobs", "queue_free")
	
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	
	$Music.play()


func _on_score_timer_timeout():
	score += 1
	
	$HUD.update_score(score)


func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()


func _on_mob_timer_timeout():
	var mob = mob_scene.instantiate()
	
	var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
	mob_spawn_location.progress_ratio = randf()
	
	var direction = mob_spawn_location.rotation + PI / 2
	
	mob.position = mob_spawn_location.position
	
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction
	
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	add_child(mob)


func load_high_score():
	_config.load(DATA_PATH)
	high_score = _config.get_value("scoring", "high_score", 0)


func save_high_score(new_score):
	_config.set_value("scoring", "high_score", new_score)
	_config.save(DATA_PATH)

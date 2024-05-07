extends Node2D


const SAW_BLADE_TELEGRAPH_SCENE = preload("res://saw_blade_telegraph.tscn")


var saw_count = 0


@onready var timer: Timer = $Timer
@onready var spawn_zone: ColorRect = $SpawnZone
@onready var saw_count_label: Label = $SawCountLabel


func _ready():
	spawn_zone.hide()
	timer.timeout.connect(_on_timer_timeout)
	Events.balloon_popped.connect(timer.stop)
	Events.saw_blade_added.connect(update_saw_count)


func update_saw_count():
	saw_count += 1
	saw_count_label.text = "Blades\n" + str(saw_count) 


func _on_timer_timeout():
	var saw_blade_telegraph = SAW_BLADE_TELEGRAPH_SCENE.instantiate()
	var rect = spawn_zone.get_global_rect()
	var saw_x = randf_range(rect.position.x, rect.end.x)
	var saw_y = randf_range(rect.position.y, rect.end.y)
	saw_blade_telegraph.position = Vector2(saw_x, saw_y)
	add_child(saw_blade_telegraph)

extends Node2D


const SAW_SCENE = preload("res://saw_blade.tscn")


var direction = Vector2.RIGHT.rotated(randf_range(0, TAU))


@onready var arrow_sprite_2d: Sprite2D = $ArrowSprite2D
@onready var timer: Timer = $Timer


func _ready():
	arrow_sprite_2d.rotation = direction.angle()
	timer.timeout.connect(_on_timer_timeout)
	Events.balloon_popped.connect(timer.stop)


func _on_timer_timeout():
	Events.saw_blade_added.emit()
	var saw = SAW_SCENE.instantiate()
	saw.position = position
	saw.linear_velocity = direction * 50
	get_tree().current_scene.add_child(saw)
	queue_free()

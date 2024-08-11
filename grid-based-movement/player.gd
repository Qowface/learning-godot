extends Area2D


var tile_size = 64
var inputs = {
	"right": Vector2.RIGHT,
	"left": Vector2.LEFT,
	"up": Vector2.UP,
	"down": Vector2.DOWN
}

var animation_speed = 4
var moving = false

@onready var ray = $RayCast2D


func _ready():
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size / 2


func _process(delta):
	if moving:
		return
	for dir in inputs.keys():
		if Input.is_action_pressed(dir):
			move(dir)


func move(dir):
	ray.target_position = inputs[dir] * tile_size
	ray.force_raycast_update()
	
	moving = true
	$AnimationPlayer.play(dir)
	var tween = create_tween()
	
	if !ray.is_colliding():
		tween.tween_property(self, "position",
			position + inputs[dir] * tile_size,
			1.0 / animation_speed)
	else:
		var start_pos = position
		var end_pos = position + inputs[dir] * (tile_size / 2)
		tween.tween_property(self, "position",
			end_pos,
			0.5 / animation_speed).from(start_pos)
		tween.tween_property(self, "position",
			start_pos,
			0.5 / animation_speed).from(end_pos)
	
	await tween.finished
	moving = false

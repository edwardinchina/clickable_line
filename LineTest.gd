extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var cur_axis = null


# Called when the node enters the scene tree for the first time.
func _ready():
	cur_axis = $StaticBody2D/CollisionPolygon2D/tail
	pass  # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("mouse_left") && cur_axis:
		cur_axis.add_point(get_viewport().get_mouse_position())
		## if Input.is_action_just_released("mouse_left"):
	##	cur_axis = null
	pass

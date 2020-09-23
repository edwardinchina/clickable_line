extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var cur_axis = null


# Called when the node enters the scene tree for the first time.
func _ready():
	var size = get_viewport().size
	$Line2D.set_line([Vector2(size.x / 2, 50), Vector2(size.x / 2, size.y - 50)], 2)
#	$Line2D.set_line([Vector2(0, size.y / 2), Vector2(size.x, size.y / 2)], 1)
	$Line2D2.set_line([Vector2(50, 50), Vector2(size.x / 2, size.y / 2)], 2)
	pass  # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("mouse_left"):
		if $Line2D.is_select:
			cur_axis = $Line2D
		if $Line2D2.is_select:
			cur_axis = $Line2D2
	if Input.is_action_pressed("mouse_left") && cur_axis:
		cur_axis.move_to(get_viewport().get_mouse_position())
	if Input.is_action_just_released("mouse_left"):
		cur_axis = null
	pass

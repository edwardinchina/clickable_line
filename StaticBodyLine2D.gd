extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var points = null
var segments = null

# Called when the node enters the scene tree for the first time.
func _ready():  
	# copy line points to a new polygon
	points = $CollisionPolygon2D/tail.points
	var pol : PoolVector2Array
	pol.append_array(points)
	# recopy all points back to origin
	var n = points.size()
	for i in range(1,n-1):
		pol.append(points[i])
	for i in range(n-1, 0, -1):
		pol.append(points[i]+Vector2(.01,.01))
	$CollisionPolygon2D.polygon = pol
	
	segments = []

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_collision_shape()

func update_collision_shape():
	var n = points.size()
	if n < 2:
		# waiting for a 2nd point to create a segment
		return

	# replace all segments (for now, TODO: optimize the update)
	segments.clear()
	for i in range(n-1):
		segments.append(create_segment(points[i], points[i+1]))

	# re-add all segments: delete old childs and recreate all
	#clear_all_shape(true)
	for s in segments:
			$CollisionPolygon2D.add_child(s)

func clear_all_shape(keep_segments = false):
	for c in $CollisionPolygon2D.get_children():
		c.queue_free()
	if not keep_segments:
		segments.clear()

func create_segment(p1 : Vector2, p2 : Vector2, shorten : int = 0) -> CollisionShape2D:
	var collision = CollisionShape2D.new()
	collision.shape = SegmentShape2D.new()
	collision.shape.a = p1
	collision.shape.b = p2

	if shorten > 0:
		reduce_segment(collision, shorten)
	return collision

func reduce_segment(seg : CollisionShape2D, shorten : int):
	var v = (seg.shape.b  - seg.shape.a).normalized()
	# we calculated the length of the segment, reducing at max of its length
	var d = seg.shape.a.distance_to(seg.shape.b)
	var delta = min(d, shorten)
	var b = seg.shape.b
	b -= v * delta
	seg.shape.b = b

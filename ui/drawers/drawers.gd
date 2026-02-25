extends CanvasLayer


@onready var DistanceMarkers = $DistanceMarkers
@onready var DistancePointers = $DistancePointers
#@onready var AimDrawer = $GridDrawer
#@onready var TrailDrawer = $TrailDrawer


func queue_redraw():
	DistanceMarkers.queue_redraw()
	DistancePointers.queue_redraw()


func get_drawers() -> Array:
	return [DistanceMarkers, DistancePointers]

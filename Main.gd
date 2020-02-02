extends Spatial


# Called when the node enters the scene tree for the first time.
func _ready():
	for element in $Elements.get_children():
		element.connect("scored", $UI, "add_to_score")

extends CanvasLayer

export (PackedScene) var score_scene = null

var score = 0

func add_to_score(value, at):
	score += value
	$Score.text = "Score: " + str(score)
	
	if score_scene:
		var new_score_scene = score_scene.instance()
		new_score_scene.set_score(value)
		add_child(new_score_scene)
		new_score_scene.position = get_viewport().get_camera().unproject_position(at)

extends Label

func _ready() -> void:
	text = String(Global.highscore)

func _process(_delta: float) -> void:
	if Global.highscore <= Global.score:
		text = String(Global.highscore)
		Global.highscore = Global.score

extends CanvasLayer

func _ready() -> void:
	show(false)

func show(is_visible) -> void:
	for node in get_children():
		node.visible = is_visible

	get_tree().paused = is_visible

func _input(event: InputEvent) -> void:
	if event.is_action_pressed('ui_cancel'):
		show(!get_tree().paused)

func _on_continue_button_pressed():
	show(false)

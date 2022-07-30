extends Camera2D

var shake_instensity = 0
var start_shake = false

func _ready() -> void:
	randomize()
	
	Global.camera = self

func _exit_tree() -> void:
	Global.camera = null

func shake_screen(intensity: float, time: float) -> void:
	var intensity_pos = intensity * 0.002

	zoom = Vector2(1, 1) - Vector2(intensity_pos, intensity_pos)

	shake_instensity = intensity

	$camera_timer.wait_time = time
	$camera_timer.start()
	
	start_shake = true

func control_shake(delta: float) -> void:
	zoom = lerp(zoom, Vector2(1, 1), 0.3)

	if start_shake:
		global_position += Vector2(
			rand_range(-shake_instensity, shake_instensity), 
			rand_range(-shake_instensity, shake_instensity)
		) * delta

func _process(delta: float) -> void:
	control_shake(delta)

func _on_camera_timer_timeout():
	start_shake = false

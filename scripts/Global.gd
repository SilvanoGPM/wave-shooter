extends Node

var FILE_PATH = 'user://values.save'
var FILE_PASS = 'PASSWORD'

var global_parent = null
var player = null
var camera = null
var damage_screen = null

var score = 0
var highscore = 0

func instance_node(node, location, parent = global_parent):
	var node_instance = node.instance()
	
	node_instance.global_position = location
	
	parent.add_child(node_instance)

	return node_instance

func stop_node(node) -> void:
	node.set_process(false)
	node.set_physics_process(false)
	node.set_process_input(false)
	node.set_process_internal(false)
	node.set_process_unhandled_input(false)
	node.set_process_unhandled_key_input(false)

func random_pos_in_screen(out_bounds = false) -> Vector2:
	if out_bounds:
		return Vector2(rand_range(-160, 670), rand_range(-90, 390))

	return Vector2(rand_range(0, 640), rand_range(0, 360))

func create_spawnner(elements, parent, pos = random_pos_in_screen()) -> void:
	var random = elements[randi() % elements.size()]

	Global.instance_node(random, pos, parent)

func create_save_dict() -> Dictionary:
	var dict = {
		'highscore': highscore
	}

	return dict

func save_game() -> void:
	var dict = create_save_dict()	
	var file = File.new()
	
	file.open_encrypted_with_pass(FILE_PATH, File.WRITE, FILE_PASS)
	file.store_line(to_json(dict))
	file.close()
	
func load_game() -> void:
	var file = File.new()
	
	if not file.file_exists(FILE_PATH):
		print('Erro ao carregar o arquivo')
		return
		
	file.open_encrypted_with_pass(FILE_PATH, File.READ, FILE_PASS)

	var dict = parse_json(file.get_line())
	
	highscore = dict['highscore']
	
	file.close()

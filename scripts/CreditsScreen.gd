extends Control

func open_in_browser(link: String) -> void:
	OS.shell_open(link)

func _on_creator_pressed():
	open_in_browser('https://www.youtube.com/c/PlugWorld')

func _on_translator_ptBR_pressed():
	open_in_browser('https://www.youtube.com/c/Cl%C3%A9cioEsp%C3%ADndola')

func _on_programmer_pressed():
	open_in_browser('https://github.com/SkyG0D')

func _on_back_button_pressed():
	get_tree().change_scene("res://scenes/StartScreen.tscn")

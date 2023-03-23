extends Control


var short_words : Array
var current_word_index : int = 5
var current_character_index : int = 2

var words : Array

onready var line_edit = $LineEdit


func _ready():
	randomize()
	
	line_edit.grab_focus()
	
	var file = File.new()
	file.open("res://assets/short-words.txt", File.READ)
	var file_content = file.get_as_text()
	short_words = file_content.split("\n")
	file.close()
	
	words = generate_words(30)
	update()


func _input(event):
	if event.is_action_pressed("reset"):
		var _err = get_tree().reload_current_scene()


func _process(delta):
	update()


func update():
	var selected_words : String = ""
	selected_words += "[center]"
	
	# somehow put this ins a callable function
	# also somehow reduce nesting because it's a pain
	# maybe make the character search a function
	
	for word in words:
		var word_index = words.find(word)
		
		if word_index == current_word_index:
			# this is where you put the per color thing
			
			# also kinda forgot what to do with the color part
			var character_index = 0
			for character in word:
				if character_index < current_character_index:
					selected_words += "[color=#cdd6f4]" + character + "[/color]"
				else:
					selected_words += "[color=#45475a]" + character + "[/color]"
				
				character_index += 1
			
			character_index = 0
			selected_words += " "
		elif word_index > current_word_index:
			selected_words += "[color=#45475a]" + word + "[/color] "
		else:
			selected_words += "[color=#cdd6f4]" + word + "[/color] "
	
	selected_words += "[/center]"
	
	$Label.bbcode_text = selected_words


func check_word(input: String):
	print(input)
	pass


func generate_words(length : int):
	words.clear()
	
	for _word in range(length):
		words.append(short_words[randi() % 5460])
	
	return words


func _on_LineEdit_text_changed(new_text):
	if " " in new_text:
		current_word_index += 1
		
		check_word(line_edit.text)
		
		line_edit.clear()
		current_character_index = 0
		
		return
	
	current_character_index += 1

extends Control

onready var text_edit = $TextEdit
onready var converted_text = $ConvertedText
onready var animation_player = $AnimationPlayer
onready var popup = $Popup
onready var popup_timer = $PopupTimer

var colemak_dict : Dictionary = {
	"q": "q",
	"w": "w",
	"e": "f",
	"r": "p",
	"t": "g",
	"y": "j",
	"u": "l",
	"i": "u",
	"o": "y",
	"p": ";",
	"a": "a",
	"s": "r",
	"d": "s",
	"f": "t",
	"g": "d",
	"h": "h",
	"j": "n",
	"k": "e",
	"l": "i",
	";": "o",
	"z": "z",
	"x": "x",
	"c": "c",
	"v": "v",
	"b": "b",
	"n": "k",
	"m": "m",
	"Q": "Q",
	"W": "W",
	"E": "F",
	"R": "P",
	"T": "G",
	"Y": "J",
	"U": "L",
	"I": "U",
	"O": "Y",
	"P": ";",
	"A": "A",
	"S": "R",
	"D": "S",
	"F": "T",
	"G": "D",
	"H": "H",
	"J": "N",
	"K": "E",
	"L": "I",
	":": "O",
	"Z": "Z",
	"X": "X",
	"C": "C",
	"V": "V",
	"B": "B",
	"N": "K",
	"M": "M",

}


func _ready():
	text_edit.grab_focus()


func _input(event):
	if event.is_action_pressed("copy"):
		OS.set_clipboard(converted_text.text)
		converted_text.text = ""
		text_edit.text = ""
		
		popup.popup_centered()
		animation_player.play("popup")
		popup_timer.start()



func _on_PopupTimer_timeout():
	popup.hide()


func _on_TextEdit_text_changed():
	var converted_string : String = ""
	
	for character in text_edit.text:
		if colemak_dict.has(character):
			converted_string += colemak_dict[character]
		else:
			converted_string += character
	
	converted_text.text = converted_string

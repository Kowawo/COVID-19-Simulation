extends LineEdit


var regex = RegEx.new()
var oldtext = ""


func _ready():
	regex.compile("^$|^[0]{1}[,.]{1}[0-9]*$|^[0]{1}$|^[1-9]+[,.]?[0-9]*$")


func _on_LineEdit2_text_changed(new_text):
	if (regex.search(new_text)):
		text = new_text
		oldtext = text
	else:
		text = oldtext
		
	set_cursor_position(text.length())

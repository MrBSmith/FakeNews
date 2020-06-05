extends AutoloadBase

onready var translations_path_array = ProjectSettings.get_setting("locale/translations")

var current_translation : Translation setget set_current_translation, get_current_translation

var default_locale : String = "en"

#### ACCESSORS ####

func set_current_translation(value: Translation):
	current_translation = value


func get_current_translation():
	return current_translation


func get_dialogue_key(index: int) -> String:
	var scene_name = get_tree().get_current_scene().get_name()
	scene_name = scene_name.to_upper()
	var key : String = "DIAL_" + scene_name + "_" + String(index)
	print_notification(key)
	return key


func get_answer_key(dial_index : int, answer_id: int) -> String:
	return get_dialogue_key(dial_index) + "_" + String(answer_id)

#### BUILT-IN ####

func _ready():
	#debug = true
	TranslationServer.set_locale(default_locale)
	set_current_translation_by_locale(default_locale)


#### LOGIC ####

func set_current_translation_by_locale(locale: String):
	TranslationServer.set_locale(locale)
	current_translation = get_translation_by_locale(locale)


func get_translation_by_locale(locale: String) -> Translation:
	for path in translations_path_array:
		var trans = load(path)
		if trans.get_locale() == locale:
			return trans
	return null

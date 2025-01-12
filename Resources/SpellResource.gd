extends Resource

class_name SpellResource 

enum spellclass {
	MAGE = 1,
	WARRIOR = 2
}

@export var spellClass: spellclass = 1
@export var spellIcon: CompressedTexture2D

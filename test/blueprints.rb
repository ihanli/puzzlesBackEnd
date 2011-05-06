require 'machinist/active_record'
require 'sham'
require 'faker'

Sham.title  { Faker::Name.name }

AbstractCard.blueprint do
  name { "intergalactic proton powered electric advertising droid" }
  description { "some description" }
  path_to_img { "path/img.png" }
  loading { 0 }
  mana { 0 }
end

Spell.blueprint do
  duration { -1 }
  abstract_card_id { 1 }
end

Unit.blueprint do
  attack { 0 }
  health { 0 }
  abstract_card_id { 1 }
end

Deck.blueprint do
	name { "my hero master deck" }
end

User.blueprint do
	fb_id { 2655 }
	experience { 1872 }
end

Fighter.blueprint do
  battle_id { 1 }
  user_id { 1 }
end

Battle.blueprint do
  
end

Card.blueprint do
	puzzles { 3 }
	abstract_card_id { 24 }
	user_id { 2655 }
end

CardInGame.blueprint do
  card_id { 1 }
  fighter_id { 1 }
end


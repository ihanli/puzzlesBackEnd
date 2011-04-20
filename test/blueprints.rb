require 'machinist/active_record'
require 'sham'
require 'faker'

Sham.title  { Faker::Name.name }

AbstractCard.blueprint do
  name { "intergalact proton powered electric advertising droid" }
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
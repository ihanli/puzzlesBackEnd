cards.each do |card|
  xml.Card{
    xml.id(card.id)
    xml.type(card.class_name)
    xml.targetID(card.target_id)
    xml.targetType(card.target_type)
    xml.name(card.name)
    xml.loading(card.loading)
    xml.image(card.path_to_img)
    xml.description(card.description)
    xml.talent(card.talent)
    xml.mana(card.mana)

   xml.state(card.state) if card.inactive? || card.attacking?

    if card.class_name == 'Unit'
      xml.attack(card.attack)
      xml.health(card.health)
    else
      xml.duration(card.duration)
    end
  }
end
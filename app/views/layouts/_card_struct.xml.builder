cards.each do |card|
  card_type = card.abstract_card.unit ? card.abstract_card.unit.class.name : card.abstract_card.spell.class.name

  xml.Card{
    xml.id(card.id)
    xml.type(card_type)
    xml.name(card.abstract_card.name)
    xml.loading(card.abstract_card.loading)
    xml.image(card.abstract_card.path_to_img)
    xml.description(card.abstract_card.description)
    xml.talent(card.abstract_card.talent)
    xml.mana(card.abstract_card.mana)
    
    if card.abstract_card.unit
      xml.attack(card.abstract_card.unit.attack)
      xml.health(card.abstract_card.unit.health)
    else
      xml.duration(card.abstract_card.spell.duration)
    end
  }
end
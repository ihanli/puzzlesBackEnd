cards.each do |card_in_game|
  card_type = card_in_game.card.abstract_card.unit ? card_in_game.card.abstract_card.unit.class.name : card_in_game.card.abstract_card.spell.class.name

  xml.Card(:state => (card_in_game.inactive? || card_in_game.attacking?) ? card_in_game.state : ""){
    xml.id(card_in_game.card.id)
    xml.type(card_type)
    xml.targetType(card_in_game.card.abstract_card.target_type)
    xml.name(card_in_game.card.abstract_card.name)
    xml.loading(card_in_game.card.abstract_card.loading)
    xml.image(card_in_game.card.abstract_card.path_to_img)
    xml.description(card_in_game.card.abstract_card.description)
    xml.talent(card_in_game.card.abstract_card.talent)
    xml.mana(card_in_game.card.abstract_card.mana)
    
    if card_in_game.card.abstract_card.unit
      xml.attack(card_in_game.card.abstract_card.unit.attack)
      xml.health(card_in_game.card.abstract_card.unit.health)
    else
      xml.duration(card_in_game.card.abstract_card.spell.duration)
    end
  }
end
cards.each do |card|
  xml.Card(:id => card.id, :class => card.class.name, :name => card.name, :loading => card.loading){
    xml.image(card.path_to_img)
    xml.description(card.description)
    xml.talent(card.talent)
    xml.mana(card.mana)
        
    if card.class.name == 'Unit'
      xml.attack(card.attack)
      xml.health(card.health)
    else
      xml.duration(card.duration)
    end
  }
end
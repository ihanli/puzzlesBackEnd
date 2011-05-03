xml.instruct!
xml.BattleList do
  @battles.each do |battle|
    xml.Battle(:id => battle.id){
      battle.fighters.each do |fighter|
        xml.Fighter(:status => fighter.state){
          xml.fb_id(fighter.user.fb_id)
          xml.experience(fighter.user.experience)
        }
      end
    }
  end
end
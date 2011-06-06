xml.instruct!
xml.BattleList do
  @battles.each do |battle|
    xml.Battle(:id => battle.id){
      battle.fighters.reverse! if battle.fighters[1].fbid == session[:fbid]
      battle.fighters.each do |fighter|
        xml.Fighter(:status => fighter.state){
          xml.fb_id(fighter.fbid)
          xml.experience(fighter.experience)
        }
      end
    }
  end
end
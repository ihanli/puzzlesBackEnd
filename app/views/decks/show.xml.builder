xml.instruct!
xml << render(:partial => 'layouts/deck_struct', :locals => { :deck => @deck, :cards => @deck.cards })
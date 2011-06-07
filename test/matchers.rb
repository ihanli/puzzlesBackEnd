class TransitionFromThroughMatcher
  def initialize(from, event)
    @init_state = from
    @event = event
  end

  def matches?(subject)
    @class_name = subject.class.name
    subject.state = @init_state
    subject.save
    subject.send("#{@event}!")
#   FIXME: vicious lines! only needed if you want to transition from initial state. but why?!?!?!
    subject.cast! if @event == "cast"
    subject.destroy! if @event == "destroy"
    subject.draw! if @event == "draw"
    subject.summon! if @event == "summon"
    subject.remove! if @event == "remove"
    subject.occupy! if @event == "occupy"

    subject.state != @init_state
  end

  def failure_message
    "Expected #{@class_name} to transition from #{@init_state} through .#{@event}!, but it didn't"
  end

  def negative_failure_message
    "Didn't expect #{@class_name} to change state from #{@init_state} through .#{@event}!, but it did"
  end
  
  def description
    "transition from #{@init_state} through .#{@event}!"
  end
end
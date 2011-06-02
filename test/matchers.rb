class TransitionFromThroughMatcher
  def initialize(from, event)
    @init_state = from
    @event = event
  end

  def matches?(subject)
    @class_name = subject.class.name
    subject.state = @init_state
    subject.send("#{@event}!")
#   FIXME: vicious lines! only needed if you want to transition from specific states. but why?!?!?!
    subject.get_ready! if @event == "get_ready"
    subject.occupy! if @event == "occupy"
    subject.draw! if @event == "draw"
    subject.finish! if @event == "finish"
    subject.place! if @event == "place"
    subject.proceed! if @event == "proceed"
    subject.wait! if @event == "wait"

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
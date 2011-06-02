require 'test_helper'

class AbstractCardTest < ActiveSupport::TestCase
  should validate_presence_of(:name)
  should validate_presence_of(:description)
  should validate_presence_of(:path_to_img)
  should validate_presence_of(:loading)
  should validate_presence_of(:mana)
  should validate_presence_of(:target_type)

  should "validate creation of valid object" do
    assert_valid AbstractCard.make_unsaved
  end

  should "validate description length" do
    assert !AbstractCard.make_unsaved(:description => "").valid?
  end

  should "validate format of image path" do
    assert !AbstractCard.make_unsaved(:path_to_img => "without_extension").valid?
  end

  should "validate min length of image path" do
    assert !AbstractCard.make_unsaved(:path_to_img => "bb").valid?
  end

  should "validate min mana" do
    assert !AbstractCard.make_unsaved(:mana => -1).valid?
  end

  should "validate loading range" do
    assert !AbstractCard.make_unsaved(:loading => 6).valid?
  end

  should "validate uniqueness of name" do
    abstract_card_one = AbstractCard.create(AbstractCard.plan)
    assert !AbstractCard.make_unsaved(:name => abstract_card_one.name).valid?
  end
end

require 'rails_helper'

RSpec.describe Friend, type: :model do

  subject do
    build(:friend)
  end

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:user) }
  it { should belong_to(:user) }

end

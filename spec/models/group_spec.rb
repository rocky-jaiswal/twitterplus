require 'rails_helper'

RSpec.describe Group, type: :model do

  subject do
    build(:group)
  end

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:user) }
  it { should belong_to(:user) }

  context 'validation' do

    let(:user) do
      create(:user)
    end

    it 'does not allow two groups with the same name for a user' do
      expect { user.groups.create!(name: 'foo') }.not_to raise_exception
      expect { user.groups.create!(name: 'foo') }.to raise_exception
      expect { user.groups.create!(name: 'Foo') }.to raise_exception
    end

  end

end

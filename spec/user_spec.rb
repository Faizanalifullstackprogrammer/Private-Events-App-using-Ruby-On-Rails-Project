require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    described_class.new(name: '')
  end

  describe 'Associations' do
    it { should have_many(:events).with_foreign_key(:user_id).class_name(:Event) }
    it { should have_many(:attendances).with_foreign_key(:attendee_id) }
    it { should have_many(:attended_events).through(:attendances).class_name(:Event) }
  end

  describe 'Validations' do
    it 'is not valid without name' do
      subject.name = nil
      expect(subject).to_not be_valid
    end
  end
end

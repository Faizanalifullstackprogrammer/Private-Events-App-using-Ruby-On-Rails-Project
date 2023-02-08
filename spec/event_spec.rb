require 'rails_helper'

RSpec.describe Event, type: :model do
  subject do
    described_class.new(title: '',
                        description: '',
                        date: DateTime.now,
                        location: '')
  end

  describe 'Validations' do
    it 'is valid for the validation control' do
      expect(subject).to_not be_valid
    end

    it 'is not valid without title' do
      subject.title = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without description' do
      subject.description = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without location' do
      subject.location = nil
      expect(subject).to_not be_valid
    end
  end

  describe 'Associations' do
    it { should belong_to(:creator).class_name(:User) }
    it { should have_many(:attendances).with_foreign_key(:attended_event_id) }
    it { should have_many(:attendees).through(:attendances).class_name(:User) }
  end
end

require 'rails_helper'

RSpec.describe Attendance, type: :model do
  let(:user) { User.new(name: '') }
  let(:event) do
    Event.new(
      title: '',
      description: '',
      date: '',
      location: '',
      creator: user
    )
  end

  subject do
    described_class.new(attended_event: event, attendee: user)
  end

  describe 'Associations' do
    it { should belong_to(:attendee).class_name(:User) }
    it { should belong_to(:attended_event).class_name(:Event) }
  end

  describe 'Validation' do
    context 'when user is nil' do
      it 'is not valid' do
        subject.attendee = nil
        expect(subject.valid?).to be(false)
      end
    end

    context 'when event is nil' do
      it 'is not valid' do
        subject.attended_event = nil
        expect(subject.valid?).to be(false)
      end
    end

    it 'insert into database' do
      expect(subject.save).to be(true)
    end
  end
end

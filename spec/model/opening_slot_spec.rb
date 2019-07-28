require 'rails_helper'

RSpec.describe OpeningSlot, type: :model do
  existing_opening_slot = OpeningSlot.last
  opening_slot = existing_opening_slot.nil? ? FactoryBot.create(:opening_slot) : existing_opening_slot

  # to_s
  it 'responds to to_s with its id' do
    expect(opening_slot.to_s).to eq(opening_slot.id)
  end

  # opening_hours

  it 'reponds to opening_hours' do
    expect(opening_slot.opening_hours).not_to be_empty
  end

  it 'reponds to opening_hours with the correct string' do
    expected_opening_hours = if opening_slot.opening_at.to_s.length <= 3
      opening_slot.opening_at.to_s[0]
    else
      opening_slot.opening_at.to_s[0..1]
    end

    expect(opening_slot.opening_hours).to eq(expected_opening_hours)
  end

  # opening_minutes

  it 'reponds to opening_minutes' do
    expect(opening_slot.opening_minutes).not_to be_empty
  end

  it 'reponds to opening_minutes with the correct string' do
    expected_opening_minutes = opening_slot.opening_at.to_s[-2..-1]

    expect(opening_slot.opening_minutes).to eq(expected_opening_minutes)
  end

  # closing_hours

  it 'reponds to closing_hours' do
    expect(opening_slot.closing_hours).not_to be_empty
  end

  it 'reponds to closing_hours with the correct string' do
    expected_closing_hours = if opening_slot.closing_at.to_s.length <= 3
      opening_slot.closing_at.to_s[0]
    else
      opening_slot.closing_at.to_s[0..1]
    end

    expect(opening_slot.closing_hours).to eq(expected_closing_hours)
  end

  # closing_minutes

  it 'reponds to closing_minutes' do
    expect(opening_slot.closing_minutes).not_to be_empty
  end

  it 'reponds to closing_minutes with the correct string' do
    expected_closing_minutes = opening_slot.closing_at.to_s[-2..-1]

    expect(opening_slot.closing_minutes).to eq(expected_closing_minutes)
  end

  # readable_opening_at

  it 'reponds to readable_opening_at' do
    expect(opening_slot.readable_opening_at).not_to be_empty
  end

  it 'reponds to readable_opening_at with the correct string' do
    expected_string = [opening_slot.opening_hours, opening_slot.opening_minutes].join(':')

    expect(opening_slot.readable_opening_at).to eq(expected_string)
  end

  # readable_closing_at

  it 'reponds to readable_closing_at' do
    expect(opening_slot.readable_closing_at).not_to be_empty
  end

  it 'reponds to readable_closing_at with the correct string' do
    expected_string = [opening_slot.closing_hours, opening_slot.closing_minutes].join(':')

    expect(opening_slot.readable_closing_at).to eq(expected_string)
  end

  # readable_time

  it 'reponds to readable_time' do
    expect(opening_slot.readable_time).not_to be_empty
  end

  it 'reponds to readable_time with the correct string' do
    expected_string = [opening_slot.readable_opening_at, opening_slot.readable_closing_at].join('—')

    expect(opening_slot.readable_time).to eq(expected_string)
  end


end

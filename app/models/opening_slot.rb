# frozen_string_literal: true.
##
# OpeningSlot is the model containing all time relative infos of the +Shop+.
# @since v1
#
class OpeningSlot < ApplicationRecord
  belongs_to :shop

  serialize :days_of_week, Array

  before_save :clean_days_of_week!

  # String version of the instance (using +id+).
  # @return [String]
  #
  alias_attribute :to_s, :id

  # Readable version of +days_of_week+.
  # @return [String]
  #
  def readable_days_of_week(join_string = ', ')
    days_of_week.map do |day_index|
      I18n.t('date.day_names')[day_index].humanize
    end.join(join_string)
  end

  # Hours part of +opening_at+.
  # @return [String]
  #
  def opening_hours
    return opening_at.to_s[0] if opening_at.to_s.length <= 3
    opening_at.to_s[0..1]
  end

  # Minutes part of +opening_at+.
  # @return [String]
  #
  def opening_minutes
    opening_at.to_s[-2..-1]
  end

  # Hours part of +closing_at+.
  # @return [String]
  #
  def closing_hours
    return closing_at.to_s[0] if closing_at.to_s.length <= 3
    closing_at.to_s[0..1]
  end

  # Minutes part of +closing_at+.
  # @return [String]
  #
  def closing_minutes
    closing_at.to_s[-2..-1]
  end

  # Readable version of +opening_at+ (using +opening_hours+ & +opening_minutes+).
  # @return [String]
  #
  def readable_opening_at(join_string = ':')
    [opening_hours, opening_minutes].join(join_string)
  end

  # Readable version of +closing_at+ (using +opening_hours+ & +opening_minutes+).
  # @return [String]
  #
  def readable_closing_at(join_string = ':')
    [closing_hours, closing_minutes].join(join_string)
  end

  protected

  # Check & set the values included in +days_of_week+
  # @return [Enumerator<Integer>]
  #
  def clean_days_of_week!
    self.days_of_week = days_of_week.map do |d|
      d.to_i unless d.empty?
    end.select do |d|
      (0..6).include?(d)
    end.uniq
  end
end

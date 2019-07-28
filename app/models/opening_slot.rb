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

  # Combine +readable_opening_at+ & +readable_closing_at+.
  # @return [String]
  # @see readable_opening_at
  # @see readable_closing_at
  #
  def readable_time(join_string = '—')
    [readable_opening_at, readable_closing_at].join(join_string)
  end

  class << self

    # Class method grouping all instances by the +days_of_week+ they cover.
    # @return [Hash]
    # @see days_of_week
    #
    def by_weekday
      concerned_opening_slots = all.order(:opening_at).to_a
      output = {}

      (0..6).each do |day|
        output[day] = concerned_opening_slots.select do |instance|
          instance.days_of_week.include?(day)
        end
      end
      output
    end

    # Class method returning the +readable_time+ of each instance grouped by +by_weekday+.
    # @return [Hash]
    # @see by_weekday
    #
    def readable_time_by_weekday(join_string = ', ')
      concerned_opening_slots = all.by_weekday
      output = {}

      (0..6).each do |day_index|
        hours_of_the_day = concerned_opening_slots[day_index].map do |instance|
          instance.readable_time
        end.join(join_string)

        output[day_index] = hours_of_the_day.empty? ? I18n.t('shared.notice.closed').humanize : hours_of_the_day
      end
      output
    end
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

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

  protected

  # Check & set the values included in +days_of_week+
  # @return [Enumerator<Integer>]
  #
  def clean_days_of_week!
    self.days_of_week = days_of_week.map{ |d| d.to_i }
                                    .select{ |d| (0..6).include?(d) }
                                    .uniq
  end
end
